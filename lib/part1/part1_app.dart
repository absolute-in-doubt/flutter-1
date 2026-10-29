import 'dart:convert';
import 'dart:io';
import 'type_classifier.dart';

/// Консольное приложение для Части 1 (Вариант 11).
void runPart1({bool interactive = true}) {
  stdout.encoding = utf8;

  print('\n${'=' * 65}');
  print('  ЧАСТЬ 1: РАЗДЕЛЕНИЕ РАЗНОТИПНЫХ ДАННЫХ И ВЫЧИСЛЕНИЕ СУММ');
  print('  Вариант 11: int, double, String, bool, null');
  print('=' * 65);

  if (!interactive) {
    _runDemo();
    return;
  }

  print('\nВыберите способ ввода данных:');
  print('  1. Запустить демонстрационный набор данных (с разными типами)');
  print('  2. Ввести строку элементов через запятую (например: 10, 3.14, "текст", true, null)');
  print('  3. Поэлементный ввод с клавиатуры (до ввода слова "done")');
  stdout.write('Ваш выбор [1/2/3, по умолчанию 1]: ');

  final choice = stdin.readLineSync(encoding: utf8)?.trim();

  switch (choice) {
    case '2':
      _runSingleLineInput();
    case '3':
      _runItemByItemInput();
    default:
      _runDemo();
  }
}

void _runDemo() {
  print('\n--- Запуск демонстрационного набора данных ---');
  final demoData = <Object?>[
    42,
    -15,
    3.1415,
    2.71828,
    'Привет, Dart!',
    true,
    null,
    100,
    -0.5,
    false,
    null,
    'КПМП Лабораторная 1',
    0,
    null,
    true,
  ];

  final result = TypeClassifier.classify(demoData);
  print(TypeClassifier.formatReport(result, rawItems: demoData));
}

void _runSingleLineInput() {
  print('\nВведите список элементов через запятую.');
  print('Пример: 25, 4.5, "БГУИР", true, null, -7, false, null');
  stdout.write('> ');

  final line = stdin.readLineSync(encoding: utf8);
  if (line == null || line.trim().isEmpty) {
    print('Пустой ввод! Запускаем демонстрационный набор данных.');
    _runDemo();
    return;
  }

  final items = TypeClassifier.parseCommaSeparatedString(line);
  final result = TypeClassifier.classify(items);
  print(TypeClassifier.formatReport(result, rawItems: items));
}

void _runItemByItemInput() {
  print('\nПоэлементный ввод. Вводите по одному значению в строке.');
  print('Для завершения ввода отправьте "done" или пустую строку.');

  final items = <Object?>[];
  int counter = 1;

  while (true) {
    stdout.write('Элемент #$counter: ');
    final line = stdin.readLineSync(encoding: utf8);
    if (line == null || line.trim().isEmpty || line.trim().toLowerCase() == 'done') {
      break;
    }
    final parsed = TypeClassifier.parseToken(line);
    items.add(parsed);
    counter++;
  }

  if (items.isEmpty) {
    print('Список пуст. Выполняем демо.');
    _runDemo();
    return;
  }

  final result = TypeClassifier.classify(items);
  print(TypeClassifier.formatReport(result, rawItems: items));
}
