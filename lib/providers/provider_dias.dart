import 'package:flutter/material.dart';
import 'package:smn/models/modelo_dia.dart';
import 'package:smn/services/servicio_carga_dia.dart';

class ProviderDias with ChangeNotifier {
  List<ModeloDia> _dia = [];
  bool _esta_cargando = false;

  List<List<dynamic>> dias = [
    [],
    [],
    [],
    [],
  ];

  List<ModeloDia> get dia => _dia;
  bool get estCargando => _esta_cargando;

  Future<void> cargaDia(BuildContext context, int index) async {
    _esta_cargando = true;
    notifyListeners();

    try {
      //if (dias[index].isEmpty) {
      _dia = await ServicioCargaDia().descargaDia(context, index);
      dias[index] = _dia;
      //}
    } catch (e) {
      //print(e);
    } finally {
      _esta_cargando = false;
      notifyListeners();
    }
  }
}
