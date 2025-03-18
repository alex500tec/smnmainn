import 'package:flutter/material.dart';
import 'package:smn/custom_widgets/texto_gris_negrita.dart';
import 'package:smn/models/modelo_pronostico.dart';

class DiaPrincipal extends StatelessWidget {
  final ModeloPronostico dia;
  DiaPrincipal({super.key, required this.dia});

  Widget Separador() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          border: Border(
        right: BorderSide(
          color: Colors.black54,
          width: 2,
        ),
      )),
      child: SizedBox(
        width: 40,
        height: 40,
      ),
    );
  }

  Widget Elemento(String texto, IconData icono, String medida) {
    return Column(
      children: [
        Text(texto),
        Row(
          children: [Icon(icono), Text(medida)],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(dia.desciel),
        Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.sunny,
              color: Colors.amber,
              size: 80,
            ),
            Text(
              dia.tmax,
              style: TextStyle(
                fontSize: 70.0,
                color: Colors.redAccent,
              ),
            ),
            Text(
              "/${dia.tmin} ºC",
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.blueAccent,
              ),
            ),
          ]),
        ),
        MediaQuery.of(context).size.width <= 600
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    TextoGrisNegrita(
                        texto: "Probabilidad de lluvia:", medida: dia.probprec),
                    TextoGrisNegrita(
                        texto: "Velocidad del viento:", medida: dia.velvien),
                    TextoGrisNegrita(
                        texto: "Dirección del viento:", medida: dia.dirvienc),
                    TextoGrisNegrita(
                        texto: "Ráfaga de viento:", medida: dia.raf),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Elemento("Lluvia", Icons.water_drop, "${dia.prec}lts/m2"),
                  Separador(),
                  Elemento("Probabilidad de lluvia", Icons.cloudy_snowing,
                      "${dia.probprec}lts/m2"),
                  Separador(),
                  Elemento("Dirección del viento", Icons.arrow_outward,
                      "${dia.dirvienc}kms/h"),
                  Separador(),
                  Elemento("Velocidad del viento", Icons.speed_outlined,
                      "${dia.velvien}kms/h"),
                ],
              )
      ],
    );
  }
}
