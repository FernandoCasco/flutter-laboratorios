import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailScreen({
    super.key,
    required this.user,
  });

  Widget _buildDetail(
    IconData icon,
    String title,
    String value,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.account_circle,
              size: 100,
            ),

            const SizedBox(height: 20),

            _buildDetail(
              Icons.person,
              'Nombre',
              user.name,
            ),

            _buildDetail(
              Icons.email,
              'Correo',
              user.email,
            ),

            _buildDetail(
              Icons.phone,
              'Teléfono',
              user.phone,
            ),

            _buildDetail(
              Icons.language,
              'Sitio Web',
              user.website,
            ),

            _buildDetail(
              Icons.business,
              'Compañía',
              user.company,
            ),

            const Spacer(),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(
                  context,
                  'Usuario Seleccionado',
                );
              },
              icon: const Icon(
                Icons.check_circle,
              ),
              label: const Text(
                'Confirmar Selección',
              ),
            ),
          ],
        ),
      ),
    );
  }
}