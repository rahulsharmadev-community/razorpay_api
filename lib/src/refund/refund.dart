import '../helper.dart';

class RazorPayRefund {
  /// The amount to be refunded. Amount should be in the smallest unit of the currency in which the payment was made.
  ///   - For a partial refund, enter a value lesser than the payment amount. For example, if the payment amount is ₹1,500.00 and you want to refund only ₹500.00, you must pass 50000.
  ///   - For full refund, enter the entire payment amount. If the amount parameter is not passed, the entire payment amount will be refunded.
  final int? amount;

  /// This is a parameter in the response which describes the mode used to process a refund.
  /// This attribute is seen in the refund response only if the speed parameter is set in the refund request. Possible values:
  /// - instant: Indicates that the refund has been processed instantly via fund transfer.
  /// - normal: Indicates that the refund has been processed by the payment processing partner. The refund will take 5-7 working days.
  final String? speed;

  final Map<String, dynamic>? notes;

  final String? receipt;

  RazorPayRefund({this.amount, this.speed, this.notes, this.receipt});

  Map<String, dynamic> toJson() => {
        if (amount != null) 'amount': amount?.fromRazorPayAmount,
        if (speed != null) 'speed': speed,
        if (notes != null) 'notes': notes,
        if (receipt != null) 'receipt': receipt,
      };
}
