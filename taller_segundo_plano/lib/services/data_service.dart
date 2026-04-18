import 'dart:math';

class DataService {
  Future<String> fetchUserData({bool forceError = false}) async {
    print('[DataService] Iniciando fetchUserData');
    final delay = Random().nextInt(1000) + 2000; // 2-3 segundos
    await Future.delayed(Duration(milliseconds: delay));
    if (forceError) {
      throw Exception('Error simulado en DataService');
    }
    print('[DataService] Datos obtenidos exitosamente');
    return 'Datos del usuario obtenidos correctamente';
  }
}