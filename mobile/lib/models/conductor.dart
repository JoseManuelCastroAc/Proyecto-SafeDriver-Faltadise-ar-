class Conductor {
  final int id;
  final String nombre;
  final String licencia;

  Conductor({
    required this.id,
    required this.nombre,
    required this.licencia,
  });

  factory Conductor.fromJson(Map<String, dynamic> json) {
    return Conductor(
      id: json['id'],
      nombre: json['nombre'],
      licencia: json['licencia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'licencia': licencia,
    };
  }

  Conductor copyWith({
    int? id,
    String? nombre,
    String? licencia,
  }) {
    return Conductor(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      licencia: licencia ?? this.licencia,
    );
  }
}