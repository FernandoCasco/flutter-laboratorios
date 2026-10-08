import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  final LocalStorageService _storageService =
      LocalStorageService();

  final TextEditingController _userController =
      TextEditingController();

  final TextEditingController _tokenController =
      TextEditingController();

  bool _rememberUser = false;
  bool _isLoading = true;

  String _savedUser = 'Ningún usuario guardado';
  String _savedToken = 'Ningún token guardado';

  @override
  void initState() {
    super.initState();
    _loadStoredData();
  }

  // ------------------------------------------------
  // CARGAR DATOS GUARDADOS
  // ------------------------------------------------

  Future<void> _loadStoredData() async {
    final user = await _storageService.getLastUser();
    final remember = await _storageService.getRememberUser();
    final token = await _storageService.getAuthToken();

    // Evita usar setState si la pantalla ya no existe
    if (!mounted) return;

    setState(() {
      _rememberUser = remember;

      _savedUser =
          user.isEmpty ? 'Ningún usuario guardado' : user;

      _savedToken =
          token ?? 'Ningún token guardado';

      _isLoading = false;
    });

    // Si "Recordar Usuario" estaba activado,
    // cargamos el usuario nuevamente en el campo.
    if (remember && user.isNotEmpty) {
      _userController.text = user;
    }
  }

  // ------------------------------------------------
  // GUARDAR PREFERENCIAS
  // ------------------------------------------------

  Future<void> _savePreferences() async {
    final user = _userController.text.trim();

    if (user.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingrese un nombre de usuario'),
        ),
      );

      return;
    }

    await _storageService.saveLastUser(user);
    await _storageService.setRememberUser(_rememberUser);

    if (!mounted) return;

    setState(() {
      _savedUser = user;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preferencias guardadas correctamente'),
      ),
    );
  }

  // ------------------------------------------------
  // GUARDAR TOKEN
  // ------------------------------------------------

  Future<void> _saveToken() async {
    final token = _tokenController.text.trim();

    if (token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingrese un Token JWT'),
        ),
      );

      return;
    }

    await _storageService.saveAuthToken(token);

    _tokenController.clear();

    final savedToken =
        await _storageService.getAuthToken();

    if (!mounted) return;

    setState(() {
      _savedToken =
          savedToken ?? 'Ningún token guardado';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Token guardado de forma segura',
        ),
      ),
    );
  }

  // ------------------------------------------------
  // CERRAR SESIÓN
  // ------------------------------------------------

  Future<void> _closeSession() async {
    // Solamente elimina el almacenamiento seguro.
    await _storageService.deleteAuthToken();

    if (!mounted) return;

    setState(() {
      _savedToken = 'Ningún token guardado';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Sesión cerrada. Las preferencias se conservaron.',
        ),
      ),
    );
  }

  // ------------------------------------------------
  // LIBERAR CONTROLADORES
  // ------------------------------------------------

  @override
  void dispose() {
    _userController.dispose();
    _tokenController.dispose();

    super.dispose();
  }

  // ------------------------------------------------
  // INTERFAZ
  // ------------------------------------------------

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Almacenamiento Híbrido',
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ========================================
            // SECCIÓN 1
            // ========================================

            const Text(
              '1. Gestor de Preferencias',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Datos no sensibles usando SharedPreferences',
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _userController,

              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
                hintText: 'Ejemplo: estudiante01',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 10),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,

              title: const Text(
                'Recordar Usuario',
              ),

              subtitle: const Text(
                'Mantener el usuario guardado al reiniciar',
              ),

              value: _rememberUser,

              onChanged: (value) {
                setState(() {
                  _rememberUser = value;
                });
              },
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: _savePreferences,

                icon: const Icon(Icons.save),

                label: const Text(
                  'Guardar Preferencias',
                ),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Row(
                  children: [
                    const Icon(Icons.person_outline),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          const Text(
                            'Último usuario guardado:',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(_savedUser),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Divider(height: 40),

            // ========================================
            // SECCIÓN 2
            // ========================================

            const Text(
              '2. Gestor Seguro',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Credenciales protegidas con Flutter Secure Storage',
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _tokenController,

              decoration: const InputDecoration(
                labelText: 'Token JWT',
                hintText: 'Ingrese un token de autenticación',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.key),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: _saveToken,

                icon: const Icon(Icons.lock),

                label: const Text(
                  'Guardar Token Seguro',
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Row(
                      children: [
                        Icon(Icons.security),

                        SizedBox(width: 8),

                        Text(
                          'Token recuperado:',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    SelectableText(
                      _savedToken,

                      style: const TextStyle(
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: _closeSession,

                icon: const Icon(
                  Icons.logout,
                ),

                label: const Text(
                  'Cerrar Sesión',
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Cerrar sesión elimina únicamente el Token JWT. '
              'El usuario y la opción "Recordar Usuario" se mantienen guardados.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}