import 'package:flutter/cupertino.dart';
import 'package:task/model/auth_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:task/service/url_constants.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;

  get isLoading => _isLoading;  

  Future<AuthUserModel> userLogin(String userName, String password) async {
    http.Response response = await http.post(
      Uri.parse(apiLogin),
      body: {"username": userName, "password": password},
    );
    print("Response ===> ${response.body}");
    return AuthUserModel.fromJson(response.body);
  }

  void loading() {
    _isLoading = true;
    notifyListeners();
  }
}
