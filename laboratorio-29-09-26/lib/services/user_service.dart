import 'package:dio/dio.dart';
import '../api/dio_client.dart';

class UserService {
  final DioClient _dioClient = DioClient();

  Future<Map<String, dynamic>> getUserProfile(int userId) async {
    try {
      final response = await _dioClient.client.get('/users/$userId');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('El servidor tardó demasiado en responder.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Sin conexión a internet.');
      } else {
        throw Exception('Error en la petición: ${e.message}');
      }
    }
  }
}