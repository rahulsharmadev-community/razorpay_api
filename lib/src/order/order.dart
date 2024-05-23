import 'dart:convert';

import 'package:razorpay_api/razorpay_api.dart';

class RazorPayOrder {
  RazorPayOrder({
    required this.amount,
    required this.currency,
    this.receipt,
    this.notes,
    this.partialPayment = false,
    this.firstPaymentMinAmount,
  });

  final double amount;

  /// ISO code for the currency [list](https://razorpay.com/docs/international-payments/#supported-currencies)
  final RazorpayCurrency currency;

  /// Can have a maximum length of 40 characters and has to be unique.
  final String? receipt;

  /// Key-value pair that can be used to store additional information about the entity. Maximum 15 key-value pairs, 256 characters (maximum) each.
  final Map<String, dynamic>? notes;

  /// Indicates whether the customer can make a partial payment.
  ///
  /// (default) partialPayment = **false**
  final bool partialPayment;

  ///Minimum amount that must be paid by the customer as the first partial payment.
  ///
  /// For example, if an amount of ₹7,000 is to be received from the customer in two installments of
  /// #1 - ₹5,000, #2 - ₹2,000, then you can set this value as 500000. This parameter should be passed only
  ///  if partial_payment is true.
  final int? firstPaymentMinAmount;

  RazorPayOrder copyWith({
    double? amount,
    RazorpayCurrency? currency,
    String? receipt,
    Map<String, dynamic>? notes,
    bool? partialPayment,
    int? firstPaymentMinAmount,
  }) =>
      RazorPayOrder(
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        receipt: receipt ?? this.receipt,
        notes: notes ?? this.notes,
        partialPayment: partialPayment ?? this.partialPayment,
        firstPaymentMinAmount: firstPaymentMinAmount ?? this.firstPaymentMinAmount,
      );

  factory RazorPayOrder.fromJson(String str) => RazorPayOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RazorPayOrder.fromMap(Map<String, dynamic> map) => RazorPayOrder(
        amount: map["amount"] / 100,
        currency: RazorpayCurrency.values.byName(map["currency"]),
        receipt: map["receipt"],
        notes: map["notes"] != null ? Map.from(map["notes"]) : null,
        partialPayment: map["partial_payment"],
        firstPaymentMinAmount: map["first_payment_min_amount"],
      );

  Map<String, dynamic> toMap() => {
        "amount": (amount * 100).toInt(),
        "currency": currency.name,
        "partial_payment": partialPayment,
        if (receipt != null) "receipt": receipt,
        if (notes != null) "notes": notes,
        if (firstPaymentMinAmount != null) "first_payment_min_amount": firstPaymentMinAmount,
      };
}
