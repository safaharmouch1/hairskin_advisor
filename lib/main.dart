import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(const BeautyAdvisorApp());
}

class BeautyAdvisorApp extends StatelessWidget {
  const BeautyAdvisorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BeautyAdvisorApp(),
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

  final hairTypes =[
    'Dry',
    'Oily',
    'Curly',
    'Damaged',
    'Normal',

  ];

  final skinTypes =[
    'Dry',
    'Oily',
    'Sensitive',
    'Combination'
    'Normal'
  ];

  @override
  void initState(){
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700),);

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn,);
  }

  List<String> getHairTipes(){
    switch (selectedHair){
      case 'Dry':
       return [
          'Use sulfate-free shampoo.',
          'Apply deep conditioner twice a week.',
          'Avoid heat styling when possible.',
          'Use argan or coconut oil on ends.',
          'Wash only 2–3 times per week.',
        ];
        case 'Oily' :
        return [
          'Use lightweight shampoo.',
          'Avoid applying conditioner on the scalp.',
          'Wash every 2 days.',
          'Use dry shampoo when needed.',
          'Avoid touching your hair often.',
        ];
       case 'Curly' :
       return [
          'Use curl-enhancing cream.',
          'Avoid brushing dry hair.',
          'Use diffuser with low heat.',
          'Deep moisturize weekly.',
          'Use silk pillowcase at night.',
        ];
        case "Damaged" :
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

  List<String> getskinTypes() {
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
        return[
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

  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


  