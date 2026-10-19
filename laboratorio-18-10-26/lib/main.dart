import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasources/user_local_datasource.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/get_users.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/user_provider.dart';
import 'presentation/screens/user_screen.dart';

void main() {
  // Inyección de dependencias: datos -> repositorio -> caso de uso.
  final UserRepository repository = UserRepositoryImpl(UserLocalDataSource());
  final getUsers = GetUsers(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => UserProvider(getUsers)..loadUsers(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Lab Arquitectura Limpia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const UserScreen(),
    );
  }
}
