class ApiConstant {
  ApiConstant._();

  // Laptop conectada al Wi-Fi.
  // Dirección IPv4 detectada:
  // 192.168.18.58
  static const String baseUrl = 'http://192.168.18.58:8000';

  static const String token = '$baseUrl/token';
  static const String conductores = '$baseUrl/conductores/';
  static const String vehiculos = '$baseUrl/vehiculos/';
  static const String alertas = '$baseUrl/alertas/';
}
