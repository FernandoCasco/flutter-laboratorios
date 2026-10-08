import 'package:dio/dio.dart';
import '../api/dio_client.dart';
import '../models/post_model.dart';

class PostService {
  final DioClient _dioClient = DioClient();

  Future<Post> getPostDetail() async {
    try {
      // Petición al endpoint indicado
      final response = await _dioClient.client.get('/posts/1');
      return Post.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      // Manejo defensivo especificando el tipo de error
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw Exception('Tiempo de espera agotado. El servidor tardó demasiado en responder.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Sin conexión a internet. Verifique su red.');
      } else if (e.response != null) {
        throw Exception('Error en el servidor (${e.response?.statusCode}): ${e.response?.statusMessage}');
      } else {
        throw Exception('Error inesperado de red: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error inesperado procesando la información.');
    }
  }
}