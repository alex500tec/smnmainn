import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diacritic/diacritic.dart';

import 'package:smn/models/modelo_municipio.dart';
import 'package:smn/providers/provider_dias.dart';
import 'package:smn/providers/provider_pronosticos.dart';
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

    final providerPronostico =
        Provider.of<ProviderPronosticos>(context, listen: false);
    final diasProvider = Provider.of<ProviderDias>(context, listen: false);

    final nombreProcesado = removeDiacritics(nombreDeMunicipio.toLowerCase());

    _esta_cargando = true;

    notifyListeners();

    ModeloMunicipio ubicacionActual = _lista_de_municipios.firstWhere(
        (elemento) {
      final nombreEnLista = removeDiacritics(elemento.label.toLowerCase());
      return nombreEnLista.contains(nombreProcesado.toLowerCase());
    },
        orElse: () => ModeloMunicipio(
            label: "Municipio no encontrado", idEdo: "", idMpo: "idMpo"));

    _esta_cargando = false;
    notifyListeners();

    //Agregar validacion si no se encontró la ciudad
    await providerPronostico.cargaPronosticos(
      context,
      nuevaCiudad: true,
    );

    diasProvider.cargaDia(context, 0);

    return ubicacionActual;
  }
}
