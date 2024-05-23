import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '/razorpay_api.dart';

class RazorPayOrderAPI {
  final String ordersPath;
  const RazorPayOrderAPI() : ordersPath = 'https://api.razorpay.com/v1/orders';
  Future<RazorPayOrderResponse?> createOrder(RazorPayOrder order) async {
    try {
      final orderUri = Uri.parse(ordersPath);
      http.Response response = await http.post(orderUri, body: order.toJson(), headers: RazorPayAPI.headers);
      if (response.statusCode == 200) {
        return RazorPayOrderResponse.fromJson(response.body);
      } else {
        return null;
      }
    } on HttpException catch (error) {
      throw error.message;
    }
  }

  Future<RazorPayOrderResponse> fetchById(String orderId) async {
    try {
      final orderUri = Uri.parse('$ordersPath/$orderId');
      http.Response response = await http.get(orderUri, headers: RazorPayAPI.headers);
      if (response.statusCode == 200) {
        return RazorPayOrderResponse.fromJson(response.body);
      } else {
        throw Exception('Error status code ${response.statusCode}');
      }
    } on HttpException catch (error) {
      throw error.message;
    }
  }

  /// ## Query Parameters
  ///
  ///
  /// - **authorized:** \
  ///   `true` : Retrieves Orders for which payments have been authorized. Payment and order states differ. Know more about payment states.\
  ///   `false` : Retrieves orders for which payments have not been authorized.
  ///
  /// - **receipt:** Retrieves the orders that contain the provided value for receipt.
  ///
  /// - **from:** Timestamp (in Unix format) from when the orders should be fetched.
  ///
  /// - **to:** Timestamp (in Unix format) up till when orders are to be fetched.
  ///
  /// - **count:** The number of orders to be fetched. The default value is 10. The maximum value is 100. This can be used for pagination, in combination with skip.
  ///
  /// - **skip:** The number of orders to be skipped. The default value is 0.
  /// This can be used for pagination, in combination with count.
  ///
  ///
  /// [doc] https://razorpay.com/docs/api/orders/fetch-all/
  Future<List<RazorPayOrderResponse>> fetchAll({
    bool? authorized,
    String? receipt,
    DateTime? from,
    DateTime? to,
    int? count,
    int? skip,
    List<String>? expand,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {
        if (authorized != null) 'authorized': authorized,
        if (from != null) 'from': from.millisecondsSinceEpoch,
        if (to != null) 'to': to.millisecondsSinceEpoch,
        if (count != null) 'count': count,
        if (skip != null) 'skip': skip,
        if (receipt != null) 'receipt': receipt,
        if (expand != null) 'expand': expand
      };
      final orderUri = Uri.parse(ordersPath).replace(queryParameters: queryParameters);
      http.Response response = await http.get(orderUri, headers: RazorPayAPI.headers);
      if (response.statusCode == 200) {
        var items = List.from(jsonDecode(response.body)['items']);
        return items.map((e) => RazorPayOrderResponse.fromMap(e)).toList();
      } else {
        throw Exception('Error status code ${response.statusCode}');
      }
    } on HttpException catch (error) {
      throw error.message;
    }
  }
}
