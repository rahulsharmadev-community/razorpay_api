import 'package:flutter/material.dart';

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String get toHex => '#${value.toRadixString(16)}';
}

extension StringToHex on String {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  Color get toColor {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension RazorPayConvertInt on int {
  double get fromRazorPayAmount => this * .01;
  DateTime get fromRazorPayTimestamp => DateTime.fromMillisecondsSinceEpoch(this * 1000);
}

extension RazorPayConvertDouble on double {
  int get toRazorPayAmount => (this * 100).toInt();
}

extension RazorPayConvertDateTime on DateTime {
  int get toRazorPayTimestamp => millisecondsSinceEpoch ~/ 1000;
}
