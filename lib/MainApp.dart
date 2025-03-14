import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:smn/pages/pagina_inicial.dart';
import 'package:smn/providers/provider_dias.dart';
import 'package:smn/providers/provider_lista_municipios.dart';
import 'package:smn/providers/provider_pronosticos.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderListaMunicipios(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderPronosticos(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderDias(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PaginaInicial(),
      ),
    );
  }
}
