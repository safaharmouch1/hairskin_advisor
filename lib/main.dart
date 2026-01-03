import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_page.dart';
import 'history_page.dart';
import 'main.dart' 
;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/auth": (_) => const AuthPage(),
        "/home": (_) => const MyApp(), // ✅ بدّلي HomePage باسم صفحتك
        "/history": (_) => const HistoryPage(),
      },
       home: FutureBuilder<String>(
        future: _startRoute(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
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