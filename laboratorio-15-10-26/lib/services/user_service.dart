import 'package:dio/dio.dart';

class UserService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<Map<String, dynamic>> getUserProfile(int userId) async {
    try {
      final response = await _dio.get('/users/$userId');
      
      if (response.statusCode == 200 && response.data != null) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Servidor respondió con código HTTP: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Tiempo de espera agotado al conectar con el servidor.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Sin conexión a Internet o servicio no disponible.');
      } else if (e.response != null) {
        throw Exception('Error del servidor: ${e.response!.statusCode}');
      }
      throw Exception('Error de red al consultar el servicio: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado en UserService: $e');
    }
  }
}