import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api.dart';

class ApiClient {
  static Future<void> saveAdvice({
    required int userId,
    required String input,
    required String result,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/save_advice.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'input_text': input,
        'result_text': result,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to save advice: ${res.body}');
    }
  }
static Future<List<dynamic>> getAdviceHistory(int userId) async {
    final res = await http.get(
      Uri.parse('$baseUrl/get_advice.php?user_id=$userId'),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to load history: ${res.body}');
    }
    return jsonDecode(res.body) as List<dynamic>;
  }
}