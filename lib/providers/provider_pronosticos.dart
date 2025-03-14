import 'package:flutter/material.dart';
import 'package:smn/models/modelo_pronostico.dart';
import 'package:smn/services/servicio_carga_pronosticos.dart';

class ProviderPronosticos with ChangeNotifier {
  List<ModeloPronostico> _pronosticos = [];
  bool _esta_cargando = false;

  List<ModeloPronostico> get pronosticos => _pronosticos;
  bool get estaCargando => _esta_cargando;

  Future<void> cargaPronosticos() async {
    _esta_cargando = true;
    notifyListeners();

    try {
      if (_pronosticos.isEmpty) {
        _pronosticos = await ServicioCargaPronosticos().descargaPronosticos();
      }
    } catch (error) {
      print(error);
    } finally {
      _esta_cargando = false;
      notifyListeners();
    }
  }
}
