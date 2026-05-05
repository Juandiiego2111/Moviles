import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  AuthService._privateConstructor();
  static final AuthService _instance = AuthService._privateConstructor();
  factory AuthService() => _instance;

  static const _storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password,
    });
    print('Llamando endpoint: https://parking.visiontic.com.co/api/users');
    print('Body: $body');
    try {
      final response = await http.post(
        Uri.parse('https://parking.visiontic.com.co/api/users'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      final data = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) && data['success'] == true) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'Error en el registro');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error de conexión: $e');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final body = jsonEncode({
      'email': email,
      'password': password,
    });
    print('Llamando endpoint: https://parking.visiontic.com.co/api/login');
    print('Body: $body');
    try {
      final response = await http.post(
        Uri.parse('https://parking.visiontic.com.co/api/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      final data = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) && data['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        
        await prefs.setString('user_name', data['user']['name']);
        await prefs.setString('user_email', data['user']['email']);
        
        await _storage.write(key: 'access_token', value: data['token']);
        
        return data;
      } else {
        throw Exception(data['message'] ?? 'Error en el login');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error de conexión: $e');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await _storage.delete(key: 'access_token');
  }

  Future<Map<String, String?>> getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    
    return {
      'user_name': prefs.getString('user_name'),
      'user_email': prefs.getString('user_email'),
      'access_token': await _storage.read(key: 'access_token'),
    };
  }
}