import 'package:flutter/material.dart';

class ProviderTema with ChangeNotifier {
  bool _esOscuro = true;

  bool get esOscuro => _esOscuro;

  ThemeMode get temaActual => _esOscuro ? ThemeMode.dark : ThemeMode.light;

  void cambiaTema(bool estaEncendido) {
    print(estaEncendido);
    _esOscuro = estaEncendido;
    notifyListeners();
  }
}
