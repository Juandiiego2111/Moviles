import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class EvidenceScreen extends StatefulWidget {
  const EvidenceScreen({super.key});

  @override
  State<EvidenceScreen> createState() => _EvidenceScreenState();
}

class _EvidenceScreenState extends State<EvidenceScreen> {
  final AuthService _authService = AuthService();
  Map<String, String?> localData = {};

  @override
  void initState() {
    super.initState();
    _loadLocalData();
  }

  Future<void> _loadLocalData() async {
    final data = await _authService.getLocalData();
    setState(() {
      localData = data;
    });
  }

  Future<void> _logout() async {
    await _authService.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? accessToken = localData['access_token'];
    final bool hasToken = accessToken != null && accessToken.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos almacenados localmente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SharedPreferences (No sensible)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Nombre: ${localData['user_name'] ?? ''}'),
            Text('Email: ${localData['user_email'] ?? ''}'),
            const SizedBox(height: 20),
            const Text(
              'FlutterSecureStorage (Sensible)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              hasToken ? 'Token: PRESENTE ✓' : 'Token: SIN TOKEN',
              style: TextStyle(
                color: hasToken ? Colors.green : Colors.red,
              ),
            ),
            if (hasToken)
              Text('Token: ${accessToken.substring(0, accessToken.length > 20 ? 20 : accessToken.length)}...'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}