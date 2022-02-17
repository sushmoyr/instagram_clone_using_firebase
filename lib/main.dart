import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_using_firebase/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone_using_firebase/responsive/responsive_layout.dart';
import 'package:instagram_clone_using_firebase/responsive/web_screen_layout.dart';
import 'package:instagram_clone_using_firebase/utils/colors.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}
