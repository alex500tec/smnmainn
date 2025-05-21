class ModeloMunicipio {
  String label;
  String idEdo;
  String idMpo;

  ModeloMunicipio({
    required this.label,
    required this.idEdo,
    required this.idMpo,
  });

  factory ModeloMunicipio.fromJson(Map<String, dynamic> json) {
    return ModeloMunicipio(
      label: json['label'] ?? "",
      idEdo: json['id_edo'] ?? "",
      idMpo: json['id_mpo'] ?? "",
    );
  }

  Map<String, dynamic> toJson() =>
      {'label': label, 'id_edo': idEdo, 'id_mpo': idMpo};
}
