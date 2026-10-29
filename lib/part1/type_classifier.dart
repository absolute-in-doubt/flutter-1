/// Класс результатов классификации элементов по типам данных.
class TypeClassificationResult {
  final List<int> integers;
  final List<double> doubles;
  final List<String> strings;
  final List<bool> booleans;
  final List<Null> nullValues;

  const TypeClassificationResult({
    required this.integers,
    required this.doubles,
    required this.strings,
    required this.booleans,
    required this.nullValues,
  });

  /// Сумма целых чисел (приведённых к double).
  double get sumOfIntegersAsDouble =>
      integers.fold(0.0, (acc, val) => acc + val.toDouble());

  /// Сумма целых чисел в формате int.
  int get sumOfIntegersAsInt => integers.fold(0, (acc, val) => acc + val);

  /// Сумма чисел с плавающей точкой.
  double get sumOfDoubles => doubles.fold(0.0, (acc, val) => acc + val);

  /// Общая сумма всех числовых типов (целые приведены к double + вещественные).
  double get totalNumericSum => sumOfIntegersAsDouble + sumOfDoubles;

  /// Общее количество элементов.
  int get totalCount =>
      integers.length +
      doubles.length +
      strings.length +
      booleans.length +
      nullValues.length;

  /// Флаг наличия пустых (null) значений.
  bool get hasNulls => nullValues.isNotEmpty;
}

/// Сервис для парсинга и классификации разнотипных элементов с поддержкой Null Safety.
class TypeClassifier {
  /// Классифицирует произвольный список `List<Object?>` по типам данных.
  static TypeClassificationResult classify(List<Object?> items) {
    final integers = <int>[];
    final doubles = <double>[];
    final strings = <String>[];
    final booleans = <bool>[];
    final nullValues = <Null>[];

    for (final item in items) {
      switch (item) {
        case int val:
          integers.add(val);
        case double val:
          doubles.add(val);
        case String val:
          strings.add(val);
        case bool val:
          booleans.add(val);
        case null:
          nullValues.add(null);
        default:
          strings.add(item.toString());
      }
    }

    return TypeClassificationResult(
      integers: List.unmodifiable(integers),
      doubles: List.unmodifiable(doubles),
      strings: List.unmodifiable(strings),
      booleans: List.unmodifiable(booleans),
      nullValues: List.unmodifiable(nullValues),
    );
  }

  /// Парсит один строковый токен в типизированное значение Object?
  static Object? parseToken(String token) {
    final trimmed = token.trim();

    // 1. Проверка на null (пустой токен, ключевое слово 'null', '~', 'none')
    if (trimmed.isEmpty ||
        trimmed.toLowerCase() == 'null' ||
        trimmed.toLowerCase() == 'none' ||
        trimmed == '~') {
      return null;
    }

    // 2. Строка в кавычках (одиночных или двойных)
    if ((trimmed.startsWith('"') && trimmed.endsWith('"') && trimmed.length >= 2) ||
        (trimmed.startsWith("'") && trimmed.endsWith("'") && trimmed.length >= 2)) {
      return trimmed.substring(1, trimmed.length - 1);
    }

    // 3. Логические значения (true / false)
    if (trimmed.toLowerCase() == 'true') return true;
    if (trimmed.toLowerCase() == 'false') return false;

    // 4. Целые числа (int)
    final parsedInt = int.tryParse(trimmed);
    if (parsedInt != null) return parsedInt;

    // 5. Числа с плавающей точкой (double)
    final parsedDouble = double.tryParse(trimmed);
    if (parsedDouble != null) return parsedDouble;

    // 6. Всё остальное — строка
    return trimmed;
  }

  /// Парсит строку с разделителями-запятыми, учитывая кавычки.
  static List<Object?> parseCommaSeparatedString(String input) {
    final tokens = <String>[];
    final buffer = StringBuffer();
    bool insideQuotes = false;
    String quoteChar = '';

    for (int i = 0; i < input.length; i++) {
      final char = input[i];

      if ((char == '"' || char == "'") && (!insideQuotes || char == quoteChar)) {
        insideQuotes = !insideQuotes;
        quoteChar = insideQuotes ? char : '';
        buffer.write(char);
      } else if (char == ',' && !insideQuotes) {
        tokens.add(buffer.toString());
        buffer.clear();
      } else {
        buffer.write(char);
      }
    }

    if (buffer.isNotEmpty || input.endsWith(',')) {
      tokens.add(buffer.toString());
    }

    return tokens.map(parseToken).toList();
  }

  /// Форматирует текстовый отчет по результатам классификации.
  static String formatReport(TypeClassificationResult result, {List<Object?>? rawItems}) {
    final sb = StringBuffer();
    final line = '=' * 60;
    final subLine = '-' * 60;

    sb.writeln(line);
    sb.writeln('  ОТЧЕТ ПО КЛАССИФИКАЦИИ ДАННЫХ РАЗНЫХ ТИПОВ (ВАРИАНТ 11)');
    sb.writeln(line);

    if (rawItems != null) {
      sb.writeln('Исходный список (${rawItems.length} эл.):');
      sb.writeln('  [${rawItems.map((e) => e == null ? 'null' : (e is String ? '"$e"' : '$e')).join(', ')}]');
      sb.writeln(subLine);
    }

    sb.writeln('1. Целые числа (int) [кол-во: ${result.integers.length}]:');
    if (result.integers.isEmpty) {
      sb.writeln('   Список пуст');
    } else {
      sb.writeln('   Элементы: ${result.integers}');
      sb.writeln('   Сумма (как int): ${result.sumOfIntegersAsInt}');
      sb.writeln('   Сумма (приведено к double): ${result.sumOfIntegersAsDouble.toStringAsFixed(2)}');
    }

    sb.writeln('\n2. Вещественные числа (double) [кол-во: ${result.doubles.length}]:');
    if (result.doubles.isEmpty) {
      sb.writeln('   Список пуст');
    } else {
      sb.writeln('   Элементы: ${result.doubles}');
      sb.writeln('   Сумма вещественных: ${result.sumOfDoubles.toStringAsFixed(4)}');
    }

    sb.writeln('\n3. Итоговые вычисления по числовым типам:');
    sb.writeln('   Сумма целых (как double): ${result.sumOfIntegersAsDouble.toStringAsFixed(4)}');
    sb.writeln('   Сумма вещественных:        ${result.sumOfDoubles.toStringAsFixed(4)}');
    sb.writeln('   -> ОБЩАЯ СУММА ЧИСЕЛ:      ${result.totalNumericSum.toStringAsFixed(4)}');

    sb.writeln('\n4. Строки (String) [кол-во: ${result.strings.length}]:');
    if (result.strings.isEmpty) {
      sb.writeln('   Список пуст');
    } else {
      sb.writeln('   Элементы: [${result.strings.map((s) => '"$s"').join(', ')}]');
    }

    sb.writeln('\n5. Логические значения (bool) [кол-во: ${result.booleans.length}]:');
    if (result.booleans.isEmpty) {
      sb.writeln('   Список пуст');
    } else {
      sb.writeln('   Элементы: ${result.booleans}');
      final trueCount = result.booleans.where((b) => b).length;
      final falseCount = result.booleans.length - trueCount;
      sb.writeln('   Статистика: true = $trueCount, false = $falseCount');
    }

    sb.writeln('\n6. Пустые значения (null) [кол-во: ${result.nullValues.length}]:');
    sb.writeln('   Флаг наличия null: ${result.hasNulls ? 'ДА (обнаружены)' : 'НЕТ'}');

    sb.writeln(line);
    return sb.toString();
  }
}
