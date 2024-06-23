import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vible_wallet_clone/providers/user_provider.dart';

class LoginServices {
  static Future<bool> login({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          'https://api.socialverseapp.com/user/login',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            'mixed': username,
            'password': password,
          },
        ),
      );

      Provider.of<UserProvider>(context, listen: false)
          .setUser(jsonDecode(response.body));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('Flic-Token', jsonDecode(response.body)['token']);

      return Future.value(true);
    } catch (e) {
      print(e.toString());
      return Future.value(false);
    }
  }
}
