import 'dart:convert';
import '../helper.dart';
import '../currencies.dart';

enum RefundStatus {
  pending,
  processed,
  failed,
}

class RazorPayRefundResponse {
  String id;
  String entity;
  double amount;
  String? receipt;
  RazorpayCurrency currency;
  String paymentId;
  Map<String, dynamic>? notes;

  /// A dynamic array consisting of a unique reference number (either RRN, ARN or UTR) that is provided
  /// by the banking partner when a refund is processed. This reference number can be used by the
  /// customer to track the status of the refund with the bank.
  Map<String, dynamic> acquirerData;

  DateTime createdAt;

  String? batchId;

  /// Indicates the state of the refund. Possible values:
  ///
  /// - pending: This state indicates that Razorpay is attempting to process the refund.
  /// - processed: This is the final state of the refund.
  /// - failed: A refund can attain the failed state in the following scenarios:
  ///      - Normal refund is not possible for a payment which is more than 6 months old.
  ///      - Instant Refund can sometimes fail because of customer's account or bank-related issues.
  ///
  RefundStatus status;

  /// This is a parameter in the response which describes the mode used to process a refund.
  /// This attribute is seen in the refund response only if the speed parameter is set in the refund request. Possible values:
  /// - instant: Indicates that the refund has been processed instantly via fund transfer.
  /// - normal: Indicates that the refund has been processed by the payment processing partner. The refund will take 5-7 working days.
  String speedProcessed;

  /// The processing mode of the refund seen in the refund response.
  /// This attribute is seen in the refund response only if the speed parameter is set in the refund request.
  /// Possible values:
  /// - normal: Indicates that the refund will be processed via the normal speed. The refund will take 5-7 working days.
  /// - optimum: Indicates that the refund will be processed at an optimal speed based on Razorpay's internal fund transfer logic.
  ///    - If the refund can be processed instantly, Razorpay will do so, irrespective of the payment method used to make the payment.
  ///    - If an instant refund is not possible, Razorpay will initiate a refund that is processed at the normal speed.
  String speedRequested;

  RazorPayRefundResponse({
    required this.id,
    required this.entity,
    required this.amount,
    required this.receipt,
    required this.currency,
    required this.paymentId,
    required this.notes,
    required this.acquirerData,
    required this.createdAt,
    required this.batchId,
    required this.status,
    required this.speedProcessed,
    required this.speedRequested,
  });

  RazorPayRefundResponse copyWith({
    String? id,
    String? entity,
    double? amount,
    String? receipt,
    RazorpayCurrency? currency,
    String? paymentId,
    Map<String, dynamic>? notes,
    Map<String, dynamic>? acquirerData,
    DateTime? createdAt,
    String? batchId,
    RefundStatus? status,
    String? speedProcessed,
    String? speedRequested,
  }) {
    return RazorPayRefundResponse(
      id: id ?? this.id,
      entity: entity ?? this.entity,
      amount: amount ?? this.amount,
      receipt: receipt ?? this.receipt,
      currency: currency ?? this.currency,
      paymentId: paymentId ?? this.paymentId,
      notes: notes ?? this.notes,
      acquirerData: acquirerData ?? this.acquirerData,
      createdAt: createdAt ?? this.createdAt,
      batchId: batchId ?? this.batchId,
      status: status ?? this.status,
      speedProcessed: speedProcessed ?? this.speedProcessed,
      speedRequested: speedRequested ?? this.speedRequested,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entity': entity,
      'amount': amount.toRazorPayAmount,
      'receipt': receipt,
      'currency': currency.name,
      'payment_id': paymentId,
      'notes': notes,
      'acquirer_data': acquirerData,
      'created_at': createdAt.millisecondsSinceEpoch,
      'batch_id': batchId,
      'status': status.name,
      'speed_processed': speedProcessed,
      'speed_requested': speedRequested,
    };
  }

  factory RazorPayRefundResponse.fromString(String json) => RazorPayRefundResponse.fromJson(jsonDecode(json));

  factory RazorPayRefundResponse.fromJson(Map<String, dynamic> json) {
    return RazorPayRefundResponse(
      id: json['id'],
      entity: json['entity'],
      amount: (json['amount'] as int).fromRazorPayAmount,
      receipt: json['receipt'],
      currency: RazorpayCurrency.values.byName(json['currency']),
      paymentId: json['payment_id'],
      notes: json['notes'],
      acquirerData: json['acquirer_data'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
      batchId: json['batch_id'],
      status: RefundStatus.values.byName(json['status']),
      speedProcessed: json['speed_processed'],
      speedRequested: json['speed_requested'],
    );
  }

  @override
  String toString() =>
      "RefundResponse(id: $id,entity: $entity,amount: $amount,receipt: $receipt,currency: $currency,paymentId: $paymentId,notes: $notes,acquirerData: $acquirerData,createdAt: $createdAt,batchId: $batchId,status: $status,speedProcessed: $speedProcessed,speedRequested: $speedRequested)";

  @override
  int get hashCode => Object.hash(id, entity, amount, receipt, currency, paymentId, notes, acquirerData,
      createdAt, batchId, status, speedProcessed, speedRequested);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RazorPayRefundResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          entity == other.entity &&
          amount == other.amount &&
          receipt == other.receipt &&
          currency == other.currency &&
          paymentId == other.paymentId &&
          notes == other.notes &&
          acquirerData == other.acquirerData &&
          createdAt == other.createdAt &&
          batchId == other.batchId &&
          status == other.status &&
          speedProcessed == other.speedProcessed &&
          speedRequested == other.speedRequested;
}
