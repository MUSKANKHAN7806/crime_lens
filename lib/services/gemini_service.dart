import 'dart:convert';

import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  final gemini = Gemini.init(apiKey: 'AIzaSyC0pobVS-Jdx6cX1HfETGFgPi_qT8zmykw');

  Future parseContentFromText(String text) async {
    final response =
        await gemini.prompt(parts: [Part.text('Write a short poem on trees')]);
    print(response?.output);
  }

  Future<Map<String, dynamic>?> extractDataFromText(String text) async {
    final response = await gemini.prompt(parts: [
      Part.text(
          'For the text given within double quotes you have to extract the data in stringified JSON format containing the keys: location, date_time, type, description. The values for date_time will be in DateTime type of dart while the rest keys will have string values. The output will only have the stringified json. If any value is not present in the text then keep the value of that key as null. "$text"')
    ]);
    print(response?.output);
    Map<String, dynamic>? jsonMap;
    if (response != null && response.output != null) {
      final responseString = response.output!;
      final jsonString = responseString.substring(
          responseString.indexOf('{'), responseString.lastIndexOf('}') + 1);
      jsonMap = jsonDecode(jsonString);
    }
    return jsonMap;
  }
}
