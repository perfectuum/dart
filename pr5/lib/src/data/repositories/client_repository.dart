import '../../domain/models/client.dart';
import '../database.dart';

class ClientRepository {
  final AppDatabase database;

  ClientRepository(this.database);

  void create(Client client) {
    database.connection.execute(
      'INSERT INTO clients(id,name,phone) VALUES(?,?,?)',
      [client.id, client.name, client.phone],
    );
  }

  List<Client> getAll() {
    final rows = database.connection.select(
      'SELECT id,name,phone FROM clients',
    );
    return rows.map((row) => Client.fromMap(row)).toList();
  }

  Client? getById(String id) {
    final rows = database.connection.select(
      'SELECT id,name,phone FROM clients WHERE id=?',
      [id],
    );
    return rows.isEmpty ? null : Client.fromMap(rows.first);
  }

  void update(Client client) {
    database.connection.execute(
      'UPDATE clients SET name=?, phone=? WHERE id=?',
      [client.name, client.phone, client.id],
    );
  }

  void delete(String id) {
    database.connection.execute('DELETE FROM clients WHERE id=?', [id]);
  }
}
