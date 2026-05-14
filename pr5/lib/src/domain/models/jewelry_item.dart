import 'identity.dart';

class JewelryItem implements Identity {
  @override
  final String id;
  final String title;
  final String material;
  final double price;
  final String supplierId;

  const JewelryItem({
    required this.id,
    required this.title,
    required this.material,
    required this.price,
    required this.supplierId,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'material': material,
    'price': price,
    'supplierId': supplierId,
  };

  factory JewelryItem.fromMap(Map<String, dynamic> map) {
    return JewelryItem(
      id: map['id'] as String,
      title: map['title'] as String,
      material: map['material'] as String,
      price: _asDouble(map['price']),
      supplierId: map['supplierId'] as String,
    );
  }

  static double _asDouble(Object? value) {
    if (value is num) return value.toDouble();
    throw FormatException('Ожидалось число', value);
  }
}
