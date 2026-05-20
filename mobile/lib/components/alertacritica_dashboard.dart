import 'package:flutter/material.dart';

class AlertacriticaDashboard extends StatefulWidget {
  const AlertacriticaDashboard({super.key});

  @override
  State<AlertacriticaDashboard> createState() => _AlertacriticaDashboardState();
}

class _AlertacriticaDashboardState extends State<AlertacriticaDashboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Container(
        width: double.infinity, // Ocupa todo el ancho disponible del padding
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E), // Fondo gris oscuro industrial
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.redAccent.withOpacity(
              0.8,
            ), // Borde rojo de alerta crítica
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icono de Alerta de Emergencia
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.redAccent,
                size: 30,
              ),
            ),
            const SizedBox(width: 15),

            // Textos informativos de la alerta
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "ALERTA CRÍTICA",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Conductor: Juan Pérez",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Estado: Fatiga Detectada (Frec. Parpadeo alta)",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
