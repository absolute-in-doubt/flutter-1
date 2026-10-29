import 'package:lab1_variant11/part2/football_club.dart';
import 'package:lab1_variant11/part2/sports_club.dart';
import 'package:lab1_variant11/part2/swimming_club.dart';
import 'package:test/test.dart';

void main() {
  group('Часть 2: ООП Спортивные секции (Вариант 11)', () {
    test('FootballClub наследование, поля и методы', () {
      final fb = FootballClub(
        id: 'FC-TEST',
        name: 'ФК Тест',
        city: 'Минск',
        headCoach: 'Тренер И.И.',
        monthlyFee: 100.0,
        initialMembers: 20,
        maxCapacity: 30,
        foundedDate: DateTime(2020, 1, 1),
        pitchType: 'Натуральный газон',
        league: 'Первая лига',
        matchSquadSize: 20,
        trophiesCount: 2,
        hasYouthAcademy: true,
      );

      // Проверка свойств базового класса
      expect(fb.id, equals('FC-TEST'));
      expect(fb.name, equals('ФК Тест'));
      expect(fb.membersCount, equals(20));
      expect(fb.availableSpots, equals(10));
      expect(fb.isFull, isFalse);
      expect(fb.annualRevenue, equals(20 * 100.0 * 12));
      expect(fb.getSportType(), equals('Футбол'));

      // Запись нового участника
      expect(fb.enrollMember(5), isTrue);
      expect(fb.membersCount, equals(25));
      expect(fb.availableSpots, equals(5));

      // Превышение вместимости
      expect(fb.enrollMember(10), isFalse);
      expect(fb.membersCount, equals(25));

      // Отчисление участника
      expect(fb.removeMember(3), isTrue);
      expect(fb.membersCount, equals(22));

      // Уникальные методы футбольного клуба
      fb.awardTrophy('Суперкубок');
      expect(fb.trophiesCount, equals(3));

      // Расчет расходов
      final costs = fb.calculateOperatingCosts();
      expect(costs, greaterThan(0));

      // Словарь характеристик
      final stats = fb.getClubStats();
      expect(stats['Вид спорта'], equals('Футбол'));
      expect(stats['Лига'], equals('Первая лига'));
    });

    test('SwimmingClub наследование, поля и методы', () {
      final sc = SwimmingClub(
        id: 'SC-TEST',
        name: 'Плавательный Клуб Тест',
        city: 'Брест',
        headCoach: 'Тренер П.П.',
        monthlyFee: 120.0,
        initialMembers: 50,
        maxCapacity: 50,
        foundedDate: DateTime(2018, 5, 10),
        poolLengthMeters: 50,
        lanesCount: 8,
        waterTemperature: 27.0,
        hasSauna: true,
      );

      expect(sc.getSportType(), equals('Плавание'));
      expect(sc.isFull, isTrue);
      expect(sc.availableSpots, equals(0));

      // Регулировка температуры
      sc.adjustWaterTemperature(28.5);
      expect(sc.waterTemperature, equals(28.5));

      // Стили плавания
      expect(sc.availableStyles, contains('Вольный стиль (кроль)'));

      // Расчет операционных расходов
      final costs = sc.calculateOperatingCosts();
      expect(costs, greaterThan(0));

      final stats = sc.getClubStats();
      expect(stats['Длина бассейна'], equals('50 м'));
    });

    test('Полиморфизм через базовый класс SportsClub', () {
      final List<SportsClub> clubs = [
        FootballClub(
          id: 'FC-1',
          name: 'ФК 1',
          city: 'Гомель',
          headCoach: 'Тренер 1',
          monthlyFee: 50,
          initialMembers: 10,
          maxCapacity: 20,
          foundedDate: DateTime(2010),
          pitchType: 'Искусственный газон',
          league: 'Лига 1',
        ),
        SwimmingClub(
          id: 'SC-1',
          name: 'СК 1',
          city: 'Гродно',
          headCoach: 'Тренер 2',
          monthlyFee: 60,
          initialMembers: 15,
          maxCapacity: 25,
          foundedDate: DateTime(2012),
          poolLengthMeters: 25,
          lanesCount: 6,
        ),
      ];

      final types = clubs.map((c) => c.getSportType()).toList();
      expect(types, equals(['Футбол', 'Плавание']));

      for (final club in clubs) {
        expect(() => club.conductTraining(), returnsNormally);
        expect(club.calculateOperatingCosts(), isPositive);
      }
    });
  });
}
