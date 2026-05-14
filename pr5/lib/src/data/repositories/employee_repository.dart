import '../../domain/models/employee.dart';
import '../database.dart';

class EmployeeRepository {
  final AppDatabase database;

  EmployeeRepository(this.database);

  void create(Employee employee) {
    database.connection.execute(
      'INSERT INTO employees(id,name,position) VALUES(?,?,?)',
      [employee.id, employee.name, employee.position],
    );
  }

  List<Employee> getAll() {
    final rows = database.connection.select(
      'SELECT id,name,position FROM employees',
    );
    return rows.map((row) => Employee.fromMap(row)).toList();
  }

  Employee? getById(String id) {
    final rows = database.connection.select(
      'SELECT id,name,position FROM employees WHERE id=?',
      [id],
    );
    return rows.isEmpty ? null : Employee.fromMap(rows.first);
  }

  void update(Employee employee) {
    database.connection.execute(
      'UPDATE employees SET name=?, position=? WHERE id=?',
      [employee.name, employee.position, employee.id],
    );
  }

  void delete(String id) {
    database.connection.execute('DELETE FROM employees WHERE id=?', [id]);
  }
}
