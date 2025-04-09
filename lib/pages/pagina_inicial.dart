import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smn/custom_widgets/acordeon_dias.dart';
import 'package:smn/custom_widgets/dia_principal.dart';
import 'package:smn/custom_widgets/widget_dia.dart';

import 'package:smn/models/modelo_municipio.dart';
import 'package:smn/models/modelo_pronostico.dart';
import 'package:smn/providers/provider_dias.dart';
import 'package:smn/providers/provider_lista_municipios.dart';
import 'package:smn/providers/provider_pronosticos.dart';
import 'buscar_municipio.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  bool _isGPSEnabled = false;
  String _hoy = DateFormat("dd MMMM", "es_ES").format(DateTime.now());
  String _ciudad = "Cargando ciudad...";
  int _diaSeleccionado = 0;
  String _fechaSeleccionada = "";
  String _fechaPorHoras = "";

  @override
  void initState() {
    super.initState();
    _fechaPorHoras = "para hoy ";
    _getLocation();

    //Mirotask se jecuta inmediatemente al llamar la UI, aunque no haya widgets en pantalla
    //addPostFrameCallback se ejecuta hasta que se pintó todos los widgets

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pronosticoProvider =
          Provider.of<ProviderPronosticos>(context, listen: false);
      final diasProvider = 
          Provider.of<ProviderDias>(context, listen: false);

      pronosticoProvider.cargaPronosticos();
      diasProvider.cargaDia(_diaSeleccionado);
    });
  }

  Future<void> _getLocation() async {
    _isGPSEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_isGPSEnabled) {
      return;
    }

    LocationPermission permisoUbicacion = await Geolocator.checkPermission();

    if (permisoUbicacion == LocationPermission.denied) {
      permisoUbicacion = await Geolocator.requestPermission();

      if (permisoUbicacion == LocationPermission.denied) {

      } else if (permisoUbicacion == LocationPermission.deniedForever) {

      } else {
        _cargaLaCiudad();
      }
    } else {
      _cargaLaCiudad();
    }
  }

  Future pidePermisoGPS() async{
    LocationPermission permisoUbicacion = await Geolocator.checkPermission();

 permisoUbicacion = await Geolocator.requestPermission();

      if (permisoUbicacion == LocationPermission.denied || permisoUbicacion == LocationPermission.deniedForever) {
      return;
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

  void _alSeleccionarDia(int index, String fecha) {
    if (_diaSeleccionado != index) {
      Provider.of<ProviderDias>(context, listen: false).cargaDia(index);
      
      if(index==0){
        _fechaPorHoras = "para hoy";
      }else{
        DateFormat formatoDeEntrada = DateFormat('d/MM');
        DateTime fechaParseada = formatoDeEntrada.parse(fecha);
        fechaParseada = DateTime(
          DateTime.now().year,fechaParseada.month, fechaParseada.day
        );
        String nombreDia = DateFormat('EEEE','es_ES').format(fechaParseada);

        _fechaPorHoras = "del $nombreDia";
      }
      
      setState(() {
        _fechaSeleccionada = fecha;
        _diaSeleccionado = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool esTelefono = MediaQuery.of(context).size.width <= 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Pronóstico del Tiempo por Municipios',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: 
/*
      !_isGPSEnabled?
      Center(
        child: 
        ElevatedButton(onPressed: pidePermisoGPS,
             child: Text('Seleccione un municipio')),
      )
      :      */
      Column(
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
                    ExpansionTile(
                      title: Text(""),
                      trailing: Icon(
                        Icons.info,
                        size: 40,
                        color: Colors.amber,
                      ),
                      children: [
                        Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Color(0xfffcf8e3),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Temp max: ',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Puede variar de 1° a 3°C")
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Temp min: ',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Puede variar +/- 1°C")
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    LayoutBuilder(builder: (context, condicionantes) {
                      return Flex(
                        direction: esTelefono ? Axis.vertical : Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: esTelefono
                                ? condicionantes.maxWidth
                                : condicionantes.maxWidth / 4,
                            child: WidgetDia(
                              pronostico: proveedor_de_dias.pronosticos[index],
                              index: index,
                            ),
                          );
                        }),
                      );
                    }),
                    SizedBox(height: 20.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: ChoiceChip(
                              label: Text(
                                proveedor_de_dias.pronosticos[index].fecha ??
                                    '',
                              ),
                              selected: index == _diaSeleccionado,
                              selectedColor: Colors.green,
                              labelStyle: TextStyle(
                                color: index == _diaSeleccionado
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              onSelected: (seleccionado) {
                                if (!proveedor_de_dias.estaCargando) {
                                  _alSeleccionarDia(
                                      index,
                                      proveedor_de_dias
                                              .pronosticos[index].fecha ??
                                          '');
                                }
                              },
                              showCheckmark: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
  const Text('Pronóstico por horas '),
  Text(_fechaPorHoras),
  Text(_fechaSeleccionada),
],
                    ),
                    SizedBox(
                      height: 8,
                    ),                    
                    AcordeonDias(
                      fecha: _fechaSeleccionada,
                      index: _diaSeleccionado,
                    )
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
