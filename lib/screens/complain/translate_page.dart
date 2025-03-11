import 'package:crime_lens/services/translation_service.dart';
import 'package:flutter/material.dart';

class TestingTranslation extends StatefulWidget {
  final String inputText;
  const TestingTranslation({super.key, required this.inputText});

  @override
  State<TestingTranslation> createState() => _TestingTranslationState();
}

class _TestingTranslationState extends State<TestingTranslation> {
  late String displayText;
  @override
  void initState() {
    displayText = widget.inputText;
    translate();
    super.initState();
  }

  void translate() async {
    displayText =
        await TranslationService().translateToEnglish(widget.inputText);
    setState(() {});
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(displayText),
      ),
    );
  }
}
