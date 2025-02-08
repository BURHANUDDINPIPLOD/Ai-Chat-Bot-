import 'dart:convert';

import 'package:http/http.dart' as http;

class ClaudeApiService {
  static const String _baseUrl = 'https://api.aimlapi.com/v1';
  static const String _apiVersion = '2023-06-01';
  static const String _model = 'gpt-4o';
  static const int _maxTokens = 1024;

final String _apiKey;

ClaudeApiService({required String apiKey}) : _apiKey = apiKey;

Future<String> sendMessage(String content) async{
  try{
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: _getHeaders(),
      body: _getRequestBody(content)
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return data['content'][0]['text'];
    }
    else{
      throw Exception(
        'Failed to send message. Status code: ${response.statusCode}');
    }
  }
  catch (e){
    throw Exception('Api Error : $e');
  }
}
Map<String , String> _getHeaders() => {
  "Content-Type":"application/json",
  "x-api-key" : _apiKey ,
  "anthropic-version" : _apiVersion
};

String _getRequestBody(String content) => jsonEncode({
  "model":_model,
  "messages":[
    {"role":"user" , "content" : content}
  ],
  "max_tokens" : _maxTokens,
});
}