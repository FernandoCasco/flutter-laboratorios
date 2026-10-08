# 📱 Laboratorios de Flutter

Repositorio con los laboratorios desarrollados en la materia de desarrollo móvil con **Flutter**, como parte de la carrera de Ingeniería en Sistemas y Computación en la Universidad Tecnológica de El Salvador (UTEC).

## 📂 Laboratorios

| Fecha | Laboratorio | Descripción | Temas principales |
|-------|-------------|-------------|-------------------|
| 24/09/2026 | [laboratorio-24-09-26](./laboratorio-24-09-26) | Consumo de API REST: listado de usuarios, búsqueda con formulario validado y pantalla de detalle | `http`, `FutureBuilder`, `fromJson`, `Form`, navegación entre pantallas |
| 29/09/2026 | [laboratorio-29-09-26](./laboratorio-29-09-26) | Consumo de API con Dio e interceptores para inyectar token y headers personalizados | `Dio`, `Interceptor`, `BaseOptions`, manejo de errores HTTP |
| 01/10/2026 | [laboratorio-01-10-26](./laboratorio-01-10-26) | Persistencia local de preferencias de usuario y almacenamiento seguro de token | `SharedPreferences`, `flutter_secure_storage` |
| 06/10/2026 | [laboratorio-06-10-26](./laboratorio-06-10-26) | Registro de estudiantes con formulario validado, persistencia local y listado dinámico | `Form`, validaciones con RegExp, `SharedPreferences`, JSON (`toJson`/`fromJson`), `ListView.builder` |
| 08/10/2026 | [laboratorio-08-10-26](./laboratorio-08-10-26) | Tarjeta de perfil profesional con banner, avatar superpuesto, badge de estado, métricas y botones de acción | `Stack` y `Positioned`, `BoxDecoration` (sombras, bordes, gradientes), `ClipRRect`, `Image.network`, `CircleAvatar`, `Row`/`Column`/`Expanded`, Material 3 |

## 🛠️ Tecnologías

- Flutter
- Dart
- [http](https://pub.dev/packages/http) — consumo de APIs REST
- [Dio](https://pub.dev/packages/dio) — cliente HTTP con interceptores
- [SharedPreferences](https://pub.dev/packages/shared_preferences) — persistencia local
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) — almacenamiento seguro

## ▶️ Cómo ejecutar un laboratorio

1. Clonar el repositorio:
```bash
   git clone https://github.com/FernandoCasco/flutter-laboratorios.git
```
2. Entrar a la carpeta del laboratorio que se quiere ejecutar:
```bash
   cd flutter-laboratorios/laboratorio-08-10-26
```
3. Instalar dependencias y ejecutar:
```bash
   flutter pub get
   flutter run
```

## 👤 Autor

**Fernando Casco**
Estudiante de Ingeniería en Sistemas y Computación — UTEC
GitHub: [@FernandoCasco](https://github.com/FernandoCasco)
