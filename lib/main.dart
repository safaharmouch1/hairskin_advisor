import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BeautyAdvisorApp());
}

class BeautyAdvisorApp extends StatelessWidget {
  const BeautyAdvisorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BaetyAdvisorPage(),
    );
  }
}

class BaetyAdvisorPage extends StatefulWidget {
  const BaetyAdvisorPage({super.key});

  @override
  State<BaetyAdvisorPage> createState() => _BaetyAdvisorPageState();
}

class _BaetyAdvisorPageState extends State<BaetyAdvisorPage> with SingleTickerProviderStateMixin {
  String? selectedHair;
  String? selectedSkin;

  bool showResults = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final hairTypes = [
    'Dry',
    'Oily',
    'Curly',
    'Damaged',
    'Normal',
  ];

  final skinTypes = [
    'Dry',
    'Oily',
    'Sensitive',
    'Combination',
    'Normal',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  List<String> getHairTips() {
    switch (selectedHair) {
      case 'Dry':
        return [
          'Use sulfate-free shampoo.',
          'Apply deep conditioner twice a week.',
          'Avoid heat styling when possible.',
          'Use argan or coconut oil on ends.',
          'Wash only 2–3 times per week.',
        ];
      case 'Oily':
        return [
          'Use lightweight shampoo.',
          'Avoid applying conditioner on the scalp.',
          'Wash every 2 days.',
          'Use dry shampoo when needed.',
          'Avoid touching your hair often.',
        ];
      case 'Curly':
        return [
          'Use curl-enhancing cream.',
          'Avoid brushing dry hair.',
          'Use diffuser with low heat.',
          'Deep moisturize weekly.',
          'Use silk pillowcase at night.',
        ];
      case 'Damaged':
        return [
          'Trim the ends regularly.',
          'Use protein-rich masks weekly.',
          'Avoid bleaching and strong dyes.',
          'Reduce heat styling as much as possible.',
          'Use leave-in repair cream.',
        ];
      default:
        return [
          'Use mild cleansing shampoo.',
          'Condition after each wash.',
          'Protect against sun heat.',
          'Use lightweight serum.',
          'Avoid excessive brushing.',
        ];
    }
  }

  List<String> getSkinTips() {
    switch (selectedSkin) {
      case 'Dry':
        return [
          'Use hydrating cleanser.',
          'Moisturize twice a day.',
          'Apply hyaluronic acid.',
          'Avoid hot water on the face.',
          'Use thick night cream.',
        ];
      case 'Oily':
        return [
          'Use gel-based moisturizer.',
          'Avoid heavy oils.',
          'Use niacinamide daily.',
          'Wash face twice a day only.',
          'Use clay mask once a week.',
        ];
      case 'Sensitive':
        return [
          'Avoid fragrances.',
          'Use soothing products like aloe vera.',
          'Test products before applying.',
          'Avoid scrubs.',
          'Use sunscreen for sensitive skin.',
        ];
      case 'Combination':
        return [
          'Use lightweight moisturizer in T-zone.',
          'Apply hydrating cream on dry areas.',
          'Use gentle cleanser.',
          'Avoid over-washing.',
          'Use clay mask on oily areas only.',
        ];
      default:
        return [
          'Use balanced skincare routine.',
          'Cleanse morning & night.',
          'Use vitamin C serum.',
          'Exfoliate 1–2 times per week.',
          'Wear sunscreen every day.',
        ];
    }
  }

  Widget buildTipsCard(String title, List<String> tips) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 10),
            ...tips.map(
              (t) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.check, color: Colors.pink.shade200, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        t,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffbe9f0),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink.shade300,
        title: Text(
          "Hair & Skin Advisor",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Hair Type",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedHair,
                    isExpanded: true,
                    hint: const Text("Choose hair type"),
                    items: hairTypes
                        .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedHair = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Skin Type",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedSkin,
                    isExpanded: true,
                    hint: const Text("Choose skin type"),
                    items: skinTypes
                        .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSkin = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (selectedHair != null && selectedSkin != null) {
                      setState(() {
                        showResults = true;
                      });
                      _controller.forward(from: 0);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade300,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Generate"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showResults = false;
                      selectedHair = null;
                      selectedSkin = null;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Clear"),
                ),
              ],
            ),
            const SizedBox(height: 25),
            if (showResults) ...[
              buildTipsCard("Hair Routine Tips", getHairTips()),
              buildTipsCard("Skin Routine Tips", getSkinTips()),
            ],
          ],
        ),
      ),
    );
  }
}
