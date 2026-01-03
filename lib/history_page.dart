import 'package:flutter/material.dart';
import 'services/session.dart';
import 'services/api_client.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<dynamic>> future;

  Future<List<dynamic>> _load() async {
    final uid = await Session.userId();
    if (uid == null) return [];
    return ApiClient.getAdviceHistory(uid);
  }

  @override
  void initState() {
    super.initState();
    future = _load();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: const Text("Advice History")),
      body: FutureBuilder<List<dynamic>>(
        future: future,
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snap.data!;
          if (items.isEmpty) {
            return const Center(child: Text("No history yet."));
          }
          
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              final it = items[i] as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(it["input_text"] ?? ""),
                  subtitle: Text(it["result_text"] ?? ""),
                  trailing: Text((it["created_at"] ?? "").toString().split(" ").first),
                ),
              );
            },
          );
        },
      ),
    );
  }
}