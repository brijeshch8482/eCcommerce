
import 'package:flutter/widgets.dart';
import 'package:online_shop/models/auth/login_model.dart';
import 'package:online_shop/services/authhelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier{

  bool _isObsecure = false;
  bool get isObsecure => _isObsecure;
  set isObsecure(bool value) {
    _isObsecure = value;
    notifyListeners();
  }

  bool _processing = false;
  bool get processing => _processing;
  set processing(bool value) {
    _processing = value;
    notifyListeners();
  }

  bool _loginResponseBool = false;
  bool get loginResponseBool => _loginResponseBool;
  set loginResponseBool(bool value) {
    _loginResponseBool = value;
    notifyListeners();
  }

  bool _responseBool = false;
  bool get responseBool => _responseBool;
  set responseBool(bool value) {
    _responseBool = value;
    notifyListeners();
  }


  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  set loggedIn(bool value) {
    _loggedIn = value;
    notifyListeners();
  }

  Future<bool> userLogin(LoginModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    processing = true;
    bool response = await AuthHelper().login(model);
    processing = false;

    loginResponseBool = response;

    loggedIn = prefs.getBool('isLogged') ?? false;

    return loginResponseBool;

  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userId');
    prefs.setBool('isLogged', false);

    loggedIn = prefs.getBool('isLogged') ?? false;
  }

}