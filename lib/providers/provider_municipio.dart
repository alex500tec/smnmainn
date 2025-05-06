import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smn/providers/provider_dias.dart';
import 'package:smn/providers/provider_pronosticos.dart';

class ProviderMunicipio with ChangeNotifier {
  String? ciudadNombre;
  String? idEdo;
  String? idMpo;

  Future<void> setCiudad(
    BuildContext context, {
    required String nombre,
    required String IdEdo,
    required String IdMpo,
  }) async {
    ciudadNombre = nombre;
    idEdo = IdEdo;
    idMpo = IdMpo;

    notifyListeners();

    final providerPronostico =
        Provider.of<ProviderPronosticos>(context, listen: false);
    final providerDias = Provider.of<ProviderDias>(context, listen: false);

    await providerPronostico.cargaPronosticos(
      context,
      nuevaCiudad: true,
    );

    providerDias.cargaDia(context, 0);
  }

  bool get tieneDatos => idEdo != null && idMpo != null;
}
