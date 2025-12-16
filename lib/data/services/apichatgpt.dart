import 'package:dio/dio.dart';
import 'envKey.dart';

final dio = Dio(BaseOptions(baseUrl: 'https://api.openai.com/v1'));

// Keep conversation memory
List<Map<String, String>> conversation = [
  {
    "role": "system",
    "content":
        "You are a friendly AI language tutor. Ask the user which language they want to learn, then focus only on teaching that language. Correct mistakes, give examples, exercises, and simple explanations. Always ask follow-up questions to reinforce learning. Avoid unrelated conversation.",
  },
];

Future<String> getAIResponse(String userMessage) async {
  try {
    // Add user message to conversation
    conversation.add({"role": "user", "content": userMessage});

    final response = await dio.post(
      '/chat/completions',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $api_key',
        },
      ),
      data: {
        "model": "gpt-4o-mini",
        "messages": conversation,
        "temperature": 0.7,
        "max_tokens": 500,
        "top_p": 0.9,
      },
    );

    final aiText = response.data['choices'][0]['message']['content'];

    // Add AI response to conversation memory
    conversation.add({"role": "assistant", "content": aiText.toString()});

    return aiText.toString();
  } on DioException catch (e) {
    print("❌ Dio error: ${e.response?.data ?? e.message}");
    return "Sorry, I couldn’t connect right now. 😅";
  } catch (e) {
    print("❌ Other error: $e");
    return "Sorry, I couldn’t connect right now. 😅";
  }
}
