import 'package:flutter/material.dart';
import 'package:instagram_clone_using_firebase/resources/auth_methods.dart';
import 'package:instagram_clone_using_firebase/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone_using_firebase/responsive/responsive_layout.dart';
import 'package:instagram_clone_using_firebase/responsive/web_screen_layout.dart';
import 'package:instagram_clone_using_firebase/screens/sign_up_screen.dart';
import 'package:instagram_clone_using_firebase/utils/colors.dart';
import 'package:instagram_clone_using_firebase/utils/dimensions.dart';
import 'package:instagram_clone_using_firebase/utils/utils.dart';
import 'package:instagram_clone_using_firebase/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isLoading = false;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget button = InkWell(
      onTap: _loginUser,
      child: Container(
        child: const Text('Log in'),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        height: 48,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: blueColor,
        ),
      ),
    );
    Widget progress = CircularProgressIndicator();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              FractionallySizedBox(
                widthFactor: 0.75,
                child: Image.asset(
                  'assets/images/insta_text_512.png',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 64),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter Your Email',
              ),
              vSpace24,
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter Your Password',
                isPass: true,
              ),
              vSpace24,
              isLoading ? progress : button,
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text('Don\'t have an account?'),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  InkWell(
                    onTap: _navigateToSignUp,
                    child: Container(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blueColor,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                  vSpace24,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      isLoading = false;
    });

    context.showSnackBar(res);

    if (res == 'Success') {
      context.replaceDestination(
          destination: ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ));
    }
  }

  void _navigateToSignUp() {
    context.toDestination(destination: SignupScreen());
  }
}
