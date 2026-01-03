import 'package:flutter/material.dart';
import 'services/session.dart';
import 'services/api_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final inputC = TextEditingController();
  String resultText = "";

  Future<void> _generateAndSave() async {
    final input = inputC.text.trim();
    if (input.isEmpty) return;
    final result = "Advice for: $input";

    setState(() => resultText = result);

    final userId = await Session.userId();
    if (userId != null) {
      await ApiClient.saveAdvice(
        userId: userId,
        input: input,
        result: result,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}