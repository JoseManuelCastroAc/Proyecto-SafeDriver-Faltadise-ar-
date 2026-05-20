import 'package:flutter/material.dart';
// Asegúrate de que esta ruta coincida con el nombre exacto de tu archivo del componente individual
import 'package:dbp_project/components/monitoreo_unidad_widget.dart';

class MonitoreoPanel extends StatefulWidget {
  const MonitoreoPanel({super.key});

  @override
  State<MonitoreoPanel> createState() => _MonitoreoPanelState();
}

class _MonitoreoPanelState extends State<MonitoreoPanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Monitoreo en tiempo real",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            const MonitoreoUnidadWidget(
              nombre: "Carlos Ruiz",
              placa: "ABC-123",
              bpm: 92,
              velocidad: 92,
              parpadeos: 28,
              estado: "CRÍTICO",
            ),
            const MonitoreoUnidadWidget(
              nombre: "Juan Pérez",
              placa: "XYZ-789",
              bpm: 78,
              velocidad: 65,
              parpadeos: 18,
              estado: "ALERTA",
            ),
            const MonitoreoUnidadWidget(
              nombre: "Luis Morales",
              placa: "LMN-456",
              bpm: 72,
              velocidad: 58,
              parpadeos: 12,
              estado: "NORMAL",
            ),
          ],
        ),
      ),
    );
  }
}
