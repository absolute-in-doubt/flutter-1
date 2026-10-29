import 'sports_club.dart';

/// Класс клуба плавания / секции водных видов спорта.
class SwimmingClub extends SportsClub {
  int poolLengthMeters;
  int lanesCount;
  double waterTemperature;
  String poolType;
  bool hasSauna;
  final List<String> _availableStyles;

  SwimmingClub({
    required super.id,
    required super.name,
    required super.city,
    required super.headCoach,
    required super.monthlyFee,
    required super.initialMembers,
    required super.maxCapacity,
    required super.foundedDate,
    super.schedule,
    required this.poolLengthMeters,
    required this.lanesCount,
    this.waterTemperature = 27.5,
    this.poolType = 'Крытый олимпийский',
    this.hasSauna = true,
    List<String>? availableStyles,
  }) : _availableStyles = availableStyles ??
            ['Вольный стиль (кроль)', 'Брасс', 'Баттерфляй', 'На спине'];

  List<String> get availableStyles => List.unmodifiable(_availableStyles);

  // --- Уникальные методы плавательного клуба ---

  /// Регулировка температуры воды в бассейне.
  void adjustWaterTemperature(double newTemp) {
    final oldTemp = waterTemperature;
    waterTemperature = newTemp;
    printLog('Бассейн "$name": температура воды изменена с ${oldTemp.toStringAsFixed(1)}°C на ${waterTemperature.toStringAsFixed(1)}°C');
  }

  /// Проверка санитарных параметров воды.
  void checkWaterQuality({required double ph, required double chlorine}) {
    final isPhNormal = ph >= 7.2 && ph <= 7.6;
    final isChlorineNormal = chlorine >= 0.3 && chlorine <= 0.6;
    final status = (isPhNormal && isChlorineNormal) ? 'В НОРМЕ' : 'ТРЕБУЕТСЯ КОРРЕКЦИЯ';
    printLog('Анализ воды в "$name": pH=$ph (норма 7.2-7.6), Хлор=$chlorine мг/л (норма 0.3-0.6) -> [$status]');
  }

  /// Проведение контрольного заплыва на время.
  void conductTimeTrial(String swimmerName, String stroke, double timeSeconds) {
    printLog('Заплыв на время в "$name": пловец $swimmerName, стиль: $stroke, дистанция: $poolLengthMeters м -> Результат: ${timeSeconds.toStringAsFixed(2)} сек.');
  }

  // --- Переопределённые методы (@override) ---

  @override
  String getSportType() => 'Плавание';

  @override
  void conductTraining() {
    printLog('🏊 Плавательная тренировка в "$name": сухое ОФП 20 мин, разминка на воде 400м, интервальные серии кролем и брассом на $lanesCount дорожках ($poolLengthMeters м).');
  }

  @override
  double calculateOperatingCosts() {
    // Расходы: подогрев воды, фильтрация, химреагенты, спасатели/медперсонал, сауна
    final heatingAndFiltration = (poolLengthMeters == 50 ? 25000.0 : 15000.0) + (lanesCount * 800.0);
    final chemicals = 7500.0;
    final staffAndLifeguards = 18000.0;
    final saunaOperatingCost = hasSauna ? 4500.0 : 0.0;
    return heatingAndFiltration + chemicals + staffAndLifeguards + saunaOperatingCost;
  }

  @override
  Map<String, dynamic> getClubStats() {
    return {
      'ID': id,
      'Название': name,
      'Вид спорта': getSportType(),
      'Город': city,
      'Главный тренер': headCoach,
      'Длина бассейна': '$poolLengthMeters м',
      'Количество дорожек': lanesCount,
      'Температура воды': '${waterTemperature.toStringAsFixed(1)} °C',
      'Тип бассейна': poolType,
      'Наличие сауны': hasSauna ? 'Да' : 'Нет',
      'Доступные стили': _availableStyles.join(', '),
      'Участников': '$membersCount / $maxCapacity',
      'Месячный взнос': '${monthlyFee.toStringAsFixed(2)} руб.',
      'Годовой доход': '${annualRevenue.toStringAsFixed(2)} руб.',
      'Годовые расходы': '${calculateOperatingCosts().toStringAsFixed(2)} руб.',
      'Чистый баланс': '${netAnnualBalance.toStringAsFixed(2)} руб.',
    };
  }

  @override
  String toString() {
    return '${super.toString()}, Бассейн: $poolLengthMeters м ($lanesCount дор.), Температура: ${waterTemperature.toStringAsFixed(1)}°C';
  }
}
