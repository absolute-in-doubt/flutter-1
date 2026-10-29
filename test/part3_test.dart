import 'package:lab1_variant11/part3/data_destructuring.dart';
import 'package:test/test.dart';

void main() {
  group('Часть 3: Деструктурирование данных (Destructuring)', () {
    test('Деструктурирование словаря JSON в UserRecord', () {
      final sampleJson = {
        'id': 7,
        'name': 'Kurtis Weissnat',
        'username': 'Elwyn.Skiles',
        'email': 'Telly.Hoeger@billy.biz',
        'address': {
          'street': 'Rex Trail',
          'suite': 'Suite 280',
          'city': 'Howemouth',
          'zipcode': '58804-1099',
          'geo': {'lat': '24.8918', 'lng': '21.8984'}
        },
        'phone': '210.067.6132',
        'website': 'elvis.io',
        'company': {
          'name': 'Johns Group',
          'catchPhrase': 'Configurable multimedia task-force',
          'bs': 'generate enterprise e-tailers'
        }
      };

      final record = DataDestructuringDemo.destructureUserMap(sampleJson);
      expect(record, isNotNull);

      // Проверка деструктурированных полей
      expect(record!.id, equals(7));
      expect(record.name, equals('Kurtis Weissnat'));
      expect(record.email, equals('Telly.Hoeger@billy.biz'));
      expect(record.companyName, equals('Johns Group'));
      expect(record.fullAddress, contains('Howemouth'));
      expect(record.hemisphere, contains('Северное'));
    });

    test('Деструктурирование координат для южного полушария', () {
      final sampleJson = {
        'id': 1,
        'name': 'Leanne Graham',
        'username': 'Bret',
        'email': 'sincere@april.biz',
        'address': {
          'street': 'Street',
          'suite': 'Suite',
          'city': 'City',
          'zipcode': '12345',
          'geo': {'lat': '-37.3159', 'lng': '81.1496'}
        },
        'company': {
          'name': 'Company',
          'catchPhrase': 'CatchPhrase',
        }
      };

      final record = DataDestructuringDemo.destructureUserMap(sampleJson);
      expect(record, isNotNull);
      expect(record!.hemisphere, contains('Южное'));
    });

    test('Возврат null при неполной структуре JSON', () {
      final invalidJson = {'id': 1, 'name': 'Invalid'};
      final record = DataDestructuringDemo.destructureUserMap(invalidJson);
      expect(record, isNull);
    });

    test('Распаковка именованных полей записи (Record destructuring)', () {
      final ({int id, String name, String companyName}) simpleUser = (
        id: 99,
        name: 'Тестовый Пользователь',
        companyName: 'БГУИР',
      );

      final (:id, :name, :companyName) = simpleUser;
      expect(id, equals(99));
      expect(name, equals('Тестовый Пользователь'));
      expect(companyName, equals('БГУИР'));
    });

    test('Деструктурирование полного UserRecord', () {
      final UserRecord user = (
        id: 1,
        name: 'Иван Иванов',
        username: 'ivan',
        email: 'ivan@example.com',
        fullAddress: 'Минск, ул. Платонова, 39',
        companyName: 'БГУИР-Софт',
        catchPhrase: 'Качественный софт',
        coordinates: '[53.9, 27.5]',
        hemisphere: 'Северное',
      );

      final (
        :id,
        :name,
        :username,
        :email,
        :fullAddress,
        :companyName,
        :catchPhrase,
        :coordinates,
        :hemisphere,
      ) = user;

      expect(id, equals(1));
      expect(name, equals('Иван Иванов'));
      expect(username, equals('ivan'));
      expect(email, equals('ivan@example.com'));
      expect(fullAddress, contains('Платонова'));
      expect(companyName, equals('БГУИР-Софт'));
      expect(catchPhrase, equals('Качественный софт'));
      expect(coordinates, equals('[53.9, 27.5]'));
      expect(hemisphere, equals('Северное'));
    });
  });
}
