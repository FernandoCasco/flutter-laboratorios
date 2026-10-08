import 'package:flutter/material.dart';

import '../models/estudiante.dart';
import '../services/estudiante_storage.dart';
import '../widgets/formulario_estudiante.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Estudiante> _estudiantes = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarEstudiantes(); // Recupera los datos al iniciar la pantalla
  }

  Future<void> _cargarEstudiantes() async {
    final lista = await EstudianteStorage.cargar();
    setState(() {
      _estudiantes = lista;
      _cargando = false;
    });
  }

  /// Se llama desde el formulario: guarda en SharedPreferences
  /// y actualiza la lista en pantalla con setState.
  Future<void> _agregarEstudiante(Estudiante estudiante) async {
    await EstudianteStorage.agregar(estudiante);
    setState(() {
      _estudiantes.add(estudiante);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Estudiantes')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FormularioEstudiante(onGuardar: _agregarEstudiante),
          const SizedBox(height: 24),
          Text(
            'Estudiantes registrados (${_estudiantes.length})',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(),
          if (_cargando)
            const Center(child: CircularProgressIndicator())
          else if (_estudiantes.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: Text('Aún no hay estudiantes registrados')),
            )
          else
            ListView.builder(
              shrinkWrap: true, // necesario porque está dentro de otro ListView
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _estudiantes.length,
              itemBuilder: (context, index) {
                final e = _estudiantes[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(e.nombre[0].toUpperCase()),
                    ),
                    title: Text(e.nombre),
                    subtitle: Text('Carnet: ${e.carnet}  •  Edad: ${e.edad}'),
                    trailing: Chip(
                      label: Text(e.activo ? 'Activo' : 'Inactivo'),
                      backgroundColor: e.activo
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}