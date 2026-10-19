import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';

/// Pantalla principal: lista de usuarios + interruptor de tema.
/// Es StatelessWidget: no se usa setState en ningún momento.
class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        actions: [
          Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
          Switch(
            value: isDarkMode,
            onChanged: (_) => context.read<ThemeProvider>().toggleTheme(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _buildBody(context, userProvider),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Recargar',
        onPressed: () => context.read<UserProvider>().loadUsers(),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildBody(BuildContext context, UserProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(provider.error!, textAlign: TextAlign.center),
        ),
      );
    }

    if (provider.users.isEmpty) {
      return const Center(child: Text('No hay usuarios'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: provider.users.length,
      itemBuilder: (context, index) {
        final user = provider.users[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(child: Text(user.name[0])),
            title: Text(user.name),
            subtitle: Text('@${user.username} · ${user.email}\n'
                '${user.city} · ${user.phone}'),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
