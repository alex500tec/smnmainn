import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smn/models/modelo_pronostico.dart';

class ServicioCargaPronosticos {
  Future<List<ModeloPronostico>> descargaPronosticos(
    String idEdo,
    String idMpo,
  ) async {
    var ahora = DateTime.now(); //Obtengo hor y fecha actual
    var formateador = DateFormat('yyyyMMdd'); //Digo el formato que necesito
    String fechaFormateada =
        formateador.format(ahora); //Asigno la fecha 20250430

    try {
      String respuesta = "";
      final url = Uri.parse(
          'https://smn.conagua.gob.mx/tools/PHP/pronostico_municipios_grafico/controlador/getDataJson2String.php?edo=$idEdo&mun=$idMpo');

      final datosRemotos = await http.get(url);

      print(datosRemotos);

      if (datosRemotos.statusCode == 200) {
        respuesta = datosRemotos.body;
      }
      /*
      final String respuesta =
          await rootBundle.loadString('assets/data/pronosticos.json');
      */
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
