import 'package:flutter/material.dart';
import 'package:instagram_clone_using_firebase/controllers/auth_controller.dart';
import 'package:instagram_clone_using_firebase/utils/colors.dart';
import 'package:instagram_clone_using_firebase/utils/dimensions.dart';

enum AuthType { login, signUp }

extension on AuthType {
  AuthType flip() {
    if (this == AuthType.login) {
      return AuthType.signUp;
    }
    return AuthType.login;
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthController _authController;
  bool isObscured = false;
  AuthType _authType = AuthType.login;

  @override
  void initState() {
    _authController = AuthController();
    super.initState();
  }

  @override
  void dispose() {
    _authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        double width = (constraints.maxWidth > webScreenSize)
            ? webScreenSize
            : constraints.maxWidth;

        return SizedBox(
          width: width,
          height: constraints.maxHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Image.asset(
                    'assets/images/insta_text_512.png',
                    color: Colors.white,
                  ),
                ),
                defaultVerticalSpacing,
                if (_authType == AuthType.signUp)
                  TextFormField(
                    controller: _authController.emailController,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: mobileSearchColor,
                      hintText: 'Enter your username',
                      hintStyle: Theme.of(context).textTheme.caption,
                    ),
                  ),
                if (_authType == AuthType.signUp) defaultVerticalSpacing,
                TextFormField(
                  controller: _authController.emailController,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: mobileSearchColor,
                    hintText: 'Phone number, email address or username',
                    hintStyle: Theme.of(context).textTheme.caption,
                  ),
                ),
                defaultVerticalSpacing,
                TextFormField(
                  controller: _authController.passwordController,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    filled: true,
                    fillColor: mobileSearchColor,
                    hintText: 'Password',
                    hintStyle: Theme.of(context).textTheme.caption,
                    suffixIcon: InkWell(
                      onTap: () => setState(() {
                        isObscured = !isObscured;
                      }),
                      child: Icon(
                          isObscured ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  obscureText: isObscured,
                ),
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: blueColor),
                        ))
                  ],
                ),
                defaultVerticalSpacing,
                ElevatedButton(
                  onPressed: () {},
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Log in',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedDefaultTextStyle(
                      child: Text((_authType == AuthType.login)
                          ? 'Don\'t have an account?'
                          : 'Already have an account?'),
                      style: Theme.of(context).textTheme.bodyText1!,
                      duration: defaultAnimationDuration,
                    ),
                    TextButton(
                      onPressed: _changeAuthType,
                      child: Text(
                          (_authType == AuthType.login) ? 'Sign Up' : 'Log in'),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  void _changeAuthType() {
    setState(() {
      _authType = _authType.flip();
    });
  }
}
