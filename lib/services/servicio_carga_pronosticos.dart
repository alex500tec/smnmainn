import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:smn/models/modelo_pronostico.dart';

class ServicioCargaPronosticos {
  Future<List<ModeloPronostico>> descargaPronosticos() async {
    try {
      final String respuesta =
          await rootBundle.loadString('assets/data/pronosticos.json');

      List<dynamic> pronosticos = jsonDecode(respuesta);

      return pronosticos.map((dia) => ModeloPronostico.fromJson(dia)).toList();
    } catch (e) {
      return [];
    }
  }
}
