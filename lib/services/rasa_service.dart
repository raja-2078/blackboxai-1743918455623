import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rasaServiceProvider = Provider<RasaService>((ref) {
  return RasaService();
});

class RasaService {
  static const String _baseUrl = 'http://your-rasa-server:5005';
  static const String _endpoint = '/webhooks/rest/webhook';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$_endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'sender': 'user',
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return data[0]['text'] ?? 'I did not understand that.';
        }
        return 'I did not understand that.';
      } else {
        throw Exception('Failed to get response from Rasa');
      }
    } catch (e) {
      throw Exception('Error communicating with Rasa: $e');
    }
  }
}