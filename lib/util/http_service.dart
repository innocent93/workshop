import 'package:flutter/material.dart';

class HttpService {
  //base url
  // ignore: constant_identifier_names, non_constant_identifier_names
  static String base_url = "https://emmi-softwaretrack.online/api/";
  static String register = "${base_url}register";
  static String login = "${base_url}login";
  void showMessage(String message, BuildContext context) {
    var snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
