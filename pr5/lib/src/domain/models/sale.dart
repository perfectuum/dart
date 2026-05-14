import 'identity.dart';

class Sale implements Identity {
  @override
  final String id;
  final String jewelryId;
  final String clientId;
  final String employeeId;
  final DateTime date;
  final int quantity;

  const Sale({
    required this.id,
    required this.jewelryId,
    required this.clientId,
    required this.employeeId,
    required this.date,
    required this.quantity,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'jewelryId': jewelryId,
    'clientId': clientId,
    'employeeId': employeeId,
    'date': date.toIso8601String(),
    'quantity': quantity,
  };

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'] as String,
      jewelryId: map['jewelryId'] as String,
      clientId: map['clientId'] as String,
      employeeId: map['employeeId'] as String,
      date: DateTime.parse(map['date'] as String),
      quantity: _asInt(map['quantity']),
    );
  }

  static int _asInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    throw FormatException('Ожидалось целое число', value);
  }
}
