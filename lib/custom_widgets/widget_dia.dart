import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smn/custom_widgets/texto_gris_negrita.dart';
import 'package:smn/models/modelo_pronostico.dart';
import 'package:weather_icons/weather_icons.dart';

class WidgetDia extends StatelessWidget {
  final ModeloPronostico pronostico;
  final int index;

  WidgetDia({
    super.key,
    required this.pronostico,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    String fechaFormateada = pronostico.fecha ?? "";

    DateFormat formatoEntrada = DateFormat("d/MM");
    DateTime fechaConvertida = formatoEntrada.parse(fechaFormateada);

    if (index == 0) {
      fechaFormateada = "Hoy";
    } else if (index == 1) {
      fechaFormateada = "Mañana";
    } else {
      DateFormat formatodesalida = DateFormat("EEEE", "es_ES");
      fechaFormateada = formatodesalida.format(fechaConvertida);
    }

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: LayoutBuilder(builder: (context, condicionantes) {
        double ancho = condicionantes.maxWidth;
        bool esTelefono = MediaQuery.of(context).size.width <= 600;

        double tamano = esTelefono ? (ancho / 2) - 10 : ancho;

        return Container(
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fechaFormateada,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                pronostico.fecha.toString(),
                style: TextStyle(color: Colors.black38),
              ),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  SizedBox(
                    width: tamano,
                    child: Icon(
                      WeatherIcons.day_sunny,
                      size: 80,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(
                    width: tamano,
                    child: Column(
                      children: [
                        Text(pronostico.desciel),
                        Row(
                          children: [
                            Text(
                              pronostico.tmax,
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.redAccent,
                              ),
                            ),
                            Text(
                              "/${pronostico.tmin} ºC",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: tamano,
                    child: TextoGrisNegrita(
                      texto: "Lluvia ",
                      medida: "${pronostico.prec} lts/m2",
                    ),
                  ),
                  SizedBox(
                    width: tamano,
                    child: TextoGrisNegrita(
                      texto: "Prob de lluvia ",
                      medida: "${pronostico.probprec} lts/m2",
                    ),
                  ),
                  SizedBox(
                    width: tamano,
                    child: TextoGrisNegrita(
                      texto: "Vel del viento",
                      medida: "${pronostico.velvien} kms/h",
                    ),
                  ),
                  SizedBox(
                    width: tamano,
                    child: TextoGrisNegrita(
                      texto: "Dir del viento",
                      medida: "${pronostico.dirvienc}",
                    ),
                  ),
                  SizedBox(
                    width: tamano,
                    child: TextoGrisNegrita(
                      texto: "Ráf de viento",
                      medida: "${pronostico.raf} kms/h",
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
