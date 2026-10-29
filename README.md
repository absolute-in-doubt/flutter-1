# Лабораторная работа №1. Основы языка программирования Dart

**Дисциплина:** КПМП  
**Вариант:** 11  

---

## 📌 Содержание работы и требования варианта 11

### Часть 1: Обработка разнотипных данных и Null Safety (Вариант 11)
> **Условие:** Напишите приложение, позволяющее пользователю вводить список значений разных типов, которые могут быть пустыми (`null`). Разделите их по типам в отдельные списки: целые числа (`int`), числа с плавающей точкой (`double`), строки (`String`), логические значения (`bool`) и пустые (`null`). Для числовых типов вычислите сумму (приведя целые к числам с плавающей точкой). Выведите в терминал полученные списки и суммы.

* **Реализация:**
  - Класс `TypeClassifier` и модель `TypeClassificationResult` ([type_classifier.dart](file:///c:/L%20shit/КПМП/lab1.1/lib/part1/type_classifier.dart)).
  - Поддержка ввода:
    1. Интерактивный демонстрационный режим с разнотипными данными.
    2. Ввод одной строкой через запятую с распознаванием кавычек (`42, 3.14, "Привет, мир!", true, null`).
    3. Поэлементный ввод с клавиатуры до ввода ключевого слова `done`.
  - Применение сопоставления шаблонов Dart 3 (`switch (item) { case int val: ... }`).
  - Вычисление суммы целых чисел, вещественных чисел и общей суммы с приведением к `double`.
  - Контроль наличия `null` значений с использованием `Null Safety` (`List<Object?>`).

---

### Часть 2: Объектно-ориентированное программирование и Mixin (Вариант 11)
> **Условие:**
> 1. Построить базовый абстрактный класс. Реализовать минимум два наследника, каждый со своими уникальными полями и методами.
> 2. Реализовать переопределение методов (`@override`).
> 3. `Mixin`. Добавить класс для вывода информации об объектах.
>
> **Предметная область:** Спортивные секции
> - **Базовый класс:** `SportsClub`
> - **Наследники:** `FootballClub`, `SwimmingClub`

* **Реализация:**
  - **Базовый абстрактный класс** [`SportsClub`](file:///c:/L%20shit/КПМП/lab1.1/lib/part2/sports_club.dart):
    - Поля: `id`, `name`, `city`, `headCoach`, `monthlyFee`, `membersCount`, `maxCapacity`, `foundedDate`, `schedule`.
    - Геттеры/сеттеры: `availableSpots`, `isFull`, `annualRevenue`, `netAnnualBalance`, `clubAgeYears`.
    - Общие методы: `enrollMember()`, `removeMember()`, `addScheduleSlot()`.
    - Абстрактные методы: `void conductTraining()`, `double calculateOperatingCosts()`, `String getSportType()`, `Map<String, dynamic> getClubStats()`.
  - **Наследник 1** [`FootballClub`](file:///c:/L%20shit/КПМП/lab1.1/lib/part2/football_club.dart):
    - Уникальные поля: `pitchType` (тип газона), `league` (лига), `matchSquadSize`, `trophiesCount`, `hasYouthAcademy`, `homeStadium`.
    - Уникальные методы: `playMatch()`, `conductTacticalBriefing()`, `awardTrophy()`.
    - Переопределенные методы: `conductTraining()`, `calculateOperatingCosts()`, `getSportType()`, `getClubStats()`, `toString()`.
  - **Наследник 2** [`SwimmingClub`](file:///c:/L%20shit/КПМП/lab1.1/lib/part2/swimming_club.dart):
    - Уникальные поля: `poolLengthMeters` (длина чаши), `lanesCount` (число дорожек), `waterTemperature`, `poolType`, `hasSauna`, `availableStyles`.
    - Уникальные методы: `adjustWaterTemperature()`, `checkWaterQuality()`, `conductTimeTrial()`.
    - Переопределенные методы: `conductTraining()`, `calculateOperatingCosts()`, `getSportType()`, `getClubStats()`, `toString()`.
  - **Примесь (Mixin)** [`PrintableInfo`](file:///c:/L%20shit/КПМП/lab1.1/lib/part2/printable_mixin.dart):
    - Методы: `printLog()`, `formatHeader()`, `formatFillStatus()`.
  - **Класс для вывода информации** [`ClubInfoPrinter`](file:///c:/L%20shit/КПМП/lab1.1/lib/part2/club_info_printer.dart):
    - Методы: `printClubDetails()`, `printComparisonTable()`, `simulateTrainingDay()`.

---

### Часть 3: Асинхронный API-клиент и деструктурирование данных
> **Условие:** Получить данные с любого публичного API и преобразовать данные для отображения в консоли с помощью деструктурирования.

* **Реализация:**
  - [`ApiService`](file:///c:/L%20shit/КПМП/lab1.1/lib/part3/api_service.dart):
    - Асинхронный HTTP-запрос через `package:http` к `https://jsonplaceholder.typicode.com/users`.
    - Автономный fallback с локальным JSON при отсутствии сетевого соединения.
  - [`DataDestructuringDemo`](file:///c:/L%20shit/КПМП/lab1.1/lib/part3/data_destructuring.dart):
    - **Map pattern destructuring**: глубокое извлечение `address`, `geo`, `company` без промежуточных обращений по индексам.
    - **List pattern destructuring**: извлечение первого, второго и остальных элементов через `[first, second, ...remaining]`.
    - **Record pattern destructuring**: распаковка кортежей с именованными полями `(:id, :name, :email, ...)` и позиционными полями `(place, clubName, sport, budget)`.
    - **Switch pattern matching**: определение географического полушария по координатам широты `lat`.
    - Табличный вывод данных в консоль.

---

## 📂 Структура проекта

```
lab1.1/
├── pubspec.yaml                 # Зависимости проекта (http, lints, test)
├── analysis_options.yaml        # Настройки статического анализатора кода
├── README.md                    # Документация лабораторной работы
├── bin/
│   ├── main.dart                # Главное интерактивное меню программы
│   ├── part1_runner.dart        # Запуск только Части 1
│   ├── part2_runner.dart        # Запуск только Части 2
│   └── part3_runner.dart        # Запуск только Части 3
├── lib/
│   ├── part1/
│   │   ├── type_classifier.dart # Логика классификации типов и подсчета сумм
│   │   └── part1_app.dart       # CLI-интерфейс для Части 1
│   ├── part2/
│   │   ├── sports_club.dart     # Базовый абстрактный класс SportsClub
│   │   ├── football_club.dart   # Наследник FootballClub
│   │   ├── swimming_club.dart   # Наследник SwimmingClub
│   │   ├── printable_mixin.dart # Примесь PrintableInfo
│   │   ├── club_info_printer.dart # Класс вывода информации и сравнения
│   │   └── part2_app.dart       # Демонстрация ООП для Части 2
│   └── part3/
│       ├── api_service.dart     # Асинхронная загрузка JSON из REST API
│       ├── data_destructuring.dart # Паттерны деструктурирования (Dart 3)
│       └── part3_app.dart       # Вывод результатов Части 3
└── test/
    ├── part1_test.dart          # Unit-тесты для Части 1
    ├── part2_test.dart          # Unit-тесты для Части 2
    └── part3_test.dart          # Unit-тесты для Части 3
```

---

## 🚀 Запуск и тестирование

### 1. Установка зависимостей
```powershell
dart pub get
```

### 2. Запуск интерактивного главного меню
```powershell
dart run bin/main.dart
```

### 3. Запуск отдельных частей через консоль
```powershell
# Запуск только части 1:
dart run bin/part1_runner.dart

# Запуск только части 2:
dart run bin/part2_runner.dart

# Запуск только части 3:
dart run bin/part3_runner.dart

# Пакетный запуск всех частей подряд:
dart run bin/main.dart all
```

### 4. Запуск автоматических unit-тестов
```powershell
dart run test/part1_test.dart
dart run test/part2_test.dart
dart run test/part3_test.dart
```

### 5. Проверка кода анализатором
```powershell
dart analyze
```
*(Проверка анализатором проходит с 0 ошибок, 0 предупреждений и 0 замечаний).*
