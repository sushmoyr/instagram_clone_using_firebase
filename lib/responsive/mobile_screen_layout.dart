import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_using_firebase/screens/login_screen.dart';
import 'package:instagram_clone_using_firebase/screens/sign_up_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  ValueNotifier<String> username = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  void _getUserName() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    username.value = snapshot.get('username');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<String>(
          valueListenable: username,
          builder: (BuildContext context, String value, Widget? child) {
            return Text('Hi ${username.value}');
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
