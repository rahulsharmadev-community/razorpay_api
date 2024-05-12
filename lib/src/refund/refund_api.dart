import 'dart:convert';

import '/razorpay_api.dart';

import 'package:http/http.dart' as http;

class RazorPayRefundAPI {
  final String _base;
  const RazorPayRefundAPI() : _base = 'https://api.razorpay.com/v1';

  Future<RazorPayRefundResponse?> createRefund(
      {required RazorPayRefund refund, required String paymentId}) async {
    try {
      final orderUri = Uri.parse('$_base/payments/$paymentId/refund');
      http.Response response = await http.post(orderUri, body: refund.toJson(), headers: RazorPayAPI.headers);
      if (response.statusCode == 200) {
        return RazorPayRefundResponse.fromString(response.body);
      }
      return null;
    } on RazorPayErrorResponse {
      rethrow;
    }
  }

  /// ## Query Parameters
  ///
  /// - **from:** Timestamp (in Unix format) from when the orders should be fetched.
  ///
  /// - **to:** Timestamp (in Unix format) up till when orders are to be fetched.
  ///
  /// - **count:** The number of orders to be fetched. The default value is 10. The maximum value is 100. This can be used for pagination, in combination with skip.
  ///
  /// - **skip:** The number of refunds to be skipped.
  ///
  Future<List<RazorPayRefundResponse>?> fetchAllRefundsForPaymentId({
    required String paymentId,
    DateTime? from,
    DateTime? to,
    int? count,
    int? skip,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {
        if (from != null) 'from': from.millisecondsSinceEpoch,
        if (to != null) 'to': to.millisecondsSinceEpoch,
        if (count != null) 'count': count,
        if (skip != null) 'skip': skip,
      };
      final orderUri =
          Uri.parse('$_base/payments/$paymentId/refunds').replace(queryParameters: queryParameters);
      http.Response response = await http.get(orderUri, headers: RazorPayAPI.headers);
      if (response.statusCode == 200) {
        var items = List.from(jsonDecode(response.body)['items']);
        return items.map((e) => RazorPayRefundResponse.fromJson(e)).toList();
      }
      return null;
    } on RazorPayErrorResponse {
      rethrow;
    }
  }

  Future<RazorPayRefundResponse?> fetchSpecificRefund(
      {required String refundId, required String paymentId}) async {
    try {
      final orderUri = Uri.parse('$_base/payments/$paymentId/refunds/$refundId');
      http.Response response = await http.get(orderUri, headers: RazorPayAPI.headers);
      if (response.statusCode == 200) {
        return RazorPayRefundResponse.fromString(response.body);
      }
      return null;
    } on RazorPayErrorResponse {
      rethrow;
    }
  }

  Future<RazorPayRefundResponse?> fetchById(String refundId) async {
    try {
      final orderUri = Uri.parse('$_base/refunds/$refundId');
      http.Response response = await http.get(orderUri, headers: RazorPayAPI.headers);
      if (response.statusCode == 200) {
        return RazorPayRefundResponse.fromString(response.body);
      }
      return null;
    } on RazorPayErrorResponse {
      rethrow;
    }
  }

  /// ## Query Parameters
  ///
  /// - **from:** Timestamp (in Unix format) from when the orders should be fetched.
  ///
  /// - **to:** Timestamp (in Unix format) up till when orders are to be fetched.
  ///
  /// - **count:** The number of orders to be fetched. The default value is 10. The maximum value is 100. This can be used for pagination, in combination with skip.
  ///
  /// - **skip:** The number of refunds to be skipped.
  ///
  Future<List<RazorPayRefundResponse>?> fetchAll({
    DateTime? from,
    DateTime? to,
    int? count,
    int? skip,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {
        if (from != null) 'from': from.millisecondsSinceEpoch,
        if (to != null) 'to': to.millisecondsSinceEpoch,
        if (count != null) 'count': count,
        if (skip != null) 'skip': skip,
      };
      final orderUri = Uri.parse('$_base/refunds').replace(queryParameters: queryParameters);
      http.Response response = await http.get(orderUri, headers: RazorPayAPI.headers);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['items']);
        var items = List.from(jsonDecode(response.body)['items']);
        return items.map((e) => RazorPayRefundResponse.fromJson(e)).toList();
      } else {
        return null;
      }
    } on RazorPayErrorResponse {
      rethrow;
    }
  }
}
