import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_using_firebase/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone_using_firebase/responsive/responsive_layout.dart';
import 'package:instagram_clone_using_firebase/responsive/web_screen_layout.dart';
import 'package:instagram_clone_using_firebase/screens/login_screen.dart';
import 'package:instagram_clone_using_firebase/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBBj23gJLeyV3H_M-YhK0FxHsGD7gbzQAs",
        authDomain: "instagram-clone-9e8c2.firebaseapp.com",
        projectId: "instagram-clone-9e8c2",
        storageBucket: "instagram-clone-9e8c2.appspot.com",
        messagingSenderId: "645153079022",
        appId: "1:645153079022:web:20ee4662af89dbcaf6bdff",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    DevicePreview(
      enabled: false,
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
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return LoginScreen();
          },
        )
        /*ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),*/
        );
  }
}
