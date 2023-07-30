import 'package:flutter/cupertino.dart';
import 'package:cafe/Auth/login_page.dart';
import 'package:cafe/Auth/register_screen.dart';

class AuthPage extends StatefulWidget {
   const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  void toggleView() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(toggleView: toggleView)
      : RegisterPage(toggleView: toggleView);
}