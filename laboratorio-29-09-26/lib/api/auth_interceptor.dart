import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Token simulado (en producción se lee desde un almacenamiento seguro)
    const String fakeToken = "JWT_TOKEN_ABC123_SECURE";

    // Inyección automática del header de autenticación
    options.headers['Authorization'] = 'Bearer $fakeToken';
    options.headers['Content-Type'] = 'application/json';

    print('[AUTH INTERCEPTOR] Token inyectado a la petición: ${options.path}');

    // Continuar con la petición
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('[AUTH INTERCEPTOR] Error detectado (${err.response?.statusCode}): ${err.message}');

    if (err.response?.statusCode == 401) {
      print('Token expirado o no autorizado. Redirigiendo a Login...');
    }

    super.onError(err, handler);
  }
}