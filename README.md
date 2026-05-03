# Taller 1 — Distribución de APK con Firebase App Distribution

**Asignatura:** Desarrollo de Aplicaciones Móviles  
**Universidad:** UCEVA  
**Estudiante:** Juan Diego Rodriguez Ortiz  
**Repositorio:** https://github.com/Juandiiego2111/Moviles  
**Fecha:** 03 de mayo de 2026

---

## Descripción

Distribución y prueba de un APK Flutter usando Firebase App Distribution. Se distribuyeron dos versiones (`1.0.0` → `1.0.1`) al grupo de testers `QA_Clase` siguiendo el flujo GitFlow.

---

## Flujo del proceso

```
Generar APK → Configurar Firebase App Distribution → Agregar Testers → Subir APK → Distribuir → Actualizar versión → Redistribuir
```

---

## Publicación — Pasos para replicar

### 1. Preparar el proyecto Flutter

```bash
# Verificar applicationId
cat android/app/build.gradle.kts | grep applicationId

# Verificar versión en pubspec.yaml
# version: 1.0.0+1  (formato: versionName+versionCode)
```

### 2. Generar el APK release

```bash
flutter build apk --release
# Salida: build/app/outputs/flutter-apk/app-release.apk
```

### 3. Configurar Firebase App Distribution

1. Ir a [Firebase Console](https://console.firebase.google.com) → crear proyecto
2. Registrar la app Android con el `applicationId`
3. Ir a **App Distribution** → **Verificadores y grupos**
4. Crear grupo `QA_Clase`
5. Agregar tester: `dduran@uceva.edu.co`

### 4. Subir y distribuir el APK

1. Ir a **App Distribution** → **Versiones**
2. Arrastrar el archivo `app-release.apk`
3. Asignar al grupo `QA_Clase`
4. Agregar Release Notes (ver formato abajo)
5. Clic en **Distribuir**

### 5. Actualización incremental

```yaml
# pubspec.yaml — cambiar versión
version: 1.0.1+2  # versionName+versionCode
```

```bash
flutter build apk --release
# Subir el nuevo APK a App Distribution y redistribuir
```

---

## Versionado

| Campo | Descripción | Ejemplo |
|-------|-------------|---------|
| `versionName` | Versión visible al usuario (MAJOR.MINOR.PATCH) | `1.0.1` |
| `versionCode` | Número entero incremental interno de Android | `2` |
| `pubspec.yaml` | Formato: `versionName+versionCode` | `1.0.1+2` |

---

## Formato de Release Notes

```
v{VERSION} - {DD/MM/YYYY}
- {Descripción del cambio}
- Responsable: {Nombre}
```

**Ejemplo:**
```
v1.0.1 - 03/05/2026
- Actualización incremental de prueba
- Responsable: Juan Diego Rodriguez Ortiz
```

---

## Versiones distribuidas

| Versión | Build | Fecha | Testers | Notas |
|---------|-------|-------|---------|-------|
| 1.0.0 | 1 | 03/05/2026 | 1 (QA_Clase) | Versión inicial |
| 1.0.1 | 2 | 03/05/2026 | 1 (QA_Clase) | Actualización incremental de prueba |

---

## GitFlow

```
main
 └── dev
      └── feature/app_distribution  ← trabajo aquí
           └── PR #5 → dev (Merged)
                └── PR #6 → main (Merged)
```

---

## Estructura del proyecto

```
taller_app_distribution/
├── android/
│   └── app/
│       └── build.gradle.kts       # applicationId
├── lib/
│   └── main.dart
├── pubspec.yaml                    # version: 1.0.1+2
└── build/
    └── app/outputs/flutter-apk/
        └── app-release.apk        # APK generado
```
