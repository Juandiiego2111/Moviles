import 'package:flutter/material.dart';
import '../services/data_service.dart';
// Redesigned future screen UI
class FutureScreen extends StatefulWidget {
  const FutureScreen({super.key});

  @override
  State<FutureScreen> createState() => _FutureScreenState();
}

class _FutureScreenState extends State<FutureScreen> with TickerProviderStateMixin {
  final DataService _dataService = DataService();
  String _result = '';
  bool _isLoading = false;
  bool _hasError = false;
  List<String> _logs = [];

  void _addLog(String message) {
    setState(() {
      _logs.add('[${DateTime.now().toString().split(' ').last}] $message');
    });
  }

  Future<void> _fetchData({bool forceError = false}) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _result = '';
      _logs.clear();
    });

    _addLog('[Future] ANTES - Iniciando llamada asíncrona');
    print('[Future] ANTES');
    try {
      final data = await _dataService.fetchUserData(forceError: forceError);
      _addLog('[Future] DESPUÉS - Éxito: $data');
      print('[Future] DESPUÉS - Éxito');
      setState(() {
        _result = data;
        _isLoading = false;
      });
    } catch (e) {
      _addLog('[Future] DESPUÉS - Error: $e');
      print('[Future] DESPUÉS - Error');
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  Widget _buildStatusWidget() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 90,
            height: 90,
            child: CircularProgressIndicator(
              color: Color(0xFF00E5A0),
              strokeWidth: 6,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Consultando servidor...',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      );
    } else if (_hasError) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: const Icon(
                  Icons.error,
                  size: 80,
                  color: Color(0xFFFF4D6A),
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          const Text(
            'Error al cargar datos',
            style: TextStyle(fontSize: 18, color: Color(0xFFFF4D6A)),
          ),
        ],
      );
    } else if (_result.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Color(0xFF00E5A0),
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF182530),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF23314A)),
            ),
            child: Text(
              _result,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: 1.2),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: const Icon(
                  Icons.cloud,
                  size: 80,
                  color: Color(0xFF4D9EFF),
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          const Text(
            'Listo para consultar',
            style: TextStyle(fontSize: 16, color: Color(0xFF7A9BB5)),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future - Future & Async'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Card central con estado
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF2A2A2A), width: 1),
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildStatusWidget(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Botones
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : () => _fetchData(forceError: false),
                    icon: const Icon(Icons.download),
                    label: const Text('Cargar Datos'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isLoading ? null : () => _fetchData(forceError: true),
                    icon: const Icon(Icons.error),
                    label: const Text('Forzar Error'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Terminal visual
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF2A2A2A)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Terminal',
                        style: TextStyle(
                          color: Color(0xFF00E5A0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Text(
                            _logs.join('\n'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}