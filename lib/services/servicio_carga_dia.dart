import 'dart:convert';
import 'package:flutter/services.dart';

// ignore: depend_on_referenced_packages
import 'package:smn/models/modelo_dia.dart';

class ServicioCargaDia {
  Future<List<ModeloDia>> descargaDia(int index) async {
    try {
      final String response =
          await rootBundle.loadString("assets/data/dia${index + 1}.json");

      List<dynamic> listaDedia = jsonDecode(response);
      print(listaDedia);

      return listaDedia.map((dia) => ModeloDia.fromJson(dia)).toList();
    } catch (e) {
      return [];
    }
  }
}
