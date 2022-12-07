import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/Screen/homepage.dart';

import 'package:workshop/Screen/signin.dart';
import 'package:workshop/model/user.dart';
import 'package:workshop/preference/shared_preference.dart';
import 'package:workshop/provider/auth_provider.dart';
import 'package:workshop/provider/user_provider.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<User> getUser() => UserPreference().getUser();
    
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(

        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const SignInScreen(),
        home: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if(snapshot.hasError) {
                   return Text('Error: ${snapshot.error}');
              }  
             else if(snapshot.data!.token == "null") {
                return const SignInScreen();
            } else {
              return const HomePage();
            }
          }
          },
          ),
        ),
      );
    
  }
}
