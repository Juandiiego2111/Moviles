import 'dart:isolate';
import 'dart:async';
import 'package:flutter/material.dart';

// Función top-level para Isolate
int _heavyCompute(int n) {
  print('[Isolate] Iniciando cálculo para N=$n');
  int sum = 0;
  for (int i = 1; i <= n; i++) {
    sum += i;
  }
  print('[Isolate] Cálculo completado');
  return sum;
}

void _isolateEntry(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  receivePort.listen((message) {
    if (message is int) {
      final result = _heavyCompute(message);
      sendPort.send(result);
    }
  });
}

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  double _n = 10000000; // 10M
  String _result = '';
  String _time = '';
  bool _isComputing = false;
  double _progress = 0.0;

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  Future<void> _computeInIsolate() async {
    setState(() {
      _isComputing = true;
      _result = '';
      _time = '';
      _progress = 0.0;
    });

    final receivePort = ReceivePort();
    final stopwatch = Stopwatch()..start();

    print('[Main] Lanzando Isolate');
    final isolate = await Isolate.spawn(_isolateEntry, receivePort.sendPort);

    // Simular progreso
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted || !_isComputing) {
        timer.cancel();
        return;
      }
      setState(() {
        _progress = (_progress + 0.1).clamp(0.0, 0.9);
      });
    });

    late SendPort sendPort;
    receivePort.listen((message) {
      if (message is SendPort) {
        sendPort = message;
        sendPort.send(_n.toInt());
      } else if (message is int) {
        stopwatch.stop();
        print('[Main] Resultado recibido: $message');
        setState(() {
          _result = _formatNumber(message);
          _time = '${stopwatch.elapsedMilliseconds} ms';
          _progress = 1.0;
          _isComputing = false;
        });
        isolate.kill();
        receivePort.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Slider estilizado
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF2A2A2A), width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    '${(_n / 1000000).round()} millones',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: _n,
                    min: 10000000,
                    max: 1000000000,
                    divisions: 99,
                    activeColor: const Color(0xFF00E5A0),
                    inactiveColor: Colors.grey,
                    onChanged: _isComputing
                        ? null
                        : (value) {
                            setState(() {
                              _n = value;
                            });
                          },
                  ),
                  const Text(
                    'Número de elementos a sumar',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Barra de progreso
            if (_isComputing) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF2A2A2A)),
                ),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: Colors.grey,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00E5A0)),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Calculando en Isolate...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
            // Card de resultado
            if (_result.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF2A2A2A), width: 1),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Resultado',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Suma: $_result',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00E5A0),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00E5A0).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF00E5A0)),
                      ),
                      child: Text(
                        'Tiempo: $_time',
                        style: const TextStyle(
                          color: Color(0xFF00E5A0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
            // Botón ejecutar
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: _isComputing ? null : _computeInIsolate,
                icon: const Icon(Icons.memory, size: 32),
                label: const Text(
                  'Ejecutar en Isolate',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}