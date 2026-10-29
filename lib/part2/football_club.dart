import 'sports_club.dart';

/// Класс футбольного клуба / секции футбола.
class FootballClub extends SportsClub {
  String pitchType;
  String league;
  int matchSquadSize;
  int trophiesCount;
  bool hasYouthAcademy;
  String homeStadium;

  FootballClub({
    required super.id,
    required super.name,
    required super.city,
    required super.headCoach,
    required super.monthlyFee,
    required super.initialMembers,
    required super.maxCapacity,
    required super.foundedDate,
    super.schedule,
    required this.pitchType,
    required this.league,
    this.matchSquadSize = 22,
    this.trophiesCount = 0,
    this.hasYouthAcademy = true,
    this.homeStadium = 'Городской стадион',
  });

  // --- Уникальные методы футбольного клуба ---

  /// Проведение товарищеского или официального матча.
  void playMatch(String opponent, {required int goalsScored, required int goalsConceded}) {
    final result = goalsScored > goalsConceded
        ? 'ПОБЕДА'
        : (goalsScored == goalsConceded ? 'НИЧЬЯ' : 'ПОРАЖЕНИЕ');
    printLog('Матч: "$name" vs "$opponent" ($homeStadium) -> Счёт: $goalsScored:$goalsConceded [$result]');
  }

  /// Проведение тактического разбора и подготовки схемы игры.
  void conductTacticalBriefing(String formation) {
    printLog('Тактическое занятие клуба "$name": разбор схемы $formation под руководством $headCoach');
  }

  /// Завоевание нового кубка/трофея.
  void awardTrophy(String tournamentName) {
    trophiesCount++;
    printLog('🏆 Клуб "$name" завоевал трофей в турнире "$tournamentName"! Всего трофеев: $trophiesCount');
  }

  // --- Переопределённые методы (@override) ---

  @override
  String getSportType() => 'Футбол';

  @override
  void conductTraining() {
    printLog('⚽ Футбольная тренировка в "$name": разминка 15 мин, отработка паса и стандартов, двусторонка на поле ($pitchType).');
  }

  @override
  double calculateOperatingCosts() {
    // Расходы: аренда и стрижка газона, футбольная экипировка, судейство, содержание академии
    final fieldMaintenance = pitchType.contains('Натуральный') ? 18000.0 : 12000.0;
    final gearAndBalls = membersCount * 85.0;
    final academyBonus = hasYouthAcademy ? 15000.0 : 0.0;
    final leagueRegistrationFee = 6000.0;
    return fieldMaintenance + gearAndBalls + academyBonus + leagueRegistrationFee;
  }

  @override
  Map<String, dynamic> getClubStats() {
    return {
      'ID': id,
      'Название': name,
      'Вид спорта': getSportType(),
      'Город': city,
      'Главный тренер': headCoach,
      'Лига': league,
      'Тип покрытия поля': pitchType,
      'Домашний стадион': homeStadium,
      'Размер заявки на матч': matchSquadSize,
      'Наличие детской академии': hasYouthAcademy ? 'Да' : 'Нет',
      'Количество кубков': trophiesCount,
      'Участников': '$membersCount / $maxCapacity',
      'Месячный взнос': '${monthlyFee.toStringAsFixed(2)} руб.',
      'Годовой доход': '${annualRevenue.toStringAsFixed(2)} руб.',
      'Годовые расходы': '${calculateOperatingCosts().toStringAsFixed(2)} руб.',
      'Чистый баланс': '${netAnnualBalance.toStringAsFixed(2)} руб.',
    };
  }

  @override
  String toString() {
    return '${super.toString()}, Лига: $league, Поле: $pitchType, Трофеев: $trophiesCount';
  }
}
