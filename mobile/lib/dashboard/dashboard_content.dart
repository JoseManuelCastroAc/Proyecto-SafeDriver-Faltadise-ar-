import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../models/conductor.dart';
import '../models/vehiculo.dart';
import '../models/alerta.dart';

import 'alertacritica_dashboard.dart';
import 'widgetSistemaActual.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  final ApiService _apiService = ApiService();

  late Future<_DashboardData> _futureDashboard;

  @override
  void initState() {
    super.initState();
    _futureDashboard = _loadDashboardData();
  }

  Future<_DashboardData> _loadDashboardData() async {
    final results = await Future.wait([
      _apiService.getConductores(),
      _apiService.getVehiculos(),
      _apiService.getAlertas(),
    ]);

    final conductores = results[0] as List<Conductor>;
    final vehiculos = results[1] as List<Vehiculo>;
    final alertas = results[2] as List<Alerta>;

    Alerta? criticalAlert;

    for (final alerta in alertas) {
      if (alerta.nivel.toUpperCase() == 'CRITICO') {
        criticalAlert = alerta;
        break;
      }
    }

    return _DashboardData(
      conductores: conductores,
      vehiculos: vehiculos,
      alertas: alertas,
      criticalAlert: criticalAlert,
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _futureDashboard = _loadDashboardData();
    });

    await _futureDashboard;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_DashboardData>(
      future: _futureDashboard,
      builder: (context, snapshot) {
        // Cargando
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent),
          );
        }

        // Error
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Error al conectar con el backend:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent, fontSize: 14),
              ),
            ),
          );
        }

        final data = snapshot.data!;

        // ======================================================
        // DATOS PARA AlertacriticaDashboard
        // ======================================================
        final hasCriticalAlert = data.criticalAlert != null;

        String driverName = 'No Active Alerts';
        String alertDescription = 'Todos los sistemas operando normalmente';

        if (hasCriticalAlert) {
          final alerta = data.criticalAlert!;

          driverName = _findDriverName(alerta.conductorId, data.conductores);

          final tipo = alerta.tipo;
          final nivel = alerta.nivel;
          final speed = alerta.valorVelocidad?.toStringAsFixed(1) ?? '--';
          final bpm = alerta.valorBpm?.toStringAsFixed(1) ?? '--';
          final blinks = alerta.parpadeosPorMinuto?.toStringAsFixed(1) ?? '--';

          alertDescription =
              '$tipo - $nivel | Speed: $speed km/h | BPM: $bpm | Blinks: $blinks';
        }

        return RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // ==================================================
                // ALERTA CRÍTICA
                // (usa exactamente los parámetros del nuevo widget)
                // ==================================================
                AlertacriticaDashboard(
                  driverName: driverName,
                  alertDescription: alertDescription,
                  hasCriticalAlert: hasCriticalAlert,
                ),

                const SizedBox(height: 20),

                // ==================================================
                // SISTEMA ACTUAL
                // ==================================================
                WidgetSistemaActual(
                  driversCount: data.conductores.length,
                  vehiclesCount: data.vehiculos.length,
                  alertsCount: data.alertas.length,
                  systemStatus: hasCriticalAlert ? 'CRITICAL' : 'NORMAL',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _findDriverName(int driverId, List<Conductor> conductores) {
    for (final conductor in conductores) {
      if (conductor.id == driverId) {
        return conductor.nombre;
      }
    }

    return 'Driver #$driverId';
  }
}

class _DashboardData {
  final List<Conductor> conductores;
  final List<Vehiculo> vehiculos;
  final List<Alerta> alertas;
  final Alerta? criticalAlert;

  _DashboardData({
    required this.conductores,
    required this.vehiculos,
    required this.alertas,
    required this.criticalAlert,
  });
}
