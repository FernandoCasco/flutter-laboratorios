import 'package:dio/dio.dart';
import 'custom_header_interceptor.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: const Duration(seconds: 5), // Timeout de 5 segundos
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    // Registro del interceptor personalizado
    _dio.interceptors.add(CustomHeaderInterceptor());
  }

  // Getter para exponenciar la instancia configurada de Dio
  Dio get client => _dio;
}