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
     return Scaffold(
      appBar: AppBar(
        title: const Text("HairSkin Advisor"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, "/history"),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Session.logout();
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, "/auth");
            },
          ),
        ],
      ),
       body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: inputC,
              decoration: const InputDecoration(
                labelText: "Describe your issue",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _generateAndSave,
              child: const Text("Generate & Save"),
            ),
            const SizedBox(height: 12),
            if (resultText.isNotEmpty)
              Text(
                resultText,
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
     
}