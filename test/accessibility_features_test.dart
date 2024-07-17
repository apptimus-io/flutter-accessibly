import 'package:accessibly/accessibly.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds one to input values', () {
    final accessibly = Accessibly();

    expect(accessibly.colorBlindMode, false);
    expect(accessibly.textScaleFactor, 100);
  });
}
