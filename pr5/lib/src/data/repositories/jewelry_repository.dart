import '../../domain/models/jewelry_item.dart';
import '../database.dart';

class JewelryRepository {
  final AppDatabase database;

  JewelryRepository(this.database);

  void create(JewelryItem item) {
    database.connection.execute(
      'INSERT INTO jewelry(id,title,material,price,supplierId) VALUES(?,?,?,?,?)',
      [item.id, item.title, item.material, item.price, item.supplierId],
    );
  }

  List<JewelryItem> getAll() {
    final rows = database.connection.select(
      'SELECT id,title,material,price,supplierId FROM jewelry',
    );
    return rows.map((row) => JewelryItem.fromMap(row)).toList();
  }

  JewelryItem? getById(String id) {
    final rows = database.connection.select(
      'SELECT id,title,material,price,supplierId FROM jewelry WHERE id=?',
      [id],
    );
    return rows.isEmpty ? null : JewelryItem.fromMap(rows.first);
  }

  void update(JewelryItem item) {
    database.connection.execute(
      'UPDATE jewelry SET title=?, material=?, price=?, supplierId=? WHERE id=?',
      [item.title, item.material, item.price, item.supplierId, item.id],
    );
  }

  void delete(String id) {
    database.connection.execute('DELETE FROM jewelry WHERE id=?', [id]);
  }
}
