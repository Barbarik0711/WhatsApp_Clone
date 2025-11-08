import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone/model_learn/model/user_model.dart';
import 'package:whatsapp_clone/model_learn/model/userdob_model.dart';
import 'package:whatsapp_clone/model_learn/model/userlocation_model.dart';
import 'package:whatsapp_clone/model_learn/model/username_model.dart';

class UserApi {
  static Future<List<UserModel>> fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=1';
    debugPrint('URL: $url');
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      debugPrint('Response Status Code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final body = response.body;
        debugPrint('Response Body: $body');
        final json = jsonDecode(body);
        final results = json['results'] as List<dynamic>;
        final List<UserModel> users = results.map((peruser) {
           return UserModel.fromMap(peruser);
        }).toList();
        return users;
      } else {
        debugPrint("Failed to fetch users. Status code: ${response.statusCode}");
        throw Exception('Failed to load users');
      }
    } catch (e) {
      debugPrint("Error fetching users: $e");
      rethrow; // Rethrow to handle error in the calling widget
    }
  }
}