import 'package:flutter/material.dart';

class WidgetSistemaActual extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String titulo;
  final String valor;
  final String mensajeBajo;
  final Color colorMensajeBajo;

  const WidgetSistemaActual({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.titulo,
    required this.valor,
    required this.mensajeBajo,
    required this.colorMensajeBajo,
  });

  @override
  Widget build(BuildContext context) {
    // Determinamos si es la tarjeta de Alertas Críticas para agregar el icono extra abajo
    final esTarjetaAlerta = titulo.toLowerCase().contains('alerta');

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6), // Espaciado simétrico entre bloques
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E), // El fondo gris oscuro de tu mockup
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fila Superior: Icono Principal + Título
            Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    titulo,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Valor Central (Número o Estado)
            Text(
              valor,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),

            // Fila Inferior: Mensaje con color variable (+ Icono de advertencia si aplica)
            Row(
              children: [
                if (esTarjetaAlerta) ...[
                  Icon(
                    Icons.warning_amber_rounded,
                    color: colorMensajeBajo,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                ],
                Expanded(
                  child: Text(
                    mensajeBajo,
                    style: TextStyle(color: colorMensajeBajo, fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
