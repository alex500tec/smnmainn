import 'package:flutter/material.dart';

class ProviderTema with ChangeNotifier {
  bool _esOscuro = false;

  bool get esOscuro => _esOscuro;

  ThemeMode get temaActual => _esOscuro ? ThemeMode.dark : ThemeMode.light;

  void cambiaTema(bool estaEncendido) {
    _esOscuro = estaEncendido;
    notifyListeners();
  }
}
