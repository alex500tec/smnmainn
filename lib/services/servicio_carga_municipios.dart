import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:smn/models/modelo_municipio.dart';

class ServicioCargaMunicipios {
  Future<List<ModeloMunicipio>> descargaMunicipios() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/datos_municipios.json');

      List<dynamic> listaDeMunicipios = jsonDecode(response);

      return listaDeMunicipios
          .map((municipio) => ModeloMunicipio.fromJson(municipio))
          .toList();
    } catch (e) {
      //print(e);
      return [];
    }
  }
}
