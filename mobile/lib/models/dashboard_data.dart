import 'alerta.dart';
import 'conductor.dart';
import 'vehiculo.dart';

class DashboardData {
  final List<Conductor> conductores;
  final List<Vehiculo> vehiculos;
  final List<Alerta> alertas;

  DashboardData({
    required this.conductores,
    required this.vehiculos,
    required this.alertas,
  });

  Alerta? get alertaCritica {
    try {
      return alertas.firstWhere(
        (alerta) => alerta.nivel.toUpperCase() == 'CRITICO',
      );
    } catch (_) {
      return null;
    }
  }

  int get totalConductores => conductores.length;
  int get totalVehiculos => vehiculos.length;
  int get totalAlertas => alertas.length;
  int get totalAlertasCriticas =>
      alertas.where((a) => a.nivel.toUpperCase() == 'CRITICO').length;
}
