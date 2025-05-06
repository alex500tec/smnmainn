import 'package:flutter/material.dart';
import 'package:smn/models/modelo_pronostico.dart';
import 'package:smn/services/servicio_carga_pronosticos.dart';

class ProviderPronosticos with ChangeNotifier {
  List<ModeloPronostico> _pronosticos = [];
  bool _esta_cargando = false;

  List<ModeloPronostico> get pronosticos => _pronosticos;
  bool get estaCargando => _esta_cargando;

  Future<void> cargaPronosticos(String idEdo, String idMpo,
      {bool? nuevaCiudad}) async {
    _esta_cargando = true;
    notifyListeners();

    bool tieneNuevaCiudad = nuevaCiudad ?? true;

    try {
      if (_pronosticos.isEmpty || tieneNuevaCiudad) {
        _pronosticos =
            await ServicioCargaPronosticos().descargaPronosticos(idEdo, idMpo);
      }
    } catch (error) {
      print(error);
    } finally {
      _esta_cargando = false;
      notifyListeners();
    }
  }
}
