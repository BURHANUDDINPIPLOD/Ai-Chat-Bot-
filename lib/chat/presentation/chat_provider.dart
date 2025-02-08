import 'package:flutter/material.dart';
import 'package:myapp/chat/data/claude_api_service.dart';
import 'package:myapp/chat/model/message.dart';

class ChatProvider with ChangeNotifier{
  final _apiService = ClaudeApiService(apiKey: '6471c93305ac44128ff3991e8ddee5c9');

  final List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String content) async{
    if(content.trim().isEmpty) return;

    final userMessage=Message(
      content: content, 
      isUser: true, 
      timestamp: DateTime.now(),
      );

    _messages.add(userMessage);
    notifyListeners();
    _isLoading = true;
    notifyListeners();

    try{
      final response = await _apiService.sendMessage(content);
      final responseMessage = Message(
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      );
      _messages.add(responseMessage);
      notifyListeners();
    }
    catch(e){
      final errorMessage = Message(
        content: 'Something went wrong. Please try again later.',
        isUser: false,
        timestamp: DateTime.now(),
      );
      _messages.add(errorMessage);
    }
      _isLoading = false;
      notifyListeners();
  }
}