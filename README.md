# Travel-app

**Travel** es una aplicación Flutter para planificar y gestionar tus viajes. Desarrollada con Dart, Firebase y Google Fonts.

---

## Tecnologías utilizadas

<p align="center">
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/></a>
  <a href="https://dart.dev"><img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/></a>
  <a href="https://firebase.google.com"><img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase"/></a>
  <a href="https://fonts.google.com"><img src="https://img.shields.io/badge/Google_Fonts-4285F4?style=for-the-badge&logo=google&logoColor=white" alt="Google Fonts"/></a>
</p>

| Tecnología | Descripción |
|------------|-------------|
| ![Flutter](https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/flutter/flutter-original.svg) **Flutter** | Framework multiplataforma para iOS, Android y Web |
| ![Dart](https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/dart/dart-original.svg) **Dart** | Lenguaje de programación |
| ![Firebase](https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/firebase/firebase-plain.svg) **Firebase** | Backend (Auth, Firestore) |
| ![Google Fonts](https://cdn.simpleicons.org/googlefonts/4285F4) **Google Fonts** | Tipografías personalizadas |

---

## Capturas de la aplicación

<p align="center">
  <img src="https://placehold.co/280x600/0175C2/FFFFFF?text=Travel+Home" alt="Pantalla principal" width="280"/>
  <img src="https://placehold.co/280x600/02569B/FFFFFF?text=Detalle+Viaje" alt="Detalle de viaje" width="280"/>
  <img src="https://placehold.co/280x600/FFCA28/1A1A1A?text=Perfil" alt="Perfil" width="280"/>
</p>

> **Nota:** Reemplaza estas imágenes con capturas reales de tu app cuando las tengas.

## Requisitos previos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.11+)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- Java JDK 11+
- Node.js 16+

## Instalación

```bash
# Navegar al directorio del proyecto
cd travell_app   # o la ruta donde tengas el proyecto

# Instalar dependencias
flutter pub get
```

## Configuración de Firebase

1. Crea un proyecto en [Firebase Console](https://console.firebase.google.com/).
2. Inicializa Firebase en el proyecto:

```bash
firebase login
firebase init
```

3. Selecciona los servicios que necesites (Firestore, Authentication, etc.).
4. Configura las opciones de Flutter con FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

## Desarrollo con emulador de Firebase

Para desarrollo local sin afectar datos de producción, usa el **Firebase Emulator Suite**:

### 1. Iniciar los emuladores

```bash
firebase emulators:start
```

O solo los servicios que uses:

```bash
firebase emulators:start --only auth,firestore
```

### 2. Conectar la app Flutter al emulador

En tu código, antes de usar Firebase:

```dart
// Para Auth
await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

// Para Firestore
FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
```

### 3. URLs del emulador

- **UI del Emulator Suite**: http://localhost:4000
- **Auth**: localhost:9099
- **Firestore**: localhost:8080
- **Realtime Database**: localhost:9000

## Ejecutar la app

```bash
# Modo debug
flutter run

# Web
flutter run -d chrome

# Con emulador de Firebase activo
firebase emulators:start &
flutter run
```

## Estructura del proyecto

```
travell_app/
├── lib/
│   └── main.dart
├── web/
├── android/
├── ios/
├── pubspec.yaml
└── README.md
```

## Recursos

- [Documentación de Flutter](https://docs.flutter.dev/)
- [Firebase para Flutter](https://firebase.google.com/docs/flutter/setup)
- [Firebase Emulator Suite](https://firebase.google.com/docs/emulator-suite)
- [Google Fonts en Flutter](https://pub.dev/packages/google_fonts)
