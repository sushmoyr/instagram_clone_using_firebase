import 'package:flutter/material.dart';
import 'package:instagram_clone_using_firebase/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return webScreenLayout;
        } else {
          return mobileScreenLayout;
        }
      },
    );
  }
}
