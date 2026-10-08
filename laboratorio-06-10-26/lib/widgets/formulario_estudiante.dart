import 'package:flutter/material.dart';

import '../models/estudiante.dart';

/// Formulario para capturar un estudiante.
/// Cuando es válido, llama a [onGuardar] con el objeto creado.
class FormularioEstudiante extends StatefulWidget {
  final Future<void> Function(Estudiante) onGuardar;

  const FormularioEstudiante({super.key, required this.onGuardar});

  @override
  State<FormularioEstudiante> createState() => _FormularioEstudianteState();
}

class _FormularioEstudianteState extends State<FormularioEstudiante> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _carnetController = TextEditingController();
  final _edadController = TextEditingController();
  bool _activo = true;

  @override
  void dispose() {
    _nombreController.dispose();
    _carnetController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  // Validaciones

  String? _validarNombre(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'El nombre es obligatorio';
    }
    final soloLetras = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]+$');
    if (!soloLetras.hasMatch(valor.trim())) {
      return 'El nombre solo puede contener letras';
    }
    return null;
  }

  String? _validarCarnet(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'El carnet es obligatorio';
    }
    final formato = RegExp(r'^[a-zA-Z0-9-]{4,15}$');
    if (!formato.hasMatch(valor.trim())) {
      return 'Carnet inválido (4 a 15 letras, números o guiones)';
    }
    return null;
  }

  String? _validarEdad(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'La edad es obligatoria';
    }
    if (!RegExp(r'^\d+$').hasMatch(valor.trim())) {
      return 'La edad debe ser un número entero';
    }
    final edad = int.parse(valor.trim());
    if (edad < 15 || edad > 100) {
      return 'La edad debe estar entre 15 y 100';
    }
    return null;
  }

  // Guardar

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    final estudiante = Estudiante(
      nombre: _nombreController.text.trim(),
      carnet: _carnetController.text.trim(),
      edad: int.parse(_edadController.text.trim()),
      activo: _activo,
    );

    await widget.onGuardar(estudiante);

    _formKey.currentState!.reset();
    _nombreController.clear();
    _carnetController.clear();
    _edadController.clear();
    setState(() => _activo = true);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Estudiante guardado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nombreController,
            decoration: const InputDecoration(
              labelText: 'Nombre completo',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: _validarNombre,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _carnetController,
            decoration: const InputDecoration(
              labelText: 'Carnet',
              prefixIcon: Icon(Icons.badge),
              border: OutlineInputBorder(),
            ),
            validator: _validarCarnet,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _edadController,
            decoration: const InputDecoration(
              labelText: 'Edad',
              prefixIcon: Icon(Icons.cake),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: _validarEdad,
          ),
          SwitchListTile(
            title: const Text('Estudiante activo'),
            value: _activo,
            onChanged: (valor) => setState(() => _activo = valor),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _guardar,
              icon: const Icon(Icons.save),
              label: const Text('Guardar'),
            ),
          ),
        ],
      ),
    );
  }
}