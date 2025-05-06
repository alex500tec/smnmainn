import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smn/models/modelo_dia.dart';
import 'package:smn/providers/provider_dias.dart';
import '../utils/utils.dart';

class AcordeonDias extends StatelessWidget {
  final String fecha;
  final int index;

  const AcordeonDias({
    super.key,
    required this.fecha,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final providerDias = Provider.of<ProviderDias>(context);
    final dias = providerDias.dias[index];

    if (providerDias.estCargando) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: ExpansionPanelList.radio(
        initialOpenPanelValue: 0,
        children: dias.asMap().entries.map((elemento) {
          int elementoIndex = elemento.key;
          ModeloDia dia = elemento.value;

          return ExpansionPanelRadio(
            value: elementoIndex,
            headerBuilder: (context, isExpanded) {
              return ListTile(
                leading: SizedBox(
                  width: 300,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('${dia.time}:00h'),
                            Text(
                              fecha,
                              style: TextStyle(color: Colors.black26),
                            ),
                          ],
                        ),
                        Utils.Icono(dia.desciel, 30),
                        Text(
                          "${dia.temp}°C",
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Text(
                          dia.desciel,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            body: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Temperatura: ${dia.temp}°C"),
                  Text("Cielo: ${dia.desciel}"),
                  Text("Probabilidad de lluvia: ${dia.probprec}%"),
                  Text("Precipitación: ${dia.prec} mm"),
                  Text("Viento: ${dia.velvien} km/h (${dia.dirvienc})"),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
