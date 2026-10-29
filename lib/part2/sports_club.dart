import 'printable_mixin.dart';

/// Базовый абстрактный класс спортивной секции / клуба.
abstract class SportsClub with PrintableInfo {
  final String id;
  String name;
  String city;
  String headCoach;
  double monthlyFee;
  int _membersCount;
  final int maxCapacity;
  final DateTime foundedDate;
  final List<String> _schedule;

  SportsClub({
    required this.id,
    required this.name,
    required this.city,
    required this.headCoach,
    required this.monthlyFee,
    required int initialMembers,
    required this.maxCapacity,
    required this.foundedDate,
    List<String>? schedule,
  })  : _membersCount = initialMembers > maxCapacity ? maxCapacity : initialMembers,
        _schedule = schedule ?? [];

  /// Текущее количество участников.
  int get membersCount => _membersCount;

  /// Количество доступных свободных мест.
  int get availableSpots => maxCapacity - _membersCount;

  /// Флаг полного заполнения клуба.
  bool get isFull => _membersCount >= maxCapacity;

  /// Расписание тренировок (неизменяемый список).
  List<String> get schedule => List.unmodifiable(_schedule);

  /// Годовая выручка от членских взносов.
  double get annualRevenue => _membersCount * monthlyFee * 12;

  /// Возраст клуба в годах.
  int get clubAgeYears => DateTime.now().year - foundedDate.year;

  /// Чистый годовой баланс (доходы минус операционные расходы).
  double get netAnnualBalance => annualRevenue - calculateOperatingCosts();

  /// Записать нового участника (или нескольких) в клуб.
  bool enrollMember([int count = 1]) {
    if (count <= 0) return false;
    if (_membersCount + count > maxCapacity) {
      printLog('Невозможно записать $count чел. в "$name": недостаточно мест (свободно: $availableSpots)', level: 'WARN');
      return false;
    }
    _membersCount += count;
    printLog('В клуб "$name" записано $count чел. Теперь участников: $_membersCount/$maxCapacity');
    return true;
  }

  /// Отчислить участника (или нескольких) из клуба.
  bool removeMember([int count = 1]) {
    if (count <= 0 || _membersCount < count) return false;
    _membersCount -= count;
    printLog('Из клуба "$name" выбыло $count чел. Осталось: $_membersCount');
    return true;
  }

  /// Добавить слот в расписание тренировок.
  void addScheduleSlot(String slot) {
    if (!_schedule.contains(slot)) {
      _schedule.add(slot);
      printLog('В расписание клуба "$name" добавлен слот: $slot');
    }
  }

  // --- Абстрактные методы, обязательные для реализации в наследниках ---

  /// Проведение тренировочной сессии, специфичной для данного вида спорта.
  void conductTraining();

  /// Расчет годовых операционных расходов клуба.
  double calculateOperatingCosts();

  /// Название вида спорта.
  String getSportType();

  /// Словарь с ключевыми характеристиками и статистикой секции.
  Map<String, dynamic> getClubStats();

  @override
  String toString() {
    return '$name (${getSportType()}) - $city, тренер: $headCoach, участников: $_membersCount/$maxCapacity';
  }
}
