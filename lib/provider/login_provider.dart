import 'package:demo_retrofit_moor/data/api/api_service.dart';
import 'package:demo_retrofit_moor/data/local/shared_preference.dart';
import 'package:demo_retrofit_moor/data/repository.dart';
import 'package:flutter/cupertino.dart';

import '../const.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider();

  Future<bool> get isLogin async {
    String? token = await SharedPreference.instance.getToken();
    return token != null;
  }

  Future logOut() async {
    await Repository.instance.deleteAll();
    await SharedPreference.instance.deleteToken();
    notifyListeners();
  }

  Future login(String username, String password) async {
    var rs = await ApiService.instance.login();
    print("login Success");
    SharedPreference.instance.saveToken(rs);
    notifyListeners();
  }
}
