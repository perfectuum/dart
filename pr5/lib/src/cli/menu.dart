import 'dart:io';

import '../data/database.dart';
import '../data/repositories/client_repository.dart';
import '../data/repositories/employee_repository.dart';
import '../data/repositories/jewelry_repository.dart';
import '../data/repositories/sale_repository.dart';
import '../data/repositories/supplier_repository.dart';
import '../domain/models/client.dart';
import '../domain/models/employee.dart';
import '../domain/models/jewelry_item.dart';
import '../domain/models/sale.dart';
import '../domain/models/supplier.dart';
import 'input_helper.dart';

class Menu {
  final SupplierRepository suppliers;
  final JewelryRepository jewelry;
  final ClientRepository clients;
  final EmployeeRepository employees;
  final SaleRepository sales;

  Menu(AppDatabase db)
    : suppliers = SupplierRepository(db),
      jewelry = JewelryRepository(db),
      clients = ClientRepository(db),
      employees = EmployeeRepository(db),
      sales = SaleRepository(db);

  void run() {
    while (true) {
      stdout.writeln('''
--- Ювелирный магазин ---
1 - украшения
2 - клиенты
3 - сотрудники
4 - продажи
5 - поставщики
6 - показать всё из БД
0 - выход''');

      switch (_choice()) {
        case '1':
          _jewelryMenu();
          break;
        case '2':
          _clientsMenu();
          break;
        case '3':
          _employeesMenu();
          break;
        case '4':
          _salesMenu();
          break;
        case '5':
          _suppliersMenu();
          break;
        case '6':
          _printAll();
          break;
        case '0':
          return;
        default:
          stdout.writeln('Нет такого пункта.');
      }
    }
  }

  String _choice() {
    stdout.write('Выберите пункт: ');
    return stdin.readLineSync()?.trim() ?? '';
  }

  void _jewelryMenu() {
    while (true) {
      stdout.writeln('''
--- Украшения ---
1 - список
2 - добавить
3 - изменить
4 - удалить
0 - назад''');

      switch (_choice()) {
        case '1':
          _printJewelry();
          break;
        case '2':
          _addJewelry();
          break;
        case '3':
          _updateJewelry();
          break;
        case '4':
          _deleteJewelry();
          break;
        case '0':
          return;
        default:
          stdout.writeln('Нет такого пункта.');
      }
    }
  }

  void _clientsMenu() {
    while (true) {
      stdout.writeln('''
--- Клиенты ---
1 - список
2 - добавить
3 - изменить
4 - удалить
0 - назад''');

      switch (_choice()) {
        case '1':
          _printClients();
          break;
        case '2':
          _addClient();
          break;
        case '3':
          _updateClient();
          break;
        case '4':
          _deleteClient();
          break;
        case '0':
          return;
        default:
          stdout.writeln('Нет такого пункта.');
      }
    }
  }

  void _employeesMenu() {
    while (true) {
      stdout.writeln('''
--- Сотрудники ---
1 - список
2 - добавить
3 - изменить
4 - удалить
0 - назад''');

      switch (_choice()) {
        case '1':
          _printEmployees();
          break;
        case '2':
          _addEmployee();
          break;
        case '3':
          _updateEmployee();
          break;
        case '4':
          _deleteEmployee();
          break;
        case '0':
          return;
        default:
          stdout.writeln('Нет такого пункта.');
      }
    }
  }

  void _salesMenu() {
    while (true) {
      stdout.writeln('''
--- Продажи ---
1 - список
2 - добавить
3 - изменить
4 - удалить
0 - назад''');

      switch (_choice()) {
        case '1':
          _printSales();
          break;
        case '2':
          _addSale();
          break;
        case '3':
          _updateSale();
          break;
        case '4':
          _deleteSale();
          break;
        case '0':
          return;
        default:
          stdout.writeln('Нет такого пункта.');
      }
    }
  }

