import 'package:pr5/pr2.dart';

void main(List<String> arguments) {
  final db = AppDatabase.inApp();
  final menu = Menu(db);
  try {
    menu.run();
  } finally {
    db.close();
  }
}
