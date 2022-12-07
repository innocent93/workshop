import 'package:flutter/cupertino.dart';
import 'package:workshop/model/user.dart';

class UserProvider with ChangeNotifier {
  var changeName = "";
  // var token = "";
  void setUser(User name) {
    changeName = name.user;
    // token = name.token;
    notifyListeners();
  }
}
