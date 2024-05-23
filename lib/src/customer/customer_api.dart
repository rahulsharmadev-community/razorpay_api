import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '/razorpay_api.dart';

class RazorPayCustomerAPI {
  final String customersPath;
  const RazorPayCustomerAPI() : customersPath = 'https://api.razorpay.com/v1/customers';

  Future<RazorPayCustomerResponse> createCustomer(RazorPayCustomer customer) async {
    try {
      final customerUri = Uri.parse(customersPath);
      http.Response response =
          await http.post(customerUri, body: customer.toJson(), headers: RazorPayAPI.headers);
      if (response.statusCode == 200) {
        return RazorPayCustomerResponse.fromJson(response.body);
      } else {
        throw Exception('Error status code ${response.statusCode}');
      }
    } on HttpException catch (error) {
      throw error.message;
    }
  }

  /// "notes" and "fail_existing" not required and should not be sent during edit.
  /// Editable Parameters
  /// ```dart
  /// { "name": "XYZ",
  ///   "email": "XYZ@example.com",
  ///   "contact": "9876543210",
  ///   "gstin":"XYZXYZXYZXYZ"
  /// }
  /// ```
  Future<RazorPayCustomerResponse> editByCustomerId(String customerId, RazorPayCustomer customer) async {
    try {
      final customerUri = Uri.parse('$customersPath/$customerId');

      //Customer without "notes" and "fail_existing"
      Map<String, dynamic> cleanCustomer = customer.toMap()
        ..removeWhere((key, value) => key == "notes" || key == "fail_existing");

      http.Response response = await http.put(customerUri,
          body: RazorPayCustomer.fromMap(cleanCustomer).toJson(), headers: RazorPayAPI.headers);
      if (response.statusCode == 200) {
        return RazorPayCustomerResponse.fromJson(response.body);
      } else {
        throw Exception('Error status code ${response.statusCode}');
      }
    } on HttpException catch (error) {
      throw error.message;
    }
  }

  Future<List<RazorPayCustomerResponse>> fetchCustomerByCount({int length = 20, int startAt = 0}) async {
    try {
      final customerUri = Uri.parse('$customersPath?count=$length&skip=$startAt');
      http.Response response = await http.get(customerUri, headers: RazorPayAPI.headers);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(jsonDecode(response.body)['items']);

        return list.map((e) => RazorPayCustomerResponse.fromMap(e)).toList();
      } else {
        throw Exception('Error status code ${response.statusCode}');
      }
    } on HttpException catch (error) {
      throw error.message;
    }
  }

  Future<RazorPayCustomerResponse> fetchCustomerById(String customerId) async {
    try {
      final customerUri = Uri.parse('$customersPath/$customerId');
      http.Response response = await http.get(customerUri, headers: RazorPayAPI.headers);
      if (response.statusCode == 200) {
        return RazorPayCustomerResponse.fromJson(response.body);
      } else {
        throw Exception('Error status code ${response.statusCode}');
      }
    } on HttpException catch (error) {
      throw error.message;
    }
  }
}
