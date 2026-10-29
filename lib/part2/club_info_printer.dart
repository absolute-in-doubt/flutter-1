import 'football_club.dart';
import 'sports_club.dart';
import 'swimming_club.dart';

/// Класс для красивого форматирования и вывода информации о спортивных секциях в консоль.
class ClubInfoPrinter {
  /// Выводит подробную карточку спортивного клуба со всеми специфическими полями.
  static void printClubDetails(SportsClub club) {
    final line = '═' * 70;
    final stats = club.getClubStats();

    print('\n$line');
    print('  КАРТОЧКА СПОРТИВНОЙ СЕКЦИИ: ${club.name.toUpperCase()}');
    print('  ${club.formatFillStatus(current: club.membersCount, max: club.maxCapacity)}');
    print('─' * 70);

    for (final entry in stats.entries) {
      final key = entry.key.padRight(28);
      print('  $key : ${entry.value}');
    }

    if (club.schedule.isNotEmpty) {
      print('─' * 70);
      print('  Расписание тренировок:');
      for (final slot in club.schedule) {
        print('    • $slot');
      }
    }

    print('$line\n');
  }

  /// Выводит сравнительную сводную таблицу нескольких спортивных секций.
  static void printComparisonTable(List<SportsClub> clubs) {
    print('\n${'=' * 105}');
    print('  СРАВНИТЕЛЬНЫЙ АНАЛИЗ СПОРТИВНЫХ СЕКЦИЙ');
    print('=' * 105);

    // Заголовки таблицы
    final header =
        '| ${'Вид спорта'.padRight(10)} | ${'Название'.padRight(18)} | ${'Город'.padRight(10)} | ${'Участники'.padRight(11)} | ${'Взнос/мес'.padRight(10)} | ${'Доход/год'.padRight(12)} | ${'Расход/год'.padRight(12)} | ${'Баланс/год'.padRight(12)} |';
    final divider =
        '+${'-' * 12}+${'-' * 20}+${'-' * 12}+${'-' * 13}+${'-' * 12}+${'-' * 14}+${'-' * 14}+${'-' * 14}+';

    print(divider);
    print(header);
    print(divider);

    for (final club in clubs) {
      final sport = club.getSportType().padRight(10);
      final name = (club.name.length > 18 ? '${club.name.substring(0, 15)}...' : club.name).padRight(18);
      final city = club.city.padRight(10);
      final members = '${club.membersCount}/${club.maxCapacity}'.padRight(11);
      final fee = '${club.monthlyFee.toStringAsFixed(0)} руб.'.padRight(10);
      final rev = '${club.annualRevenue.toStringAsFixed(0)} руб.'.padRight(12);
      final cost = '${club.calculateOperatingCosts().toStringAsFixed(0)} руб.'.padRight(12);
      final balance = '${club.netAnnualBalance.toStringAsFixed(0)} руб.'.padRight(12);

      print('| $sport | $name | $city | $members | $fee | $rev | $cost | $balance |');
    }
    print(divider);
  }

  /// Демонстрирует работу полиморфизма и специфических методов для переданного списка секций.
  static void simulateTrainingDay(List<SportsClub> clubs) {
    print('\n${'─' * 70}');
    print('  СИМУЛЯЦИЯ ТРЕНИРОВОЧНОГО ДНЯ (ДЕМОНСТРАЦИЯ ПОЛИМОРФИЗМА)');
    print('─' * 70);

    for (final club in clubs) {
      print('\n[Секция: ${club.name}]');
      // Полиморфный вызов переопределенного метода conductTraining()
      club.conductTraining();

      // Проверка типов и вызов уникальных методов каждого наследника
      if (club is FootballClub) {
        club.conductTacticalBriefing('4-3-3 с высоким прессингом');
        club.playMatch('Сборная Академии', goalsScored: 3, goalsConceded: 1);
        club.awardTrophy('Кубок города 2026');
      } else if (club is SwimmingClub) {
        club.checkWaterQuality(ph: 7.4, chlorine: 0.45);
        club.conductTimeTrial('Алексей Смирнов', 'Кроль на груди', 24.85);
        club.adjustWaterTemperature(28.0);
      }
    }
    print('─' * 70);
  }
}
