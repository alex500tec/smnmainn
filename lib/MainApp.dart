import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:smn/pages/pagina_inicial.dart';
import 'package:smn/providers/provider_dias.dart';
import 'package:smn/providers/provider_lista_municipios.dart';
import 'package:smn/providers/provider_municipio.dart';
import 'package:smn/providers/provider_pronosticos.dart';
import 'package:smn/providers/provider_tema.dart';
import 'package:smn/pages/pagina_favoritos.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData temaClaro = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.amber,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        titleLarge: TextStyle(color: Colors.black),
        labelLarge: TextStyle(color: Colors.black),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      colorScheme: ColorScheme.light(
        primary: Colors.amber,
        onPrimary: Colors.black,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
    );
    final ThemeData temaOscuro = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF121212), // Fondo oscuro
      primaryColor: Colors.amber, // Color primario ámbar

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.amber, // AppBar ámbar
        foregroundColor: Colors.black, // Texto e íconos en negro sobre ámbar
        elevation: 0,
      ),

      iconTheme: const IconThemeData(
        color: Colors.white,
      ),

      textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),

      colorScheme: const ColorScheme.dark(
        primary: Colors.amber,
        onPrimary: Colors.black,
        background: Color(0xFF121212),
        onBackground: Colors.white,
        surface: Color(0xFF1E1E1E),
        onSurface: Colors.white,
      ),
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
        return Consumer<ProviderTema>(builder: (context, tema, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: temaClaro,
            darkTheme: temaOscuro,
            themeMode: tema.temaActual,
            debugShowCheckedModeBanner: false,
            home: PaginaInicial(),
            routes: {
  '/favoritos': (context) => PaginaFavoritos(),
},
          );
        });
      }),
    );
  }
}
