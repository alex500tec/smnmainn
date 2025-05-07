import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smn/models/modelo_municipio.dart';

class Favoritos {
  static const _key = "municipios_favoritos";

  static Future<void> agregarAFavoritos(ModeloMunicipio municipio) async {
    final prefs = await SharedPreferences.getInstance();
    final listaActual = await obtenerFavoritos();
    final existe = listaActual
        .any((c) => municipio.idEdo == c.idEdo && municipio.idMpo == c.idMpo);

    if (!existe) {
      listaActual.add(municipio);
      final listaAJson =
          listaActual.map((c) => json.encode(c.toJson())).toList();

      await prefs.setStringList(_key, listaAJson);
    }
  }

  static Future<List<ModeloMunicipio>> obtenerFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final listaJson = prefs.getStringList(_key) ?? [];

    return listaJson
        .map((elemento) => ModeloMunicipio.fromJson(json.decode(elemento)))
        .toList();
  }

  static Future<void> eliminarDeFavoritos(String idEdo, String idMpo) async {
    final prefs = await SharedPreferences.getInstance();
    final listaActual = await obtenerFavoritos();
    listaActual.removeWhere((c) => idEdo == c.idEdo && idMpo == c.idMpo);

    final jsonLista = listaActual.map((c) => json.encode(c.toJson())).toList();
    await prefs.setStringList(_key, jsonLista);
  }
}
