import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Utils {
  static Icon IconoDireccionViento(String dirvien, [double tamano = 10.0]) {
    IconData temp;
    switch (dirvien) {
      case 'Norte':
        temp = WeatherIcons.direction_up;
        break;
      case 'Sur':
        temp = WeatherIcons.direction_down;
        break;
      case 'Oeste':
        temp = WeatherIcons.direction_right;
        break;
      case 'Este':
        temp = WeatherIcons.direction_left;
        break;

      default:
        temp = WeatherIcons.day_sunny;
        break;
    }
    return Icon(
      temp,
      color: Colors.amber,
      size: tamano,
    );
  }

  static Icon Icono(String desciel, [double tamano = 10.0]) {
    IconData temp;
    switch (desciel) {
      case 'Cielo nublado':
        temp = WeatherIcons.cloudy;
        break;
      case 'Medio nublado':
        temp = WeatherIcons.cloud;
        break;
      case 'Despejado':
        temp = WeatherIcons.day_sunny;
        break;
      case 'Poco nuboso':
        temp = WeatherIcons.day_sunny_overcast;
        break;
      default:
        temp = WeatherIcons.day_sunny;
        break;
    }
    return Icon(
      temp,
      color: Colors.amber,
      size: tamano,
    );
  }

  static redondearNumero(String valor) {
    if (double.tryParse(valor) != null) {
      return double.parse(valor).round().toString();
    }
    return valor;
  }

  static convertirDecimalenRango(String valor) {
    if (double.tryParse(valor) != null) {
      int valorRedondeado = (double.parse(valor).round() / 5).round() * 5;
      int min = valorRedondeado;
      int max = valorRedondeado + 5;

      return "$min a $max kms/h";
    }
    return valor;
  }
}
