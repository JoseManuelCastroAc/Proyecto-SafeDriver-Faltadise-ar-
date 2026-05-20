class Vehiculo {
  final int id;
  final String placa;
  final String modelo;
  final int conductorId;

  Vehiculo({
    required this.id,
    required this.placa,
    required this.modelo,
    required this.conductorId,
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) {
    return Vehiculo(
      id: json['id'],
      placa: json['placa'],
      modelo: json['modelo'],
      conductorId: json['conductor_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placa': placa,
      'modelo': modelo,
      'conductor_id': conductorId,
    };
  }

  Vehiculo copyWith({
    int? id,
    String? placa,
    String? modelo,
    int? conductorId,
  }) {
    return Vehiculo(
      id: id ?? this.id,
      placa: placa ?? this.placa,
      modelo: modelo ?? this.modelo,
      conductorId: conductorId ?? this.conductorId,
    );
  }
}