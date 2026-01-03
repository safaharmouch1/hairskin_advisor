import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_page.dart';
import 'home_page.dart';
import 'history_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> _startRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("user_id");
    return (userId == null) ? "/auth" : "/home";
  }

  @override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,

   
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFE91E63), 
      ),
      scaffoldBackgroundColor: const Color(0xFFFFF6FA), 
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFE4F1),
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFFF1F8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    ),

    routes: {
      "/auth": (_) => const AuthPage(),
      "/home": (_) => const HomePage(),
      "/history": (_) => const HistoryPage(),
    },
    home: FutureBuilder<String>(
      future: _startRoute(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, snap.data!);
        });
        return const SizedBox.shrink();
      },
    ),
  );
}

}
