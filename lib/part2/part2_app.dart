import 'dart:convert';
import 'dart:io';
import 'club_info_printer.dart';
import 'football_club.dart';
import 'sports_club.dart';
import 'swimming_club.dart';

/// Консольное приложение для Части 2 (Вариант 11: Спортивные секции).
void runPart2({bool interactive = true}) {
  stdout.encoding = utf8;

  print('\n${'=' * 65}');
  print('  ЧАСТЬ 2: ООП В DART (АБСТРАКТНЫЙ КЛАСС, НАСЛЕДОВАНИЕ, MIXIN)');
  print('  Вариант 11: SportsClub -> FootballClub, SwimmingClub');
  print('=' * 65);

  final football = FootballClub(
    id: 'FC-01',
    name: 'ФК "Минск Динамо-Юни"',
    city: 'Минск',
    headCoach: 'Виктор Михайлович Гончаренко',
    monthlyFee: 140.0,
    initialMembers: 38,
    maxCapacity: 45,
    foundedDate: DateTime(2012, 5, 14),
    schedule: [
      'Понедельник 17:00 - 19:00 (Тактика и стандарты)',
      'Среда 17:30 - 19:30 (Физическая подготовка)',
      'Пятница 18:00 - 20:00 (Игровая тренировка)',
      'Суббота 11:00 - 13:00 (Матч тура)',
    ],
    pitchType: 'Натуральный газон (подогрев)',
    league: 'Высшая юношеская лига',
    matchSquadSize: 22,
    trophiesCount: 7,
    hasYouthAcademy: true,
    homeStadium: 'Стадион "Динамо-Юни"',
  );

  final swimming = SwimmingClub(
    id: 'SC-02',
    name: 'ВВС "Олимпийские Дельфины"',
    city: 'Минск',
    headCoach: 'Елена Владимировна Герасименя',
    monthlyFee: 160.0,
    initialMembers: 55,
    maxCapacity: 60,
    foundedDate: DateTime(2015, 9, 1),
    schedule: [
      'Вторник 07:30 - 09:30 (Утренняя вода + ОФП)',
      'Четверг 18:00 - 20:00 (Интервальное плавание)',
      'Суббота 09:00 - 11:00 (Контрольные заплывы)',
    ],
    poolLengthMeters: 50,
    lanesCount: 8,
    waterTemperature: 27.5,
    poolType: 'Крытый олимпийский с озонированием',
    hasSauna: true,
    availableStyles: [
      'Вольный стиль (кроль)',
      'Брасс',
      'Баттерфляй (дельфин)',
      'Плавание на спине',
      'Комплексное плавание',
    ],
  );

  final clubs = <SportsClub>[football, swimming];

  // Выводим карточки каждого клуба
  for (final club in clubs) {
    ClubInfoPrinter.printClubDetails(club);
  }

  // Выводим сводную сравнительную таблицу
  ClubInfoPrinter.printComparisonTable(clubs);

  // Симуляция тренировочного дня и демонстрация полиморфизма
  ClubInfoPrinter.simulateTrainingDay(clubs);

  if (interactive) {
    print('\nХотите выполнить интерактивное действие?');
    print('  1. Записать нового участника в клуб');
    print('  2. Добавить слот в расписание');
    print('  3. Вернуться в главное меню');
    stdout.write('Ваш выбор [1/2/3, Enter для возврата]: ');

    final choice = stdin.readLineSync(encoding: utf8)?.trim();
    if (choice == '1') {
      stdout.write('В какой клуб записать? (1 - Футбол, 2 - Плавание): ');
      final clubChoice = stdin.readLineSync(encoding: utf8)?.trim();
      final targetClub = clubChoice == '2' ? swimming : football;
      stdout.write('Сколько человек записать? [по умолчанию 1]: ');
      final countStr = stdin.readLineSync(encoding: utf8)?.trim();
      final count = int.tryParse(countStr ?? '1') ?? 1;
      targetClub.enrollMember(count);
      print('Текущий статус: ${targetClub.membersCount}/${targetClub.maxCapacity}');
    } else if (choice == '2') {
      stdout.write('В какой клуб добавить? (1 - Футбол, 2 - Плавание): ');
      final clubChoice = stdin.readLineSync(encoding: utf8)?.trim();
      final targetClub = clubChoice == '2' ? swimming : football;
      stdout.write('Введите описание слота расписания: ');
      final slot = stdin.readLineSync(encoding: utf8)?.trim();
      if (slot != null && slot.isNotEmpty) {
        targetClub.addScheduleSlot(slot);
      }
    }
  }
}
