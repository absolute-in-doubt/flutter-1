import 'dart:convert';
import 'dart:io';
import 'api_service.dart';
import 'data_destructuring.dart';

/// Консольное приложение для Части 3 (Получение данных из API и деструктурирование).
Future<void> runPart3({bool interactive = true}) async {
  stdout.encoding = utf8;

  print('\n${'=' * 70}');
  print('  ЧАСТЬ 3: АСИНХРОННЫЙ ЗАПРОС К ПУБЛИЧНОМУ API И ДЕСТРУКТУРИРОВАНИЕ');
  print('  Источник: ${ApiService.usersUrl}');
  print('=' * 70);

  stdout.write('Запрос к API в процессе...');
  final (rawUsers, isFromNetwork) = await ApiService.fetchUsers();
  print(' ГОТОВО!');
  print('Источник данных: ${isFromNetwork ? "🌐 Сеть (jsonplaceholder.typicode.com)" : "📁 Локальный резервный JSON"}');
  print('Загружено записей: ${rawUsers.length}');

  // 1. Деструктурирование списка (List pattern)
  DataDestructuringDemo.demonstrateListDestructuring(rawUsers);

  // 2. Деструктурирование Map с извлечением вложенных структур и создание записей (Records)
  final structuredUsers = <UserRecord>[];
  for (final raw in rawUsers) {
    final record = DataDestructuringDemo.destructureUserMap(raw);
    if (record != null) {
      structuredUsers.add(record);
    }
  }

  // 3. Вывод таблицы пользователей (с использованием Record destructuring)
  DataDestructuringDemo.printUsersTable(structuredUsers);

  // 4. Подробная демонстрация деструктурирования отдельной записи Record
  if (structuredUsers.isNotEmpty) {
    print('\nДемонстрация деструктурирования первой записи (Named Record):');
    DataDestructuringDemo.demonstrateRecordDestructuring(structuredUsers.first);
  }

  // 5. Демонстрация деструктурирования позиционной записи (Positional Record)
  print('\nДемонстрация деструктурирования позиционного кортежа:');
  DataDestructuringDemo.demonstratePositionalRecordDestructuring(
    (1, 'ФК "Минск Динамо-Юни"', 'Футбол', 63840.0),
  );
  DataDestructuringDemo.demonstratePositionalRecordDestructuring(
    (2, 'ВВС "Олимпийские Дельфины"', 'Плавание', 105600.0),
  );
}
