import '../../domain/models/supplier.dart';
import '../database.dart';

class SupplierRepository {
  final AppDatabase database;

  SupplierRepository(this.database);

  void create(Supplier supplier) {
    database.connection.execute(
      'INSERT INTO suppliers(id,name,phone) VALUES(?,?,?)',
      [supplier.id, supplier.name, supplier.phone],
    );
  }

  List<Supplier> getAll() {
    final rows = database.connection.select(
      'SELECT id,name,phone FROM suppliers',
    );
    return rows.map((row) => Supplier.fromMap(row)).toList();
  }

  Supplier? getById(String id) {
    final rows = database.connection.select(
      'SELECT id,name,phone FROM suppliers WHERE id=?',
      [id],
    );
    return rows.isEmpty ? null : Supplier.fromMap(rows.first);
  }

  void update(Supplier supplier) {
    database.connection.execute(
      'UPDATE suppliers SET name=?, phone=? WHERE id=?',
      [supplier.name, supplier.phone, supplier.id],
    );
  }

  void delete(String id) {
    database.connection.execute('DELETE FROM suppliers WHERE id=?', [id]);
  }
}
