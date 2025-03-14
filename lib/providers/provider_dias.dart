import 'package:flutter/material.dart';
import 'package:smn/models/modelo_dia.dart';
import 'package:smn/services/servicio_carga_dia.dart';

class ProviderDias with ChangeNotifier {
  List<ModeloDia> _dias = [];
  bool _esta_cargando = false;

  List<ModeloDia> get dias => _dias;
  bool get estCargando => _esta_cargando;

  Future<void> cargaDia(int index) async {
    _esta_cargando = true;
    notifyListeners();

    try {
      if (_dias.isEmpty) {
        _dias = await ServicioCargaDia().descargaDia(index);
      }
    } catch (e) {
      print(e);
    } finally {
      _esta_cargando = false;
      notifyListeners();
    }
  }
}
