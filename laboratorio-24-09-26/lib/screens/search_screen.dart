import 'package:flutter/material.dart';

import '../models/search_filter_dto.dart';
import 'users_feed_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _authorizationController =
      TextEditingController();

  final TextEditingController _companyController =
      TextEditingController();

  void _goToUsers() {
    if (_formKey.currentState!.validate()) {
      final filter = SearchFilterDto(
        authorizationCode: _authorizationController.text.trim(),
        company: _companyController.text.trim(),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UsersFeedScreen(
            filter: filter,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _authorizationController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador de Perfiles'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.manage_search,
                size: 80,
              ),

              const SizedBox(height: 30),

              TextFormField(
                controller: _authorizationController,
                decoration: const InputDecoration(
                  labelText: 'Código de Autorización',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El código es obligatorio';
                  }

                  if (value.trim().length < 4) {
                    return 'Debe contener al menos 4 caracteres';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de Empresa u Organización',
                  prefixIcon: Icon(Icons.business),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: _goToUsers,
                icon: const Icon(Icons.search),
                label: const Text('Buscar Perfiles'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}