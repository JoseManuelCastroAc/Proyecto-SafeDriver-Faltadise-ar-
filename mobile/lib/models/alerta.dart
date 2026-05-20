class Alerta {
  final int id;
  final String tipo;
  final String nivel;
  final double? valorBpm;
  final double? valorVelocidad;
  final double? parpadeosPorMinuto;
  final DateTime timestamp;
  final int conductorId;
  final int vehiculoId;

  Alerta({
    required this.id,
    required this.tipo,
    required this.nivel,
    this.valorBpm,
    this.valorVelocidad,
    this.parpadeosPorMinuto,
    required this.timestamp,
    required this.conductorId,
    required this.vehiculoId,
  });

  factory Alerta.fromJson(Map<String, dynamic> json) {
    return Alerta(
      id: json['id'],
      tipo: json['tipo'],
      nivel: json['nivel'],
      valorBpm: json['valor_bpm']?.toDouble(),
      valorVelocidad: json['valor_velocidad']?.toDouble(),
      parpadeosPorMinuto: json['parpadeos_por_minuto']?.toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      conductorId: json['conductor_id'],
      vehiculoId: json['vehiculo_id'],
    );
  }

  bool get esCritica => nivel.toUpperCase() == 'CRITICO';
}