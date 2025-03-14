import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smn/custom_widgets/dia_principal.dart';

import 'package:smn/models/modelo_municipio.dart';
import 'package:smn/models/modelo_pronostico.dart';
import 'package:smn/providers/provider_lista_municipios.dart';
import 'package:smn/providers/provider_pronosticos.dart';
import 'buscar_municipio.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  String _status = "Checando GPS";
  bool _isGPSEnabled = false;
  String _hoy = DateFormat("dd MMMM", "es_ES").format(DateTime.now());
  String _ciudad = "Cargando ciudad...";

  @override
  void initState() {
    super.initState();
    _getLocation();

    Future.microtask(() {
      Provider.of<ProviderPronosticos>(context, listen: false)
          .cargaPronosticos();
    });
  }

  Future<void> _getLocation() async {
    _isGPSEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_isGPSEnabled) {
      setState(() {
        _status = "El servicio de ubicación está desactivado";
      });
      return;
    }

    LocationPermission permisoUbicacion = await Geolocator.checkPermission();

    if (permisoUbicacion == LocationPermission.denied) {
      permisoUbicacion = await Geolocator.requestPermission();

      if (permisoUbicacion == LocationPermission.denied) {
        setState(() {
          _status = "Permiso denegado";
        });
      } else if (permisoUbicacion == LocationPermission.deniedForever) {
        setState(() {
          _status = "Permiso denegado por siempre";
        });
      } else {
        _cargaLaCiudad();
      }
    } else {
      _cargaLaCiudad();
    }
  }

  Future<void> _cargaLaCiudad() async {
    Position posicion = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> listaDeUbicaciones =
        await placemarkFromCoordinates(posicion.latitude, posicion.longitude);

    if (listaDeUbicaciones.isNotEmpty) {
      ModeloMunicipio ciudad = await ProviderListaMunicipios()
          .obtenerMunicipioPorNombre(
              listaDeUbicaciones.first.locality.toString());
      setState(() {
        _ciudad = ciudad.label;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Pronóstico del Tiempo por Municipios',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BuscarMunicipio(),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.grey,
              )),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  Text(
                    'Buscar municipio',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            _ciudad,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text(_hoy),
          Consumer<ProviderPronosticos>(
              builder: (context, proveedor_de_dias, child) {
            if (proveedor_de_dias.estaCargando) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (proveedor_de_dias.pronosticos.isEmpty) {
              return Center(
                child: Text("No hay pronósticos diponibles"),
              );
            }

            ModeloPronostico diaPrincipal = proveedor_de_dias.pronosticos[0];

            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DiaPrincipal(dia: diaPrincipal),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
