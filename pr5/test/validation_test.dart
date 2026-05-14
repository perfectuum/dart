import 'package:pr5/pr2.dart';
import 'package:test/test.dart';

void main() {
  test('обязательный текст', () {
    expect(requiredText('  текст  '), 'текст');
    expect(() => requiredText('   '), throwsA(isA<FormatException>()));
  });

  test('положительные числа', () {
    expect(positiveDouble('12,5'), 12.5);
    expect(positiveInt('3'), 3);
    expect(() => positiveDouble('0'), throwsA(isA<FormatException>()));
    expect(() => positiveInt('-1'), throwsA(isA<FormatException>()));
  });

  test('дата и время', () {
    expect(validDateTime('2026-05-14 12:30'), DateTime(2026, 5, 14, 12, 30));
    expect(() => validDateTime('нет даты'), throwsA(isA<FormatException>()));
  });
}
