# Taller de Asincronía y Segundo Plano en Flutter

Este proyecto demuestra el uso de conceptos avanzados de asincronía y ejecución en segundo plano en Flutter, incluyendo Future, async/await, Timer e Isolates.

## Conceptos Explicados

### Future y Async/Await
- **Future**: Representa un valor que estará disponible en el futuro. Se usa para operaciones asíncronas como llamadas a APIs, lectura de archivos, etc.
- **Async/Await**: Sintaxis para trabajar con Futures de manera más legible. `async` marca una función como asíncrona, `await` pausa la ejecución hasta que el Future se complete.
- **Cuándo usar**: Para operaciones I/O (red, disco), simulaciones de delay, cualquier tarea que no bloquee el hilo principal.

### Timer
- **Timer**: Permite ejecutar código después de un delay o periódicamente.
- **Timer.periodic**: Ejecuta una función repetidamente cada cierto intervalo.
- **Cuándo usar**: Cronómetros, actualizaciones periódicas de UI, tareas programadas.
- **Importante**: Siempre cancelar el Timer en `dispose()` para evitar memory leaks.

### Isolate
- **Isolate**: Un hilo de ejecución separado en Dart, con su propio heap y event loop.
- **Cuándo usar**: Para cálculos pesados que podrían bloquear la UI, procesamiento de datos intensivo, tareas que requieren paralelismo real.
- **Comunicación**: Usar SendPort y ReceivePort para enviar mensajes entre isolates.

## Diagrama de Pantallas

```
Home Screen
├── Future Screen (async/await demo)
├── Timer Screen (cronómetro)
└── Isolate Screen (cálculo en segundo plano)
```

## Estructura del Proyecto

- `lib/main.dart`: Configuración de MaterialApp con rutas nombradas y tema oscuro.
- `lib/screens/home_screen.dart`: Menú principal con navegación a las 3 pantallas.
- `lib/screens/future_screen.dart`: Demo de Future y async/await con estados visuales.
- `lib/screens/timer_screen.dart`: Cronómetro con Timer.periodic.
- `lib/screens/isolate_screen.dart`: Cálculo pesado usando Isolates.
- `lib/services/data_service.dart`: Servicio simulado con Future.delayed.

## Comandos GitFlow

```bash
# Crear rama feature
git checkout -b feature/taller_segundo_plano

# Commits en la rama feature
git add .
git commit -m "Implementar taller completo de asincronía"

# Merge a dev
git checkout dev
git merge feature/taller_segundo_plano

# Merge a main
git checkout main
git merge dev

# Push a remote
git push origin main
```
