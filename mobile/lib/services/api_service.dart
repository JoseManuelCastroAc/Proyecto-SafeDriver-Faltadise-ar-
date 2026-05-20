import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/alerta.dart';
import '../models/conductor.dart';
import '../models/dashboard_data.dart';
import '../models/vehiculo.dart';
import 'api_constant.dart';
import 'auth_service.dart';

class ApiService {
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getHeaders({bool auth = false}) async {
    final headers = <String, String>{'Content-Type': 'application/json'};

    if (auth) {
      final token = await _authService.getToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  // ==========================
  // CONDUCTORES
  // ==========================

  Future<List<Conductor>> getConductores() async {
    final response = await http.get(
      Uri.parse('${ApiConstant.baseUrl}/conductores/'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al cargar conductores');
    }

    final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    return data.map((json) => Conductor.fromJson(json)).toList();
  }

  Future<Conductor> createConductor({
    required String nombre,
    required String licencia,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConstant.baseUrl}/conductores/'),
      headers: await _getHeaders(auth: true),
      body: jsonEncode({'nombre': nombre, 'licencia': licencia}),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear conductor');
    }

    return Conductor.fromJson(jsonDecode(response.body));
  }

  Future<Conductor> updateConductor({
    required int id,
    required String nombre,
    required String licencia,
  }) async {
    final response = await http.put(
      Uri.parse('${ApiConstant.baseUrl}/conductores/$id'),
      headers: await _getHeaders(auth: true),
      body: jsonEncode({'nombre': nombre, 'licencia': licencia}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar conductor');
    }

    return Conductor.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteConductor(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConstant.baseUrl}/conductores/$id'),
      headers: await _getHeaders(auth: true),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar conductor');
    }
  }

  // ==========================
  // VEHÍCULOS
  // ==========================

  Future<List<Vehiculo>> getVehiculos() async {
    final response = await http.get(
      Uri.parse('${ApiConstant.baseUrl}/vehiculos/'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al cargar vehículos');
    }

    final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    return data.map((json) => Vehiculo.fromJson(json)).toList();
  }

  Future<Vehiculo> createVehiculo({
    required String placa,
    required String modelo,
    required int conductorId,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConstant.baseUrl}/vehiculos/'),
      headers: await _getHeaders(auth: true),
      body: jsonEncode({
        'placa': placa,
        'modelo': modelo,
        'conductor_id': conductorId,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear vehículo');
    }

    return Vehiculo.fromJson(jsonDecode(response.body));
  }

  Future<Vehiculo> updateVehiculo({
    required int id,
    required String placa,
    required String modelo,
    required int conductorId,
  }) async {
    final response = await http.put(
      Uri.parse('${ApiConstant.baseUrl}/vehiculos/$id'),
      headers: await _getHeaders(auth: true),
      body: jsonEncode({
        'placa': placa,
        'modelo': modelo,
        'conductor_id': conductorId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar vehículo');
    }

    return Vehiculo.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteVehiculo(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConstant.baseUrl}/vehiculos/$id'),
      headers: await _getHeaders(auth: true),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar vehículo');
    }
  }

  // ==========================
  // ALERTAS
  // ==========================

  Future<List<Alerta>> getAlertas() async {
    final response = await http.get(
      Uri.parse('${ApiConstant.baseUrl}/alertas/'),
      headers: await _getHeaders(auth: true),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al cargar alertas');
    }

    final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    return data.map((json) => Alerta.fromJson(json)).toList();
  }

  // ==========================
  // DASHBOARD
  // ==========================

  Future<DashboardData> getDashboardData() async {
    final results = await Future.wait([
      getConductores(),
      getVehiculos(),
      getAlertas(),
    ]);

    return DashboardData(
      conductores: results[0] as List<Conductor>,
      vehiculos: results[1] as List<Vehiculo>,
      alertas: results[2] as List<Alerta>,
    );
  }
}
