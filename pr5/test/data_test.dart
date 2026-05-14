import 'dart:io';

import 'package:pr5/pr2.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  test('CRUD в SQLite', () async {
    final dir = await Directory.systemTemp.createTemp('pr5_test');
    final db = AppDatabase(p.join(dir.path, 'test.db'));

    final suppliers = SupplierRepository(db);
    final jewelry = JewelryRepository(db);
    final clients = ClientRepository(db);
    final employees = EmployeeRepository(db);
    final sales = SaleRepository(db);

    try {
      suppliers.create(
        const Supplier(id: 's1', name: 'Поставщик', phone: '111'),
      );
      suppliers.update(
        const Supplier(id: 's1', name: 'Новый поставщик', phone: '222'),
      );
      expect(suppliers.getById('s1')?.name, 'Новый поставщик');

      clients.create(const Client(id: 'c1', name: 'Иван', phone: '333'));
      clients.update(const Client(id: 'c1', name: 'Петр', phone: '444'));
      expect(clients.getById('c1')?.name, 'Петр');

      employees.create(
        const Employee(id: 'e1', name: 'Анна', position: 'продавец'),
      );
      employees.update(
        const Employee(id: 'e1', name: 'Анна', position: 'кассир'),
      );
      expect(employees.getById('e1')?.position, 'кассир');

      jewelry.create(
        const JewelryItem(
          id: 'j1',
          title: 'Кольцо',
          material: 'золото',
          price: 15000,
          supplierId: 's1',
        ),
      );
      jewelry.update(
        const JewelryItem(
          id: 'j1',
          title: 'Серьги',
          material: 'серебро',
          price: 9000,
          supplierId: 's1',
        ),
      );
      expect(jewelry.getById('j1')?.title, 'Серьги');

      sales.create(
        Sale(
          id: 'sale1',
          jewelryId: 'j1',
          clientId: 'c1',
          employeeId: 'e1',
          date: DateTime(2026, 5, 14, 12),
          quantity: 1,
        ),
      );
      sales.update(
        Sale(
          id: 'sale1',
          jewelryId: 'j1',
          clientId: 'c1',
          employeeId: 'e1',
          date: DateTime(2026, 5, 14, 13),
          quantity: 2,
        ),
      );
      expect(sales.getById('sale1')?.quantity, 2);

      sales.delete('sale1');
      jewelry.delete('j1');
      employees.delete('e1');
      clients.delete('c1');
      suppliers.delete('s1');

      expect(sales.getById('sale1'), isNull);
      expect(jewelry.getById('j1'), isNull);
      expect(employees.getById('e1'), isNull);
      expect(clients.getById('c1'), isNull);
      expect(suppliers.getById('s1'), isNull);
    } finally {
      db.close();
      await dir.delete(recursive: true);
    }
  });
}
