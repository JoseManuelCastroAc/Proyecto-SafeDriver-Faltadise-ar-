import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/login_response.dart';
import 'api_constant.dart';
import 'storage_service.dart';

class AuthService {
  final StorageService _storageService = StorageService();

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConstant.baseUrl}/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'username': username, 'password': password},
    );

    if (response.statusCode != 200) {
      return false;
    }

    final jsonData = jsonDecode(response.body);
    final loginResponse = LoginResponse.fromJson(jsonData);

    await _storageService.saveToken(loginResponse.accessToken);

    return true;
  }

  Future<void> logout() async {
    await _storageService.clearToken();
  }

  Future<String?> getToken() async {
    return _storageService.getToken();
  }

  Future<bool> isLoggedIn() async {
    return _storageService.hasToken();
  }
}
