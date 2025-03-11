import 'package:translator/translator.dart';

class TranslationService {
  Future<String> translateToEnglish(String input) async {
    final translator = GoogleTranslator();
    final translatedAnswer =
        await translator.translate(input, to: 'en', from: 'hi');
    print(translatedAnswer);
    return translatedAnswer.text;
  }
}
