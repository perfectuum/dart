import '../../domain/models/sale.dart';
import '../database.dart';

class SaleRepository {
  final AppDatabase database;

  SaleRepository(this.database);

  void create(Sale sale) {
    database.connection.execute(
      'INSERT INTO sales(id,jewelryId,clientId,employeeId,date,quantity) VALUES(?,?,?,?,?,?)',
      [
        sale.id,
        sale.jewelryId,
        sale.clientId,
        sale.employeeId,
        sale.date.toIso8601String(),
        sale.quantity,
      ],
    );
  }

  List<Sale> getAll() {
    final rows = database.connection.select(
      'SELECT id,jewelryId,clientId,employeeId,date,quantity FROM sales',
    );
    return rows.map((row) => Sale.fromMap(row)).toList();
  }

  Sale? getById(String id) {
    final rows = database.connection.select(
      'SELECT id,jewelryId,clientId,employeeId,date,quantity FROM sales WHERE id=?',
      [id],
    );
    return rows.isEmpty ? null : Sale.fromMap(rows.first);
  }

  void update(Sale sale) {
    database.connection.execute(
      'UPDATE sales SET jewelryId=?, clientId=?, employeeId=?, date=?, quantity=? WHERE id=?',
      [
        sale.jewelryId,
        sale.clientId,
        sale.employeeId,
        sale.date.toIso8601String(),
        sale.quantity,
        sale.id,
      ],
    );
  }

  void delete(String id) {
    database.connection.execute('DELETE FROM sales WHERE id=?', [id]);
  }
}
