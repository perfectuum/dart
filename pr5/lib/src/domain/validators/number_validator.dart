double positiveDouble(String value) {
  final number = double.tryParse(value.trim().replaceAll(',', '.'));
  if (number == null || number <= 0) {
    throw const FormatException('Число должно быть больше 0');
  }
  return number;
}

int positiveInt(String value) {
  final number = int.tryParse(value.trim());
  if (number == null || number <= 0) {
    throw const FormatException('Число должно быть больше 0');
  }
  return number;
}
