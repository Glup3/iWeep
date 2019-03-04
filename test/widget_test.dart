import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:iweep/main.dart';
import '../lib/util/formatting_helper.dart';

void main() {
  group('FormattingHelper - ', () {
    test('return value should be 30', () {
      expect(FormattingHelper.formatIntegerToTimeString(30), "30");
    });

    test('return value should be 05', () {
      expect(FormattingHelper.formatIntegerToTimeString(5), "05");
    });

    test('return value should be 18:04', () {
      expect(FormattingHelper.formatToTimeString(18, 4), "18:04");
    });
  });
}
