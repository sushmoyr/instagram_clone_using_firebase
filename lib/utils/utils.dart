import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  return null;
}

extension UiExtensions on BuildContext {
  void showSnackBar(String content) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(content)));

  Future<dynamic> toDestination({required Widget destination}) =>
      Navigator.push(
        this,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return destination;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1, 0);
            const end = Offset.zero;
            final curve = Curves.easeInOut;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );

  Future<dynamic> replaceDestination({required Widget destination}) =>
      Navigator.pushReplacement(
        this,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return destination;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1, 0);
            const end = Offset.zero;
            final curve = Curves.easeInOut;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
}
