import 'package:flutter/material.dart';
import '../services/universidad_service.dart';
import '../models/universidad.dart';

class UniversidadListScreen extends StatelessWidget {
  const UniversidadListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final universidadService = UniversidadService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Universidades'),
      ),
      body: StreamBuilder<List<Universidad>>(
        stream: universidadService.getUniversidades(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final universidades = snapshot.data ?? [];
          if (universidades.isEmpty) {
            return const Center(
              child: Text('No hay universidades registradas'),
            );
          }
          return ListView.builder(
            itemCount: universidades.length,
            itemBuilder: (context, index) {
              final universidad = universidades[index];
              return ListTile(
                title: Text(universidad.nombre),
                subtitle: Text('NIT: ${universidad.nit}\nDirección: ${universidad.direccion}'),
                trailing: Text(universidad.telefono),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/nueva');
        },
        tooltip: 'Nueva Universidad',
        child: const Icon(Icons.add),
      ),
    );
  }
}