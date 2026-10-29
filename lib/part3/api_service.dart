import 'dart:convert';
import 'package:http/http.dart' as http;

/// Сервис для асинхронного получения данных из публичного API.
class ApiService {
  static const String usersUrl = 'https://jsonplaceholder.typicode.com/users';

  /// Загружает список пользователей из публичного REST API.
  /// В случае сбоя сети возвращает локальный резервный набор данных.
  static Future<(List<dynamic> data, bool isFromNetwork)> fetchUsers() async {
    try {
      final uri = Uri.parse(usersUrl);
      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is List) {
          return (decoded, true);
        }
      }
      throw Exception('Неверный статус ответа: ${response.statusCode}');
    } catch (e) {
      // Резервный локальный набор данных (для автономной работы без интернета)
      return (jsonDecode(_fallbackUsersJson) as List<dynamic>, false);
    }
  }

  static const String _fallbackUsersJson = '''
  [
    {
      "id": 1,
      "name": "Leanne Graham",
      "username": "Bret",
      "email": "Sincere@april.biz",
      "address": {
        "street": "Kulas Light",
        "suite": "Apt. 556",
        "city": "Gwenborough",
        "zipcode": "92998-3874",
        "geo": { "lat": "-37.3159", "lng": "81.1496" }
      },
      "phone": "1-770-736-8031 x56442",
      "website": "hildegard.org",
      "company": {
        "name": "Romaguera-Crona",
        "catchPhrase": "Multi-layered client-server neural-net",
        "bs": "harness real-time e-markets"
      }
    },
    {
      "id": 2,
      "name": "Ervin Howell",
      "username": "Antonette",
      "email": "Shanna@melissa.tv",
      "address": {
        "street": "Victor Plains",
        "suite": "Suite 879",
        "city": "Wisokyburgh",
        "zipcode": "90566-7771",
        "geo": { "lat": "-43.9509", "lng": "-34.4618" }
      },
      "phone": "010-692-6593 x09125",
      "website": "anastasia.net",
      "company": {
        "name": "Deckow-Crist",
        "catchPhrase": "Proactive didactic contingency",
        "bs": "synergize scalable supply-chains"
      }
    },
    {
      "id": 3,
      "name": "Clementine Bauch",
      "username": "Samantha",
      "email": "Nathan@yesenia.net",
      "address": {
        "street": "Douglas Extension",
        "suite": "Suite 847",
        "city": "McKenziehaven",
        "zipcode": "59590-4157",
        "geo": { "lat": "54.8912", "lng": "23.9037" }
      },
      "phone": "1-463-123-4447",
      "website": "ramiro.info",
      "company": {
        "name": "Romaguera-Jacobson",
        "catchPhrase": "Face to face bifurcated interface",
        "bs": "e-enable innovative applications"
      }
    }
  ]
  ''';
}
