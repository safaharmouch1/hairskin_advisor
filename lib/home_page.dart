import 'package:flutter/material.dart';
import 'services/session.dart';
import 'services/api_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String skinType = "Oily";
  String hairType = "Straight";
  String skinConcern = "Acne";
  String hairConcern = "Frizz";

  String resultText = "";

  final skinTypes = const ["Oily", "Dry", "Combination", "Sensitive"];
  final hairTypes = const ["Straight", "Wavy", "Curly", "Coily"];
  final skinConcerns = const ["Acne", "Dryness", "Redness", "Dark spots"];
  final hairConcerns = const ["Frizz", "Hair fall", "Dry ends", "Dandruff"];

  String buildAdvice() {
    final skinAdvice = {
      "Acne": "• Use a gentle salicylic acid cleanser\n• Avoid heavy oils\n• Use non-comedogenic moisturizer",
      "Dryness": "• Use a hydrating cleanser\n• Apply moisturizer twice daily\n• Add hyaluronic acid",
      "Redness": "• Avoid strong exfoliants\n• Use soothing ingredients (niacinamide)\n• Sunscreen daily",
      "Dark spots": "• Vitamin C in the morning\n• Retinol at night (slowly)\n• Sunscreen is a must",
    };

    final hairAdvice = {
      "Frizz": "• Use leave-in conditioner\n• Avoid hot tools\n• Try hair oil on ends",
      "Hair fall": "• Gentle scalp massage\n• Check iron/vitamin D\n• Avoid tight hairstyles",
      "Dry ends": "• Trim regularly\n• Deep conditioning 1-2x/week\n• Reduce heat styling",
      "Dandruff": "• Use anti-dandruff shampoo\n• Don’t scratch scalp\n• Keep scalp clean",
    };

    return """
Skin Type: $skinType
Skin Concern: $skinConcern

${skinAdvice[skinConcern] ?? ""}

Hair Type: $hairType
Hair Concern: $hairConcern

${hairAdvice[hairConcern] ?? ""}

Extra:
• Drink water + sleep well
• Sunscreen daily
""";
  }

  Future<void> generateAndSave() async {
    final advice = buildAdvice();
    setState(() => resultText = advice);

    final uid = await Session.userId();
    if (uid != null) {
      await ApiClient.saveAdvice(
        userId: uid,
        input: "Skin: $skinType/$skinConcern | Hair: $hairType/$hairConcern",
        result: advice,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hair & Skin Advisor"),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Skin", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _dropdown("Skin Type", skinType, skinTypes, (v) => setState(() => skinType = v)),
                  const SizedBox(height: 10),
                  _dropdown("Skin Concern", skinConcern, skinConcerns, (v) => setState(() => skinConcern = v)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Hair", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _dropdown("Hair Type", hairType, hairTypes, (v) => setState(() => hairType = v)),
                  const SizedBox(height: 10),
                  _dropdown("Hair Concern", hairConcern, hairConcerns, (v) => setState(() => hairConcern = v)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: generateAndSave,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Generate Advice"),
            ),
            const SizedBox(height: 14),
            if (resultText.isNotEmpty)
              _card(
                child: Text(
                  resultText,
                  style: const TextStyle(height: 1.4),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> items, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Color(0xFFFFF1F8),
          ),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ],
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 6),
            color: Color(0x14000000),
          )
        ],
      ),
      child: child,
    );
  }
}
