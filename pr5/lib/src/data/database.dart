import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

class AppDatabase {
  final Database connection;

  AppDatabase(String filePath) : connection = sqlite3.open(filePath) {
    _createTables();
  }

  factory AppDatabase.inApp() {
    final filePath = p.join(Directory.current.path, 'jewelry_store.db');
    return AppDatabase(filePath);
  }

  void _createTables() {
    connection.execute('PRAGMA foreign_keys = ON');

    connection.execute('''
      CREATE TABLE IF NOT EXISTS suppliers (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        phone TEXT NOT NULL
      );
    ''');

    connection.execute('''
      CREATE TABLE IF NOT EXISTS jewelry (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        material TEXT NOT NULL,
        price REAL NOT NULL,
        supplierId TEXT NOT NULL,
        FOREIGN KEY (supplierId) REFERENCES suppliers(id) ON DELETE CASCADE
      );
    ''');

    connection.execute('''
      CREATE TABLE IF NOT EXISTS clients (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        phone TEXT NOT NULL
      );
    ''');

    connection.execute('''
      CREATE TABLE IF NOT EXISTS employees (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        position TEXT NOT NULL
      );
    ''');

    connection.execute('''
      CREATE TABLE IF NOT EXISTS sales (
        id TEXT PRIMARY KEY,
        jewelryId TEXT NOT NULL,
        clientId TEXT NOT NULL,
        employeeId TEXT NOT NULL,
        date TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        FOREIGN KEY (jewelryId) REFERENCES jewelry(id) ON DELETE CASCADE,
        FOREIGN KEY (clientId) REFERENCES clients(id) ON DELETE CASCADE,
        FOREIGN KEY (employeeId) REFERENCES employees(id) ON DELETE CASCADE
      );
    ''');
  }

  void close() {
    connection.dispose();
  }
}
