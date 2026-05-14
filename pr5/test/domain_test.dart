import 'package:pr5/pr2.dart';
import 'package:test/test.dart';

void main() {
  test('JewelryItem toMap и fromMap', () {
    const item = JewelryItem(
      id: 'j1',
      title: 'Кольцо',
      material: 'золото',
      price: 15000,
      supplierId: 's1',
    );

    final map = item.toMap();
    final copy = JewelryItem.fromMap(map);

    expect(copy.id, 'j1');
    expect(copy.title, 'Кольцо');
    expect(copy.material, 'золото');
    expect(copy.price, 15000);
    expect(copy.supplierId, 's1');
  });

  test('Sale toMap и fromMap', () {
    final sale = Sale(
      id: 'sale1',
      jewelryId: 'j1',
      clientId: 'c1',
      employeeId: 'e1',
      date: DateTime(2026, 5, 14, 12),
      quantity: 2,
    );

    final map = sale.toMap();
    final copy = Sale.fromMap(map);

    expect(copy.id, 'sale1');
    expect(copy.jewelryId, 'j1');
    expect(copy.clientId, 'c1');
    expect(copy.employeeId, 'e1');
    expect(copy.date, DateTime(2026, 5, 14, 12));
    expect(copy.quantity, 2);
  });
}
