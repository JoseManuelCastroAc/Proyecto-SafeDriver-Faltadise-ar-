import 'package:flutter/material.dart';

import '../../models/alerta.dart';
import '../../services/api_service.dart';

class AlertsContent extends StatefulWidget {
  const AlertsContent({super.key});

  @override
  State<AlertsContent> createState() => _AlertsContentState();
}

class _AlertsContentState extends State<AlertsContent> {
  final ApiService _apiService = ApiService();

  late Future<List<Alerta>> _futureAlertas;

  @override
  void initState() {
    super.initState();
    _futureAlertas = _apiService.getAlertas();
  }

  Color _getLevelColor(String nivel) {
    switch (nivel.toUpperCase()) {
      case 'CRITICO':
        return Colors.redAccent;
      case 'ALERTA':
        return Colors.orangeAccent;
      default:
        return Colors.greenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Alerta>>(
      future: _futureAlertas,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        }

        final alertas = snapshot.data ?? [];

        if (alertas.isEmpty) {
          return const Center(
            child: Text(
              'No hay alertas registradas',
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: alertas.length,
          itemBuilder: (context, index) {
            final alerta = alertas[index];
            final color = _getLevelColor(alerta.nivel);

            return Card(
              color: const Color(0xFF1A1F24),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(Icons.warning_amber_rounded, color: color),
                title: Text(
                  alerta.tipo,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Nivel: ${alerta.nivel}',
                  style: const TextStyle(color: Colors.white54),
                ),
                trailing: Text(
                  '${alerta.conductorId}',
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
