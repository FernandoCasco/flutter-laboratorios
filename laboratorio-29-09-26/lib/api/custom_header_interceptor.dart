import 'package:dio/dio.dart';

class CustomHeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Inyección de encabezados requeridos
    options.headers['X-Client-Version'] = '2.0.0';
    options.headers['X-User-Role'] = 'Admin';

    // Imprimir la URL exacta en consola
    print('[CUSTOM INTERCEPTOR] Petición realizada a: ${options.uri}');

    // Continuar con la petición
    super.onRequest(options, handler);
  }
}