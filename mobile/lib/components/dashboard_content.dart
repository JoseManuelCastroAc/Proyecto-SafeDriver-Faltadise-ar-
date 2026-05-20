import 'package:flutter/material.dart';
import 'package:dbp_project/components/alertacritica_dashboard.dart';
import 'package:dbp_project/components/widgetSistemaActual.dart';
import 'package:dbp_project/components/monitoreo_panel.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AlertacriticaDashboard(),
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, top: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    WidgetSistemaActual(
                      icon: Icons.people_alt_outlined,
                      iconColor: Colors.greenAccent,
                      titulo: "Conductores activos",
                      valor: "12",
                      mensajeBajo: "+2 hoy ↗",
                      colorMensajeBajo: Colors.greenAccent,
                    ),
                    WidgetSistemaActual(
                      icon: Icons.local_shipping_outlined,
                      iconColor: Colors.blueAccent,
                      titulo: "Vehículos conectados",
                      valor: "8",
                      mensajeBajo: "En línea ●",
                      colorMensajeBajo: Colors.greenAccent,
                    ),
                  ],
                ),
                Row(
                  children: [
                    WidgetSistemaActual(
                      icon: Icons.warning_amber_rounded,
                      iconColor: Colors.redAccent,
                      titulo: "Alertas críticas",
                      valor: "3",
                      mensajeBajo: "Requieren atención",
                      colorMensajeBajo: Colors.redAccent,
                    ),
                    WidgetSistemaActual(
                      icon: Icons.shield_outlined,
                      iconColor: Colors.purpleAccent,
                      titulo: "Estado del sistema",
                      valor: "Óptimo",
                      mensajeBajo: "Todos los sistemas OK",
                      colorMensajeBajo: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
          MonitoreoPanel(),
        ],
      ),
    );
  }
}
