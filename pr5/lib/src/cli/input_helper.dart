import 'dart:io';

import '../domain/validators/date_validator.dart';
import '../domain/validators/number_validator.dart';
import '../domain/validators/text_validator.dart';

String askString(String label) {
  while (true) {
    stdout.write(label);
    final value = stdin.readLineSync() ?? '';
    try {
      return requiredText(value);
    } on FormatException catch (e) {
      stdout.writeln(e.message);
    }
  }
}

double askPositiveDouble(String label) {
  while (true) {
    stdout.write(label);
    final value = stdin.readLineSync() ?? '';
    try {
      return positiveDouble(value);
    } on FormatException catch (e) {
      stdout.writeln(e.message);
    }
  }
}

int askPositiveInt(String label) {
  while (true) {
    stdout.write(label);
    final value = stdin.readLineSync() ?? '';
    try {
      return positiveInt(value);
    } on FormatException catch (e) {
      stdout.writeln(e.message);
    }
  }
}

DateTime askDateTime(String label) {
  while (true) {
    stdout.write(label);
    final value = stdin.readLineSync() ?? '';
    try {
      return validDateTime(value);
    } on FormatException catch (e) {
      stdout.writeln(e.message);
    }
  }
}
