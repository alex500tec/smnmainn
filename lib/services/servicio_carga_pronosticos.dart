import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smn/models/modelo_pronostico.dart';
import 'package:smn/providers/provider_municipio.dart';

class ServicioCargaPronosticos {
  Future<List<ModeloPronostico>> descargaPronosticos(
      BuildContext context) async {
    try {
      final providerMunicipio =
          Provider.of<ProviderMunicipio>(context, listen: false);

      String respuesta = "";
      final url = Uri.parse(
          'https://smn.conagua.gob.mx/tools/PHP/pronostico_municipios_grafico/controlador/getDataJson2String.php?edo=${providerMunicipio.idEdo}&mun=${providerMunicipio.idMpo}');

      final datosRemotos = await http.get(url);

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
