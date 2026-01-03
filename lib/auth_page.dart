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
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? "Login" : "Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailC,
              decoration: const InputDecoration(labelText: "Email"),
            ),
             TextField(
              controller: passC,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: loading ? null : _submit,
              child: Text(loading ? "Please wait..." : (isLogin ? "Login" : "Create account")),
            ),
            TextButton(
              onPressed: () => setState(() => isLogin = !isLogin),
              child: Text(isLogin ? "Create new account" : "I already have an account"),
            ),
            if (error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(error, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}