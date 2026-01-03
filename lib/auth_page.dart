import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config/api.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool isLogin = true;
  bool loading = false;
  String error = "";

  Future<void> _submit() async {
    setState(() {
      loading = true;
      error = "";
    });

final endpoint = isLogin ? "login.php" : "register.php";

    try {
      final res = await http.post(
        Uri.parse("$baseUrl/$endpoint"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailC.text.trim(),
          "password": passC.text.trim(),
        }),
      );

      final data = jsonDecode(res.body);

if (res.statusCode != 200 || data["ok"] != true) {
        setState(() {
          error = data["error"]?.toString() ?? "Request failed";
          loading = false;
        });
        return;
      }
      final int userId = int.parse(data["user_id"].toString());

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt("user_id", userId);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}