import 'dart:convert';
import '../helper.dart';

class RazorPayOrderResponse {
  RazorPayOrderResponse({
    required this.id,
    required this.amount,
    required this.currency,
    required this.createdAt,
    this.amountPaid,
    this.amountDue,
    this.receipt,
    this.offerId,
    this.offers,
    this.status,
    this.attempts,
    this.notes,
  });

  final String id;
  final double amount;
  final DateTime createdAt;

  /// ISO code for the currency [list](https://razorpay.com/docs/international-payments/#supported-currencies)
  final String currency;

  /// The amount paid against the order.
  final int? amountPaid;

  /// The amount pending against the order.
  final int? amountDue;

  /// Receipt number that corresponds to this order
  final String? receipt;

  final String? offerId;

  final List<String>? offers;

  /// - **created**: When you create an order it is in the created state. It stays in this state till a payment is attempted on it.
  ///
  /// - **attempted**: An order moves from created to attempted state when a payment is first attempted on it.
  ///     It remains in the attempted state till one payment associated with that order is captured.
  ///
  /// - **paid**: After the successful capture of the payment, the order moves to the paid state. No further payment requests
  ///     are permitted once the order moves to the paid state. The order stays in the paid state even if the payment
  ///     associated with the order is refunded.
  final String? status;

  /// The number of payment attempts, successful and failed, that have been made against this order.
  final int? attempts;
  final Map<String, dynamic>? notes;

  RazorPayOrderResponse copyWith({
    String? id,
    double? amount,
    int? amountPaid,
    int? amountDue,
    String? currency,
    String? receipt,
    String? offerId,
    List<String>? offers,
    String? status,
    int? attempts,
    Map<String, dynamic>? notes,
    DateTime? createdAt,
  }) =>
      RazorPayOrderResponse(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        amountPaid: amountPaid ?? this.amountPaid,
        amountDue: amountDue ?? this.amountDue,
        currency: currency ?? this.currency,
        receipt: receipt ?? this.receipt,
        offerId: offerId ?? this.offerId,
        offers: offers ?? this.offers,
        status: status ?? this.status,
        attempts: attempts ?? this.attempts,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
      );

  factory RazorPayOrderResponse.fromJson(String str) => RazorPayOrderResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RazorPayOrderResponse.fromMap(Map<String, dynamic> map) => RazorPayOrderResponse(
        id: map["id"],
        amount: (map["amount"] as int).fromRazorPayAmount,
        amountPaid: map["amount_paid"],
        amountDue: map["amount_due"],
        currency: map["currency"],
        receipt: map["receipt"],
        offerId: map["offer_id"],
        status: map["status"],
        attempts: map["attempts"],
        notes: map["notes"] != null ? Map.from(map["notes"]) : null,
        createdAt: DateTime.fromMillisecondsSinceEpoch((map["created_at"] as int) * 1000),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "amount": amount,
        "currency": currency,
        "offer_id": offerId,
        "created_at": createdAt.millisecondsSinceEpoch / 1000,
        if (amountPaid != null) "amount_paid": amountPaid,
        if (amountDue != null) "amount_due": amountDue,
        if (receipt != null) "receipt": receipt,
        if (status != null) "status": status,
        if (attempts != null) "attempts": attempts,
        if (notes != null) "notes": notes,
      };
}
