String requiredText(String value) {
  final text = value.trim();
  if (text.isEmpty) {
    throw const FormatException('Поле не должно быть пустым');
  }
  return text;
}
