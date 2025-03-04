import 'package:crime_lens/utils/app_contants.dart';
import 'package:crime_lens/utils/chatbot_chats.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class DialogflowChatbotRepository {
  final DialogFlowtter dialogFlowtter;
  DialogflowChatbotRepository({required this.dialogFlowtter});

  void addMessage(Message message, [bool isUserMessage = false]) {
    chatbotChats.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
    if (isUserMessage) {
      chatbotChats.add({
        'message': Message(
            text: DialogText(text: const [kUserMessageFlagInBotChatPage])),
        'isUserMessage': false,
      });
    }
  }

  void removeUserMessageFlag() {
    chatbotChats.removeLast();
  }

  Future<DetectIntentResponse> getDialogFlowResponse(String text) async {
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: text)),
    );
    return response;
  }
}