  void _suppliersMenu() {
    while (true) {
      stdout.writeln('''
--- Поставщики ---
1 - список
2 - добавить
3 - изменить
4 - удалить
0 - назад''');

      switch (_choice()) {
        case '1':
          _printSuppliers();
          break;
        case '2':
          _addSupplier();
          break;
        case '3':
          _updateSupplier();
          break;
        case '4':
          _deleteSupplier();
          break;
        case '0':
          return;
        default:
          stdout.writeln('Нет такого пункта.');
      }
    }
  }

  void _printJewelry() {
    final list = jewelry.getAll();
    if (list.isEmpty) {
      stdout.writeln('Украшений нет.');
      return;
    }
    for (final item in list) {
      stdout.writeln(
        'id: ${item.id} | ${item.title} | ${item.material} | ${item.price} руб. | поставщик: ${item.supplierId}',
      );
    }
  }

  void _addJewelry() {
    _printSuppliers();
    final id = askString('id украшения: ');
    final title = askString('название: ');
    final material = askString('материал: ');
    final price = askPositiveDouble('цена: ');
    final supplierId = askString('id поставщика: ');
    if (!_supplierExists(supplierId)) return;

    jewelry.create(
      JewelryItem(
        id: id,
        title: title,
        material: material,
        price: price,
        supplierId: supplierId,
      ),
    );
    stdout.writeln('Готово.');
  }

  void _updateJewelry() {
    final id = askString('id украшения: ');
    if (jewelry.getById(id) == null) {
      stdout.writeln('Украшение не найдено.');
      return;
    }
    _printSuppliers();
    final title = askString('новое название: ');
    final material = askString('новый материал: ');
    final price = askPositiveDouble('новая цена: ');
    final supplierId = askString('новый id поставщика: ');
    if (!_supplierExists(supplierId)) return;

    jewelry.update(
      JewelryItem(
        id: id,
        title: title,
        material: material,
        price: price,
        supplierId: supplierId,
      ),
    );
    stdout.writeln('Готово.');
  }

  void _deleteJewelry() {
    final id = askString('id украшения: ');
    jewelry.delete(id);
    stdout.writeln('Готово.');
  }

  void _printClients() {
    final list = clients.getAll();
    if (list.isEmpty) {
      stdout.writeln('Клиентов нет.');
      return;
    }
    for (final client in list) {
      stdout.writeln('id: ${client.id} | ${client.name} | ${client.phone}');
    }
  }

  void _addClient() {
    final id = askString('id клиента: ');
    final name = askString('имя: ');
    final phone = askString('телефон: ');
    clients.create(Client(id: id, name: name, phone: phone));
    stdout.writeln('Готово.');
  }

  void _updateClient() {
    final id = askString('id клиента: ');
    if (clients.getById(id) == null) {
      stdout.writeln('Клиент не найден.');
      return;
    }
    final name = askString('новое имя: ');
    final phone = askString('новый телефон: ');
    clients.update(Client(id: id, name: name, phone: phone));
    stdout.writeln('Готово.');
  }

  void _deleteClient() {
    final id = askString('id клиента: ');
    clients.delete(id);
    stdout.writeln('Готово.');
  }

  void _printEmployees() {
    final list = employees.getAll();
    if (list.isEmpty) {
      stdout.writeln('Сотрудников нет.');
      return;
    }
    for (final employee in list) {
      stdout.writeln(
        'id: ${employee.id} | ${employee.name} | ${employee.position}',
      );
    }
  }

  void _addEmployee() {
    final id = askString('id сотрудника: ');
    final name = askString('имя: ');
    final position = askString('должность: ');
    employees.create(Employee(id: id, name: name, position: position));
    stdout.writeln('Готово.');
  }

  void _updateEmployee() {
    final id = askString('id сотрудника: ');
    if (employees.getById(id) == null) {
      stdout.writeln('Сотрудник не найден.');
      return;
    }
    final name = askString('новое имя: ');
    final position = askString('новая должность: ');
    employees.update(Employee(id: id, name: name, position: position));
    stdout.writeln('Готово.');
  }

  void _deleteEmployee() {
    final id = askString('id сотрудника: ');
    employees.delete(id);
    stdout.writeln('Готово.');
  }

