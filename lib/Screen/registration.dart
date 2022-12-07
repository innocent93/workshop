import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/Screen/signin.dart';
import 'package:workshop/model/user.dart';
import 'package:workshop/provider/auth_provider.dart';
import 'package:workshop/provider/user_provider.dart';
import 'package:workshop/util/http_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("registration"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    clipBehavior: Clip.none,
                    child: const Text(
                      "Registration",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: name,
                    keyboardType: TextInputType.name,
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(label: Text("Name")),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: email,
                    keyboardType: TextInputType.name,
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(label: Text("Email")),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    keyboardType: TextInputType.name,
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(label: Text("Password")),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: authProvider.registeredStatus == Status.registering
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: (() {
                            if (_formKey.currentState!.validate()) {
                              authProvider
                                  .register(
                                      name.text, email.text, password.text)
                                  .then((response) {
                                if (response['status'] == 500) {
                                  HttpService().showMessage(
                                      response['message'], context);
                                } else {
                                  User user = User(
                                      user: response['data'].user,
                                      token: response['data'].token);
                                  userProvider.setUser(user);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInScreen()));
                                }
                              });
                            }
                          }),
                          child: const Text("Submit")),
                )
              ],
            )),
      ),
    );
  }
}
