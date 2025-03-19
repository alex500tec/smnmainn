/*
    "nes": "San Luis Potosí",
    "nmun": "Ciudad Valles",
    "tmax": "18.8",
    "tmin": "10.2",
    "desciel": "Cielo nublado",
    "probprec": "0",
    "prec": "4.6",
    "velvien": "3.9",
    "dirvienc": "Noroeste",
    "raf": "10.4"
 */

class ModeloPronostico {
  String nes;
  String nmun;
  String tmax;
  String tmin;
  String desciel;
  String probprec;
  String prec;
  String velvien;
  String dirvienc;
  String raf;

  String? fecha;

  ModeloPronostico({
    required this.nes,
    required this.nmun,
    required this.tmax,
    required this.tmin,
    required this.desciel,
    required this.probprec,
    required this.prec,
    required this.velvien,
    required this.dirvienc,
    required this.raf,
    this.fecha,
  });

  factory ModeloPronostico.fromJson(Map<String, dynamic> json) {
    //if (json['nes'] == null) {
    //  nes = '24';
    //}

    //nes = json['nes'] == null ? '24' : json['nes'];

    return ModeloPronostico(
      fecha: json['fecha'] ?? "",
      nes: json['nes'] ?? '24',
      nmun: json['nmun'] ?? '13',
      tmax: json['tmax'] ?? '',
      tmin: json['tmin'] ?? '',
      desciel: json['desciel'] ?? '',
      probprec: json['probprec'] ?? '',
      prec: json['prec'] ?? '',
      velvien: json['velvien'] ?? '',
      dirvienc: json['dirvienc'] ?? '',
      raf: json['raf'] ?? '',
    );
  }
}
