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
