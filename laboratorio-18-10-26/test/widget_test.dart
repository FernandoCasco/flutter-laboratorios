import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:lab_arquitectura/data/datasources/user_local_datasource.dart';
import 'package:lab_arquitectura/data/repositories/user_repository_impl.dart';
import 'package:lab_arquitectura/domain/usecases/get_users.dart';
import 'package:lab_arquitectura/main.dart';
import 'package:lab_arquitectura/presentation/providers/theme_provider.dart';
import 'package:lab_arquitectura/presentation/providers/user_provider.dart';

void main() {
  testWidgets('Carga usuarios y cambia el tema con el Switch', (tester) async {
    final getUsers = GetUsers(UserRepositoryImpl(UserLocalDataSource()));
    final themeProvider = ThemeProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: themeProvider),
          ChangeNotifierProvider(
            create: (_) => UserProvider(getUsers)..loadUsers(),
          ),
        ],
        child: const MyApp(),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Ana Martínez'), findsOneWidget);

    expect(themeProvider.isDarkMode, isFalse);
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(themeProvider.isDarkMode, isTrue);
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
  });
}
