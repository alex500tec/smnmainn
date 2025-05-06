import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:smn/models/modelo_dia.dart';
import 'package:smn/providers/provider_municipio.dart';

class ServicioCargaDia {
  Future<List<ModeloDia>> descargaDia(BuildContext context, int index) async {
    var ahora = DateTime.now(); //Obtengo hor y fecha actual
    var formateador = DateFormat('yyyyMMdd'); //Digo el formato que necesito
    String fechaFormateada =
        formateador.format(ahora); //Asigno la fecha 20250430
    try {
      final providerMunicipio =
          Provider.of<ProviderMunicipio>(context, listen: false);

      String respuesta = "";

      final url = Uri.parse(
          'https://smn.conagua.gob.mx/tools/PHP/pronostico_municipios_grafico/controlador/leeJsonHorario.php?edo=${providerMunicipio.idEdo}&mun=${providerMunicipio.idMpo}&fechayhora=$fechaFormateada');

      final datosRemotos = await http.get(url);

      if (datosRemotos.statusCode == 200) {
        respuesta = datosRemotos.body;
      }

      List<dynamic> listaDedia = jsonDecode(respuesta);

      //print(listaDedia);

      return listaDedia.map((dia) => ModeloDia.fromJson(dia)).toList();
    } catch (e) {
      return [];
    }
  }
}
