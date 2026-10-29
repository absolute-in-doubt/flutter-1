/// Тип записи (Record) с именованными полями для хранения распакованных данных пользователя.
typedef UserRecord = ({
  int id,
  String name,
  String username,
  String email,
  String fullAddress,
  String companyName,
  String catchPhrase,
  String coordinates,
  String hemisphere,
});

/// Класс для демонстрации возможностей деструктурирования (Destructuring) данных в Dart 3.
class DataDestructuringDemo {
  /// Деструктурирует элемент JSON (Map) с использованием сопоставления шаблонов (Map pattern).
  /// Извлекает глубоко вложенные поля без ручного разыменования ключей.
  static UserRecord? destructureUserMap(dynamic userJson) {
    // 1. Деструктурирование Map-шаблона с вложенными словарями address, geo, company
    if (userJson case {
      'id': int id,
      'name': String name,
      'username': String username,
      'email': String email,
      'address': {
        'city': String city,
        'street': String street,
        'suite': String suite,
        'zipcode': String zipcode,
        'geo': {'lat': String lat, 'lng': String lng},
      },
      'company': {
        'name': String companyName,
        'catchPhrase': String catchPhrase,
      },
    }) {
      // Определение полушария через сопоставление с шаблоном switch
      final latValue = double.tryParse(lat) ?? 0.0;
      final hemisphere = switch (latValue) {
        >= 0 => 'Северное (lat: $lat)',
        < 0 => 'Южное (lat: $lat)',
        _ => 'Неизвестно',
      };

      // Возврат записи (Record) с упакованными данными
      return (
        id: id,
        name: name,
        username: username,
        email: email,
        fullAddress: '$city, $street, $suite (индекс: $zipcode)',
        companyName: companyName,
        catchPhrase: catchPhrase,
        coordinates: '[$lat, $lng]',
        hemisphere: hemisphere,
      );
    }

    return null;
  }

  /// Демонстрация деструктурирования списка (List pattern destructuring)
  /// с отделением первых элементов и хвоста (...rest).
  static void demonstrateListDestructuring(List<dynamic> rawUsers) {
    print('\n${'=' * 80}');
    print('  ДЕСТРУКТУРИРОВАНИЕ СПИСКА (LIST PATTERN DESTRUCTURING)');
    print('=' * 80);

    // Паттерн деструктурирования списка: первый, второй и остальные (...rest)
    switch (rawUsers) {
      case [final first, final second, ...final remaining]:
        if (first is Map && second is Map) {
          print('Успешно распакован список пользователей через паттерн [first, second, ...remaining]:');
          print('  • Первый пользователь:  id=${first['id']}, name=${first['name']}');
          print('  • Второй пользователь:  id=${second['id']}, name=${second['name']}');
          print('  • Остальные пользователи: в хвосте списка осталось ${remaining.length} чел.');
        }
      case [final onlyOne]:
        if (onlyOne is Map) {
          print('В списке только один пользователь: id=${onlyOne['id']}');
        }
      case []:
        print('Список пользователей пуст!');
    }
  }

  /// Демонстрация деструктурирования кортежей/записей (Record pattern destructuring).
  static void demonstrateRecordDestructuring(UserRecord user) {
    // Полное деструктурирование именованных полей записи с использованием синтаксиса (:field)
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

    final line = '─' * 70;
    print('\n$line');
    print('  КАРТОЧКА ПОЛЬЗОВАТЕЛЯ #$id (РАСПАКОВАНО ИЗ RECORD)');
    print(line);
    print('  ФИО:            $name (@$username)');
    print('  Email:          $email');
    print('  Компания:       $companyName ("$catchPhrase")');
    print('  Адрес:          $fullAddress');
    print('  Координаты:     $coordinates');
    print('  Полушарие:      $hemisphere');
    print(line);
  }

  /// Деструктурирование позиционного кортежа (Positional Record).
  static void demonstratePositionalRecordDestructuring(
      (int, String, String, double) clubTuple) {
    // Распаковка позиционной записи
    final (place, clubName, sport, budget) = clubTuple;
    print('Позиционная запись: Место: $place | Клуб: "$clubName" | Спорт: $sport | Бюджет: ${budget.toStringAsFixed(2)} руб.');
  }

  /// Печатает сводную таблицу всех деструктурированных пользователей.
  static void printUsersTable(List<UserRecord> users) {
    print('\n${'=' * 108}');
    print('  ТАБЛИЦА ПОЛЬЗОВАТЕЛЕЙ (ПОЛУЧЕНО ИЗ API И ПРЕОБРАЗОВАНО ЧЕРЕЗ ДЕСТРУКТУРИРОВАНИЕ)');
    print('=' * 108);

    final divider =
        '+${'-' * 6}+${'-' * 22}+${'-' * 26}+${'-' * 24}+${'-' * 26}+';
    final header =
        '| ${'ID'.padRight(4)} | ${'Имя'.padRight(20)} | ${'Email'.padRight(24)} | ${'Компания'.padRight(22)} | ${'Полушарие / Коорд.'.padRight(24)} |';

    print(divider);
    print(header);
    print(divider);

    for (final user in users) {
      // Деструктурирование именованной записи
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

      final idStr = id.toString().padRight(4);
      final nameStr = (name.length > 20 ? '${name.substring(0, 17)}...' : name).padRight(20);
      final emailStr = (email.length > 24 ? '${email.substring(0, 21)}...' : email).padRight(24);
      final compStr = (companyName.length > 22 ? '${companyName.substring(0, 19)}...' : companyName).padRight(22);
      final hemiStr = (hemisphere.length > 24 ? '${hemisphere.substring(0, 21)}...' : hemisphere).padRight(24);

      print('| $idStr | $nameStr | $emailStr | $compStr | $hemiStr |');
    }
    print(divider);
  }
}
