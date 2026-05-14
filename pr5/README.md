# Практическая работа №5

Тема: ювелирный магазин.

## Предметная область

Программа хранит данные магазина украшений:

- украшения;
- клиенты;
- сотрудники;
- продажи;
- поставщики.

Продажа связана с украшением, клиентом и сотрудником. Украшение связано с поставщиком.

## Структура папок

```text
bin/
  pr1.dart
lib/
  pr2.dart
  src/
    cli/
      input_helper.dart
      menu.dart
    data/
      database.dart
      repositories/
        client_repository.dart
        employee_repository.dart
        jewelry_repository.dart
        sale_repository.dart
        supplier_repository.dart
    domain/
      models/
        client.dart
        employee.dart
        identity.dart
        jewelry_item.dart
        sale.dart
        supplier.dart
      validators/
        date_validator.dart
        number_validator.dart
        text_validator.dart
test/
  data_test.dart
  domain_test.dart
  validation_test.dart
```

## Слои

`domain` содержит модели и валидаторы. Этот слой не работает с консолью и SQLite.

`data` содержит базу SQLite и репозитории для CRUD.

`cli` содержит меню, ввод и вывод данных.

`bin` только запускает приложение.

## Валидации

- обязательное текстовое поле: строка не пустая после `trim()`;
- цена и количество должны быть больше 0;
- дата продажи должна корректно парситься в `DateTime`.

## Тесты

- `domain_test.dart` проверяет `toMap` и `fromMap`;
- `data_test.dart` проверяет CRUD в SQLite;
- `validation_test.dart` проверяет валидные и невалидные значения.

## Запуск

```bash
dart pub get
dart run bin/pr1.dart
dart test
```
