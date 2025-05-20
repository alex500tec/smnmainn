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

  @override
  Widget build(BuildContext context) {
    final ThemeData temaClaro = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Color(0xFFE3F2FD),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.lightBlue[700],
        foregroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black54),
        titleLarge: TextStyle(color: Colors.black),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(secondary: Colors.orangeAccent),
    );

    final ThemeData temaOscuro = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Color(0xFFE3F2FD),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.lightBlue[700],
        foregroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black54),
        titleLarge: TextStyle(color: Colors.black),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(secondary: Colors.orangeAccent),
    );

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
      child: Builder(builder: (context) {
        //final tema = Provider.of<ProviderTema>(context, listen: false);

        return Consumer<ProviderTema>(builder: (context, tema, child) {
          return MaterialApp(
            theme: temaClaro,
            darkTheme: temaOscuro,
            themeMode: tema.temaActual,
            debugShowCheckedModeBanner: false,
            home: PaginaInicial(),
          );
        });
      }),
    );
  }
}
