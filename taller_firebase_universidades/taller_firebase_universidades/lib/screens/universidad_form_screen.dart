import 'package:flutter/material.dart';
import '../services/universidad_service.dart';
import '../models/universidad.dart';

class UniversidadFormScreen extends StatelessWidget {
  const UniversidadFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final universidadService = UniversidadService();
    final TextEditingController nitController = TextEditingController();
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController direccionController = TextEditingController();
    final TextEditingController telefonoController = TextEditingController();
    final TextEditingController paginaWebController = TextEditingController();

    void guardarUniversidad() {
      if (formKey.currentState?.validate() ?? false) {
        final universidad = Universidad(
          nit: nitController.text.trim(),
          nombre: nombreController.text.trim(),
          direccion: direccionController.text.trim(),
          telefono: telefonoController.text.trim(),
          paginaWeb: paginaWebController.text.trim(),
        );

        final contextCopy = context; // Store context to use in async callbacks
        universidadService.agregarUniversidad(universidad).then((_) {
          ScaffoldMessenger.of(contextCopy).showSnackBar(
            const SnackBar(content: Text('Universidad guardada exitosamente')),
          );
          Navigator.of(contextCopy).pop();
        }).catchError((error) {
          ScaffoldMessenger.of(contextCopy).showSnackBar(
            SnackBar(content: Text('Error al guardar: $error')),
          );
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Universidad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nitController,
                decoration: const InputDecoration(
                  labelText: 'NIT',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el NIT';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: direccionController,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la dirección';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el teléfono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: paginaWebController,
                decoration: const InputDecoration(
                  labelText: 'Página Web',
                  border: OutlineInputBorder(),
                  hintText: 'https://ejemplo.com',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la página web';
                  }
                  if (!value.startsWith('http://') && !value.startsWith('https://')) {
                    return 'La página web debe comenzar con http:// o https://';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: guardarUniversidad,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}