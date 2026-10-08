import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/estudiante.dart';

/// Guarda y lee la lista de estudiantes en SharedPreferences.
/// Cada Estudiante se convierte a un String JSON y se guarda
/// la lista completa con setStringList.
class EstudianteStorage {
  static const String _clave = 'estudiantes';

  static Future<List<Estudiante>> cargar() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> listaJson = prefs.getStringList(_clave) ?? [];

    return listaJson
        .map((texto) => Estudiante.fromJson(jsonDecode(texto)))
        .toList();
  }

  static Future<void> agregar(Estudiante estudiante) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> listaJson = prefs.getStringList(_clave) ?? [];

    listaJson.add(jsonEncode(estudiante.toJson()));
    await prefs.setStringList(_clave, listaJson);
  }
}