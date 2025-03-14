import 'package:flutter/material.dart';
import 'package:movil/services/api_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ApiService apiService = ApiService();
  String _response = "";
  bool _isLoading = false; // Nueva variable para controlar el estado de carga

  void _sendMessage() async {
    String prompt = _controller.text.trim();
    if (prompt.isEmpty) return;

    setState(() {
      _isLoading = true; // Activar el indicador de carga
      _response = ""; // Limpiar la respuesta previa
    });

    String response = await apiService.getChatResponse(prompt);

    setState(() {
      _isLoading = false; // Desactivar el indicador de carga
      _response = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Chat con DeepSeek",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Escribe tu pregunta",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendMessage,
              child: const Text(
                "Preguntar",
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator()) // Mostrar el loading si está cargando
                : Text(
                    "Respuesta: $_response",
                    style: const TextStyle(fontSize: 20),
                  ),
          ],
        ),
      ),
    );
  }
}
