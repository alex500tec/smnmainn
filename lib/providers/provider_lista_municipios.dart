import 'package:flutter/material.dart';

import 'package:smn/models/modelo_municipio.dart';
import 'package:smn/services/servicio_carga_municipios.dart';

//extends, implements, mixin
class ProviderListaMunicipios with ChangeNotifier {
  List<ModeloMunicipio> _lista_de_municipios = [];
  List<ModeloMunicipio> _lista_de_municipios_filtrada = [];
  bool _esta_cargando = false;

  List<ModeloMunicipio> get listaDeMunicipiosFiltrada =>
      _lista_de_municipios_filtrada;

  bool get estaCargando => _esta_cargando;

  Future<void> cargaMunicipios() async {
    _esta_cargando = true;
    notifyListeners();

    try {
      if (_lista_de_municipios.isEmpty) {
        _lista_de_municipios =
            await ServicioCargaMunicipios().descargaMunicipios();
      }

      _lista_de_municipios_filtrada = List.from(_lista_de_municipios);
    } catch (e) {
      print(e);
    } finally {
      _esta_cargando = false;
      notifyListeners();
    }
  }

  void filtrarMunicipios(String texto) {
    if (texto.isEmpty) {
      _lista_de_municipios_filtrada = List.from(_lista_de_municipios);
    } else {
      _lista_de_municipios_filtrada = _lista_de_municipios
          .where((municipio) =>
              municipio.label.toLowerCase().contains(texto.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<ModeloMunicipio> obtenerMunicipioPorNombre(
      BuildContext context, String nombreDeMunicipio) async {
    if (_lista_de_municipios.isEmpty) {
      await cargaMunicipios();
    }

    final ciudad = _lista_de_municipios.firstWhere(
        (municipio) => municipio.label
            .toLowerCase()
            .contains(nombreDeMunicipio.toLowerCase()),
        orElse: () => ModeloMunicipio(
            label: "Ciudad no encontrada", idEdo: "", idMpo: ""));

    return ciudad;
  }
}
