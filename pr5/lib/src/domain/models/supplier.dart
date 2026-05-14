import 'identity.dart';

class Supplier implements Identity {
  @override
  final String id;
  final String name;
  final String phone;

  const Supplier({required this.id, required this.name, required this.phone});

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'phone': phone};

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
    );
  }
}
