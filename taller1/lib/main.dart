import 'package:flutter/material.dart';
 
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
 
class HomePage extends StatefulWidget {
  const HomePage({super.key});
 
  @override
  State<HomePage> createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
  String _titulo = 'Hola, Flutter';
  bool _tituloCambiado = false;
 
  void _cambiarTitulo() {
    setState(() {
      _tituloCambiado = !_tituloCambiado;
      _titulo = _tituloCambiado ? '¡Título cambiado!' : 'Hola, Flutter';
    });
 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Título actualizado'),
        duration: Duration(seconds: 2),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titulo),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
 
            // Nombre del estudiante
            const Text(
              'Juan Diego Rodriguez Ortiz',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
 
            const SizedBox(height: 16),
 
            // Row de imágenes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Imagen de red con tamaño fijo y bordes redondeados
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://picsum.photos/150/150',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        loadingBuilder: (_, child, progress) =>
                            progress == null
                                ? child
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                      ),
                    ),
                  ),
 
                  // Imagen asset sin recorte
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Image.asset(
                      'assets/images/foto.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
 
            const SizedBox(height: 20),
 
            // Botón setState
            ElevatedButton(
              onPressed: _cambiarTitulo,
              child: const Text('Cambiar título'),
            ),
 
            const SizedBox(height: 24),
 
            // Widget 1: Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  border: Border.all(color: Colors.indigo, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '📦 Widget Container\nEste widget tiene márgenes, color de fondo y bordes redondeados.',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
 
            const SizedBox(height: 24),
 
            // Widget 2: ListView
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '📋 ListView',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
 
            SizedBox(
              height: 200,
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.star, color: Colors.amber),
                    title: Text('Elemento 1 – Flutter'),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.red),
                    title: Text('Elemento 2 – Dart'),
                  ),
                  ListTile(
                    leading: Icon(Icons.code, color: Colors.blue),
                    title: Text('Elemento 3 – StatefulWidget'),
                  ),
                  ListTile(
                    leading: Icon(Icons.school, color: Colors.green),
                    title: Text('Elemento 4 – setState()'),
                  ),
                ],
              ),
            ),
 
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}