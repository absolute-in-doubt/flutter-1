import 'package:lab1_variant11/part1/type_classifier.dart';
import 'package:test/test.dart';

void main() {
  group('Часть 1: TypeClassifier (Вариант 11)', () {
    test('Классификация разнотипного списка и правильный подсчет сумм', () {
      final input = <Object?>[
        10,
        20,
        3.5,
        1.5,
        'Dart',
        true,
        false,
        null,
        null,
        'Flutter',
      ];

      final result = TypeClassifier.classify(input);

      // Проверка разделения по спискам
      expect(result.integers, equals([10, 20]));
      expect(result.doubles, equals([3.5, 1.5]));
      expect(result.strings, equals(['Dart', 'Flutter']));
      expect(result.booleans, equals([true, false]));
      expect(result.nullValues.length, equals(2));
      expect(result.hasNulls, isTrue);

      // Проверка сумм
      expect(result.sumOfIntegersAsInt, equals(30));
      expect(result.sumOfIntegersAsDouble, equals(30.0));
      expect(result.sumOfDoubles, equals(5.0));
      expect(result.totalNumericSum, equals(35.0));
      expect(result.totalCount, equals(10));
    });

    test('Обработка списка без числовых значений', () {
      final input = <Object?>['hello', true, null];
      final result = TypeClassifier.classify(input);

      expect(result.integers, isEmpty);
      expect(result.doubles, isEmpty);
      expect(result.sumOfIntegersAsDouble, equals(0.0));
      expect(result.sumOfDoubles, equals(0.0));
      expect(result.totalNumericSum, equals(0.0));
      expect(result.hasNulls, isTrue);
    });

    test('Обработка списка без null значений', () {
      final input = <Object?>[1, 2.0, 'test'];
      final result = TypeClassifier.classify(input);

      expect(result.nullValues, isEmpty);
      expect(result.hasNulls, isFalse);
    });

    test('Парсинг отдельных токенов parseToken', () {
      expect(TypeClassifier.parseToken('null'), isNull);
      expect(TypeClassifier.parseToken('NULL'), isNull);
      expect(TypeClassifier.parseToken(''), isNull);
      expect(TypeClassifier.parseToken('~'), isNull);
      expect(TypeClassifier.parseToken('true'), isTrue);
      expect(TypeClassifier.parseToken('false'), isFalse);
      expect(TypeClassifier.parseToken('123'), equals(123));
      expect(TypeClassifier.parseToken('-45'), equals(-45));
      expect(TypeClassifier.parseToken('3.14'), equals(3.14));
      expect(TypeClassifier.parseToken('-0.05'), equals(-0.05));
      expect(TypeClassifier.parseToken('"hello"'), equals('hello'));
      expect(TypeClassifier.parseToken("'world'"), equals('world'));
      expect(TypeClassifier.parseToken('Some Text'), equals('Some Text'));
    });

    test('Парсинг строки с разделителями-запятыми и кавычками', () {
      final parsed = TypeClassifier.parseCommaSeparatedString(
        '42, 3.14, "Привет, мир!", true, null, false',
      );

      expect(parsed.length, equals(6));
      expect(parsed[0], equals(42));
      expect(parsed[1], equals(3.14));
      expect(parsed[2], equals('Привет, мир!'));
      expect(parsed[3], isTrue);
      expect(parsed[4], isNull);
      expect(parsed[5], isFalse);
    });
  });
}
