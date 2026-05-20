import 'package:flutter/material.dart';

class MonitoreoUnidadWidget extends StatelessWidget {
  // 1. Definimos los parámetros dinámicos que recibirá cada fila
  final String nombre;
  final String placa;
  final int bpm;
  final int velocidad;
  final int parpadeos;
  final String estado; // 'CRÍTICO', 'ALERTA', 'NORMAL'

  const MonitoreoUnidadWidget({
    super.key,
    required this.nombre,
    required this.placa,
    required this.bpm,
    required this.velocidad,
    required this.parpadeos,
    required this.estado,
  });

  // 2. Función auxiliar interna para determinar el color según el estado del backend
  Color _obtenerColorEstado() {
    switch (estado.toUpperCase()) {
      case 'CRÍTICO':
        return Colors.redAccent;
      case 'ALERTA':
        return Colors.amber;
      case 'NORMAL':
        return Colors.greenAccent;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorEstado = _obtenerColorEstado();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 6,
      ), // Separación entre filas de conductores
      padding: const EdgeInsets.all(
        12,
      ), // Reemplaza el height fijo para evitar desbordamiento
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        // Pintamos el borde con el color dinámico del estado
        border: Border.all(color: colorEstado.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: colorEstado.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // A. Icono de perfil o conductor con su indicador circular de estado
          Stack(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFF2A2A2A),
                radius: 20,
                child: Icon(Icons.person, color: Colors.white70, size: 24),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: colorEstado,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF1E1E1E),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // B. Bloque de Identificación (Nombre e ID/Placa)
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  nombre,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  placa,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),

          // C. Métrica: BPM
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "BPM",
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                Text(
                  "$bpm",
                  style: TextStyle(
                    color: colorEstado,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // D. Métrica: Velocidad
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Velocidad",
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                Text(
                  "$velocidad km/h",
                  style: TextStyle(
                    color: colorEstado,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // E. Métrica: Parpadeos
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Parpadeos",
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                Text(
                  "$parpadeos/min",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),

          // F. Badge de Estado Texto + Flecha de Navegación
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: colorEstado.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              estado,
              style: TextStyle(
                color: colorEstado,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
}
