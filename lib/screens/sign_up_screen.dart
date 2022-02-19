import 'package:flutter/material.dart';
import 'package:instagram_clone_using_firebase/resources/auth_methods.dart';
import 'package:instagram_clone_using_firebase/utils/colors.dart';
import 'package:instagram_clone_using_firebase/utils/dimensions.dart';
import 'package:instagram_clone_using_firebase/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _usernameController;
  late final TextEditingController _bioController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _bioController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
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
                vSpace24,
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150x150.png?text=User'),
                    ),
                    Positioned(
                      bottom: -10,
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
                vSpace24,
                TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: 'Enter Your Username',
                ),
                vSpace24,
                TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress,
                ),
                vSpace24,
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter Your Password',
                  isPass: true,
                  textInputType: TextInputType.visiblePassword,
                ),
                vSpace24,
                TextFieldInput(
                  textEditingController: _bioController,
                  hintText: 'Enter Your Bio',
                  textInputType: TextInputType.multiline,
                ),
                vSpace24,
                InkWell(
                  onTap: () async {
                    var res = await AuthMethods().signUpUser(
                      email: _emailController.text,
                      password: _passwordController.text,
                      username: _usernameController.text,
                      bio: _bioController.text,
                    );

                    print(res);
                  },
                  child: Container(
                    child: const Text('Sign up'),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: blueColor,
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text('Already have an account?'),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    InkWell(
                      child: Container(
                        child: Text(
                          'Log in',
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
      ),
    );
  }
}
