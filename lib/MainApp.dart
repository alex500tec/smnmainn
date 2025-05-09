import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:smn/pages/pagina_inicial.dart';
import 'package:smn/providers/provider_dias.dart';
import 'package:smn/providers/provider_lista_municipios.dart';
import 'package:smn/providers/provider_municipio.dart';
import 'package:smn/providers/provider_pronosticos.dart';
import 'package:smn/providers/provider_tema.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final ThemeData temaClaro = ThemeData(
    brightness: Brightness.light,
    primarySwatch: 
    scaffoldBackgroundColor: ,
    appBarTheme: AppBarTheme(
      backgroundColor: ,
      foregroundColor: ,
    ),
    textTheme: TextTheme(),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: )
        .copyWith(secondary: ),
  );

  final ThemeData temaOscuro = ThemeData();

  @override
  Widget build(BuildContext context) {
    final tema = Provider.of<ProviderTema>(context, listen: false);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderTema(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderMunicipio(),
        ),
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
        theme: temaClaro,
        darkTheme: temaOscuro,
        themeMode: tema.temaActual,
        debugShowCheckedModeBanner: false,
        home: PaginaInicial(),
      ),
    );
  }
}
