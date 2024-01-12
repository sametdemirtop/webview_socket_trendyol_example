import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/take_response_model.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<TokenResponse> getToken(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/token/'),
      body: {"username": username, "password": password},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      TokenResponse tokenResponse = TokenResponse.fromJson(data);
      return tokenResponse;
    } else {
      throw Exception('Failed to get token');
    }
  }
}