  void _printSales() {
    final list = sales.getAll();
    if (list.isEmpty) {
      stdout.writeln('Продаж нет.');
      return;
    }
    for (final sale in list) {
      stdout.writeln(
        'id: ${sale.id} | украшение: ${sale.jewelryId} | клиент: ${sale.clientId} | сотрудник: ${sale.employeeId} | ${sale.date} | кол-во: ${sale.quantity}',
      );
    }
  }

  void _addSale() {
    _printJewelry();
    _printClients();
    _printEmployees();
    final id = askString('id продажи: ');
    final jewelryId = askString('id украшения: ');
    final clientId = askString('id клиента: ');
    final employeeId = askString('id сотрудника: ');
    final date = askDateTime('дата продажи (2026-05-14 12:00): ');
    final quantity = askPositiveInt('количество: ');
    if (!_saleLinksExist(jewelryId, clientId, employeeId)) return;

    sales.create(
      Sale(
        id: id,
        jewelryId: jewelryId,
        clientId: clientId,
        employeeId: employeeId,
        date: date,
        quantity: quantity,
      ),
    );
    stdout.writeln('Готово.');
  }

  void _updateSale() {
    final id = askString('id продажи: ');
    if (sales.getById(id) == null) {
      stdout.writeln('Продажа не найдена.');
      return;
    }
    _printJewelry();
    _printClients();
    _printEmployees();
    final jewelryId = askString('новый id украшения: ');
    final clientId = askString('новый id клиента: ');
    final employeeId = askString('новый id сотрудника: ');
    final date = askDateTime('новая дата продажи: ');
    final quantity = askPositiveInt('новое количество: ');
    if (!_saleLinksExist(jewelryId, clientId, employeeId)) return;

    sales.update(
      Sale(
        id: id,
        jewelryId: jewelryId,
        clientId: clientId,
        employeeId: employeeId,
        date: date,
        quantity: quantity,
      ),
    );
    stdout.writeln('Готово.');
  }

  void _deleteSale() {
    final id = askString('id продажи: ');
    sales.delete(id);
    stdout.writeln('Готово.');
  }

  void _printSuppliers() {
    final list = suppliers.getAll();
    if (list.isEmpty) {
      stdout.writeln('Поставщиков нет.');
      return;
    }
    for (final supplier in list) {
      stdout.writeln(
        'id: ${supplier.id} | ${supplier.name} | ${supplier.phone}',
      );
    }
  }

  void _addSupplier() {
    final id = askString('id поставщика: ');
    final name = askString('название: ');
    final phone = askString('телефон: ');
    suppliers.create(Supplier(id: id, name: name, phone: phone));
    stdout.writeln('Готово.');
  }

  void _updateSupplier() {
    final id = askString('id поставщика: ');
    if (suppliers.getById(id) == null) {
      stdout.writeln('Поставщик не найден.');
      return;
    }
    final name = askString('новое название: ');
    final phone = askString('новый телефон: ');
    suppliers.update(Supplier(id: id, name: name, phone: phone));
    stdout.writeln('Готово.');
  }

  void _deleteSupplier() {
    final id = askString('id поставщика: ');
    suppliers.delete(id);
    stdout.writeln('Готово.');
  }

  bool _supplierExists(String id) {
    if (suppliers.getById(id) != null) return true;
    stdout.writeln('Поставщик не найден.');
    return false;
  }

  bool _saleLinksExist(String jewelryId, String clientId, String employeeId) {
    if (jewelry.getById(jewelryId) == null) {
      stdout.writeln('Украшение не найдено.');
      return false;
    }
    if (clients.getById(clientId) == null) {
      stdout.writeln('Клиент не найден.');
      return false;
    }
    if (employees.getById(employeeId) == null) {
      stdout.writeln('Сотрудник не найден.');
      return false;
    }
    return true;
  }

  void _printAll() {
    stdout.writeln('Поставщики');
    _printSuppliers();
    stdout.writeln('Украшения');
    _printJewelry();
    stdout.writeln('Клиенты');
    _printClients();
    stdout.writeln('Сотрудники');
    _printEmployees();
    stdout.writeln('Продажи');
    _printSales();
  }
}
