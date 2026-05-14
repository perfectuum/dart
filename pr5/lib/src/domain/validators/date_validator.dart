DateTime validDateTime(String value) {
  final text = value.trim().replaceFirst(' ', 'T');
  final date = DateTime.tryParse(text);
  if (date == null) {
    throw const FormatException('Дата указана неверно');
  }
  return date;
}
