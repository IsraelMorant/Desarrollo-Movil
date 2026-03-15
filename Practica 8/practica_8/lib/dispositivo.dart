class Dispositivo {
  int? id;
  String cliente;
  String tipo;
  String marca;
  String modelo;
  String serie;
  String falla;
  String fecha;

  Dispositivo({
    this.id,
    required this.cliente,
    required this.tipo,
    required this.marca,
    required this.modelo,
    required this.serie,
    required this.falla,
    required this.fecha,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cliente': cliente,
      'tipo': tipo,
      'marca': marca,
      'modelo': modelo,
      'serie': serie,
      'falla': falla,
      'fecha': fecha,
    };
  }
}