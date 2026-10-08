import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserService {
  static const String _url =
      'https://jsonplaceholder.typicode.com/users';

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse(_url),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            jsonDecode(response.body);

        return jsonData
            .map(
              (user) => UserModel.fromJson(
                user as Map<String, dynamic>,
              ),
            )
            .toList();
      } else {
        throw Exception(
          'Error del servidor: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception(
        'No se pudieron obtener los usuarios. Verifique su conexión a Internet.',
      );
    }
  }
}