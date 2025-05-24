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
  scaffoldBackgroundColor: const Color(0xFFF0FDF4), // Gris muy claro verdoso
  primaryColor: const Color(0xFF10B981), // Verde menta
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF10B981),
    foregroundColor: Colors.white,
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
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF10B981),
    onPrimary: Colors.white,
    background: Color(0xFFF0FDF4),
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
);

final ThemeData temaOscuro = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF1E1B4B), // Morado muy oscuro
  primaryColor: const Color(0xFF8B5CF6), // Morado brillante
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF8B5CF6),
    foregroundColor: Colors.white,
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
    primary: Color(0xFF8B5CF6),
    onPrimary: Colors.white,
    background: Color(0xFF1E1B4B),
    onBackground: Colors.white,
    surface: Color(0xFF312E81), // Morado más claro para elementos de fondo
    onSurface: Colors.white,
  ),
);


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderTema()),
        ChangeNotifierProvider(create: (context) => ProviderMunicipio()),
        ChangeNotifierProvider(create: (context) => ProviderListaMunicipios()),
        ChangeNotifierProvider(create: (context) => ProviderPronosticos()),
        ChangeNotifierProvider(create: (context) => ProviderDias()),
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
