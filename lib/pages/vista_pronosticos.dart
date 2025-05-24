// archivo: vista_pronostico.dart
import 'package:flutter/material.dart';
import 'package:smn/models/modelo_municipio.dart';

class VistaPronostico extends StatelessWidget {
  final ModeloMunicipio municipio;

  const VistaPronostico({Key? key, required this.municipio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Aquí puedes incluir la lógica para mostrar el pronóstico detallado
    // utilizando los datos del objeto municipio.
    return Scaffold(
      appBar: AppBar(
        title: Text(municipio.label),
      ),
      body: Center(
        child: Text(
          'Datos meteorológicos para ${municipio.label}, Estado ID: ${municipio.idEdo}',
        ),
      ),
    );
  }
}
