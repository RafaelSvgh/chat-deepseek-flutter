import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000/api/chat/";

  Future<String> getChatResponse(String prompt) async {
    try {
      final body = json.encode({"prompt": prompt});
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        return data["response"];
      } else {
        print("Error HTTP: ${response.statusCode} - ${response.reasonPhrase}");
        return "Error: ${response.reasonPhrase}";
      }
    } catch (e) {
      print("Error al conectar con el servidor: $e");
      return "Error al conectar con el servidor: $e";
    }
  }
}
