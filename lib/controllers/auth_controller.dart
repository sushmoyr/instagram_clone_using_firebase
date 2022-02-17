import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController usernameController;

  AuthController()
      : emailController = TextEditingController(),
        usernameController = TextEditingController(),
        passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
