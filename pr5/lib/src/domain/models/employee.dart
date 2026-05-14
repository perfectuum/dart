import 'identity.dart';

class Employee implements Identity {
  @override
  final String id;
  final String name;
  final String position;

  const Employee({
    required this.id,
    required this.name,
    required this.position,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'position': position,
  };

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as String,
      name: map['name'] as String,
      position: map['position'] as String,
    );
  }
}
