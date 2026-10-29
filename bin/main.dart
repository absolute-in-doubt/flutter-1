import 'dart:convert';
import 'dart:io';
import 'package:lab1_variant11/part1/part1_app.dart';
import 'package:lab1_variant11/part2/part2_app.dart';
import 'package:lab1_variant11/part3/part3_app.dart';

Future<void> main(List<String> args) async {
  stdout.encoding = utf8;

  // Если переданы аргументы командной строки
  if (args.isNotEmpty) {
    switch (args[0]) {
      case '1':
      case 'part1':
        runPart1(interactive: false);
        return;
      case '2':
      case 'part2':
        runPart2(interactive: false);
        return;
      case '3':
      case 'part3':
        await runPart3(interactive: false);
        return;
      case 'all':
        await _runAll();
        return;
    }
  }

  while (true) {
    print('\n╔${'═' * 72}╗');
    print('║       ЛАБОРАТОРНАЯ РАБОТА №1 (ВАРИАНТ 11) - ЯЗЫК DART                  ║');
    print('║  Тема: Основы Dart, Null Safety, ООП, Mixins, Асинхронность, Паттерны   ║');
    print('╚${'═' * 72}╝');
    print('  [1] Часть 1: Разделение списка разнотипных данных и вычисление сумм');
    print('  [2] Часть 2: Спортивные секции (SportsClub: FootballClub, SwimmingClub)');
    print('  [3] Часть 3: Публичный REST API и деструктурирование данных (Dart 3)');
    print('  [4] Запустить ВСЕ части подряд (демонстрационный режим)');
    print('  [0] Выход из программы');
    print('─' * 74);
    stdout.write('Выберите пункт меню [0-4]: ');

    final input = stdin.readLineSync(encoding: utf8)?.trim();

    switch (input) {
      case '1':
        runPart1(interactive: true);
      case '2':
        runPart2(interactive: true);
      case '3':
        await runPart3(interactive: true);
      case '4':
        await _runAll();
      case '0':
      case 'q':
      case 'exit':
        print('\nПрограмма завершена. До свидания!');
        return;
      default:
        print('\nНекорректный ввод. Пожалуйста, выберите число от 0 до 4.');
    }
  }
}

Future<void> _runAll() async {
  print('\n>>> ЗАПУСК ЧАСТИ 1 (ВАРИАНТ 11) <<<');
  runPart1(interactive: false);

  print('\n>>> ЗАПУСК ЧАСТИ 2 (ВАРИАНТ 11) <<<');
  runPart2(interactive: false);

  print('\n>>> ЗАПУСК ЧАСТИ 3 (ВАРИАНТ 11) <<<');
  await runPart3(interactive: false);

  print('\n✅ ВСЕ ЧАСТИ УСПЕШНО ВЫПОЛНЕНЫ!');
}
