import 'package:flutter/material.dart';

import '../models/search_filter_dto.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'user_detail_screen.dart';

class UsersFeedScreen extends StatefulWidget {
  final SearchFilterDto filter;

  const UsersFeedScreen({
    super.key,
    required this.filter,
  });

  @override
  State<UsersFeedScreen> createState() => _UsersFeedScreenState();
}

class _UsersFeedScreenState extends State<UsersFeedScreen> {
  final UserService _userService = UserService();

  late Future<List<UserModel>> _usersFuture;

  @override
  void initState() {
    super.initState();

    _usersFuture = _userService.getUsers();
  }

  List<UserModel> _filterUsers(List<UserModel> users) {
    final company = widget.filter.company.trim().toLowerCase();

    if (company.isEmpty) {
      return users;
    }

    return users.where((user) {
      return user.company.toLowerCase().contains(company);
    }).toList();
  }

  Future<void> _openUserDetail(UserModel user) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailScreen(
          user: user,
        ),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directorio de Usuarios'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 70,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No se pudieron cargar los usuarios.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No existen datos disponibles.',
              ),
            );
          }

          final users = _filterUsers(snapshot.data!);

          if (users.isEmpty) {
            return const Center(
              child: Text(
                'No se encontraron usuarios para esa empresa.',
              ),
            );
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final UserModel user = users[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      user.name.isNotEmpty
                          ? user.name[0].toUpperCase()
                          : '?',
                    ),
                  ),
                  title: Text(user.name),
                  subtitle: Text(
                    '${user.company}\n${user.email}',
                  ),
                  isThreeLine: true,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onTap: () => _openUserDetail(user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}