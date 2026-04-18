import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/future_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/isolate_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller Asincronía y Segundo Plano',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F1923),
        cardColor: const Color(0xFF1A2635),
        primaryColor: const Color(0xFF00C896),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00C896),
          secondary: Color(0xFF4D9EFF),
          error: Color(0xFFFF4D6A),
          surface: Color(0xFF1A2635),
          onSurface: Color(0xFFE8F4FD),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F1923),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFFE8F4FD),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Color(0xFF00C896)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00C896),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFFF4D6A)),
            foregroundColor: const Color(0xFFFF4D6A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFE8F4FD)),
          bodyMedium: TextStyle(color: Color(0xFF7A9BB5)),
          titleLarge: TextStyle(color: Color(0xFFE8F4FD), fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/future': (context) => const FutureScreen(),
        '/timer': (context) => const TimerScreen(),
        '/isolate': (context) => const IsolateScreen(),
      },
    );
  }
}
