import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:smn/models/modelo_pronostico.dart';

class ServicioCargaPronosticos {
  Future<List<ModeloPronostico>> descargaPronosticos() async {
    try {
      final String respuesta =
          await rootBundle.loadString('assets/data/pronosticos.json');

      List<dynamic> pronosticos = jsonDecode(respuesta);

      DateTime fechaActual = DateTime.now();
      var formateaFecha = DateFormat("d/MM");

      return pronosticos
          .asMap()
          .map((index, dia) {
            String fechaFormateada;
            DateTime otroDia = fechaActual.add(Duration(days: index));
            fechaFormateada = formateaFecha.format(otroDia);

            dia['fecha'] = fechaFormateada;

            return MapEntry(index, ModeloPronostico.fromJson(dia));
          })
          .values
          .toList();
    } catch (e) {
      return [];
    }
  }
}
