import 'package:flutter/material.dart';

import '../../models/vehiculo.dart';
import '../../services/api_service.dart';

class VehiclesContent extends StatefulWidget {
  const VehiclesContent({super.key});

  @override
  State<VehiclesContent> createState() => _VehiclesContentState();
}

class _VehiclesContentState extends State<VehiclesContent> {
  final ApiService _apiService = ApiService();

  late Future<List<Vehiculo>> _futureVehiculos;

  @override
  void initState() {
    super.initState();
    _loadVehiculos();
  }

  void _loadVehiculos() {
    setState(() {
      _futureVehiculos = _apiService.getVehiculos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vehiculo>>(
      future: _futureVehiculos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        }

        final vehiculos = snapshot.data ?? [];

        if (vehiculos.isEmpty) {
          return const Center(
            child: Text(
              'No hay vehículos registrados',
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: vehiculos.length,
          itemBuilder: (context, index) {
            final vehiculo = vehiculos[index];

            return Card(
              color: const Color(0xFF161A1F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              margin: const EdgeInsets.only(bottom: 14),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xFF2A2A2A),
                  child: Icon(Icons.directions_car, color: Colors.white),
                ),
                title: Text(
                  vehiculo.placa,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${vehiculo.modelo} • Conductor ID: ${vehiculo.conductorId}',
                  style: const TextStyle(color: Colors.white54),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.white38,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
