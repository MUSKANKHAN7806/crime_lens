import 'package:crime_lens/screens/complain/complain_form.dart';
import 'package:crime_lens/services/gemini_service.dart';
import 'package:crime_lens/services/translation_service.dart';
import 'package:crime_lens/widgets/loading.dart';
import 'package:flutter/material.dart';

class TextPreprocessingScreen extends StatefulWidget {
  final String inputText;
  const TextPreprocessingScreen({super.key, required this.inputText});

  @override
  State<TextPreprocessingScreen> createState() =>
      _TextPreprocessingScreenState();
}

class _TextPreprocessingScreenState extends State<TextPreprocessingScreen> {
  bool isLoading = true;

  @override
  void initState() {
    translate();
    super.initState();
  }

  void translate() async {
    final translatedData =
        await TranslationService().translateToEnglish(widget.inputText);
    final incidentJson =
        await GeminiService().extractDataFromText(translatedData);
    isLoading = false;
    setState(() {});
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ComplainForm(
              incidentDetails: incidentJson,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: isLoading ? const LoadingWidget() : null,
      ),
    );
  }
}
