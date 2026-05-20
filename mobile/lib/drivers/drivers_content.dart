import 'package:flutter/material.dart';

import '../../models/conductor.dart';
import '../../services/api_service.dart';

class DriversContent extends StatefulWidget {
  const DriversContent({super.key});

  @override
  State<DriversContent> createState() => _DriversContentState();
}

class _DriversContentState extends State<DriversContent> {
  final ApiService _apiService = ApiService();

  late Future<List<Conductor>> _futureConductores;

  @override
  void initState() {
    super.initState();
    _loadConductores();
  }

  void _loadConductores() {
    setState(() {
      _futureConductores = _apiService.getConductores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Conductor>>(
      future: _futureConductores,
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

        final conductores = snapshot.data ?? [];

        if (conductores.isEmpty) {
          return const Center(
            child: Text(
              'No hay conductores registrados',
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: conductores.length,
          itemBuilder: (context, index) {
            final conductor = conductores[index];

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
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(
                  conductor.nombre,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Licencia: ${conductor.licencia}',
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
