import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_using_firebase/resources/storage_methods.dart';
import 'package:instagram_clone_using_firebase/utils/strings.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? file,
  }) async {
    String res = 'Some error occurred';

    try {
      if (validInput(email) &&
          validInput(password) &&
          validInput(bio) &&
          validInput(username)) {
        //register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //upload pic
        String imageUrl = defaultProfileUrl;

        if (file != null) {
          imageUrl = await StorageMethods()
              .uploadImageToStorage('profilePictures', file, false);
        }

        print(imageUrl);

        await _firestore.collection('users').doc(credential.user!.uid).set({
          'username': username,
          'uid': credential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'imageUrl': imageUrl,
        });

        res = 'Success';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some  Error Occurred';
  }

  bool validInput(String value) => value.isNotEmpty;
}
