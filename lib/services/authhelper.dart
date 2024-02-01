import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_shop/models/auth/login_model.dart';
import 'package:online_shop/models/auth/signup_model.dart';
import 'package:online_shop/models/auth_response/login_res_model.dart';
import 'package:online_shop/models/auth_response/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

class AuthHelper {
  static var client = http.Client();

  Future<bool> login(LoginModel model) async {

    Map<String, String> requsetHeaders = {
      'Content-Type': 'application/json'
    };

    var url = Uri.http(Config.apiUrl, Config.loginUrl);

    var response = await client.post(url, headers: requsetHeaders, body: jsonEncode(model.toJson()));

    if(response.statusCode == 200){

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String userToken = loginResponseModelFromJson(response.body).token;
      String userId = loginResponseModelFromJson(response.body).id;

      await prefs.setString('token', userToken);
      await prefs.setString('userId', userId);
      await prefs.setBool('isLogged', true);

      return true;

    }else {
      return false;
    }
  }

  Future<bool> signup(SignupModel model) async {

    Map<String, String> requsetHeaders = {
      'Content-Type': 'application/json'
    };

    var url = Uri.http(Config.apiUrl, Config.loginUrl);

    var response = await client.post(url, headers: requsetHeaders, body: jsonEncode(model.toJson()));

    if(response.statusCode == 201){

      return true;

    }else {
      return false;
    }
  }

  Future<ProfileRes> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = await prefs.getString('token');
    Map<String, String> requsetHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken'
    };

    var url = Uri.http(Config.apiUrl, Config.getUserUrl);

    var response = await client.post(url, headers: requsetHeaders);

    if(response.statusCode == 200){

      var profile = profileResFromJson(response.body);
      return profile;

    }else {
      throw Exception("Failed to get profile");
    }
  }
}