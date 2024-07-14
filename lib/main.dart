import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'view/phone_screen.dart';

import 'widgets/drawer_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  disableScreenshots();
  runApp(MyApp());
}

Future<void> disableScreenshots() async {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 235, 235, 235),
      brightness: Brightness.light,
      primaryColor: const Color.fromARGB(255, 255, 255, 255),
    );

    final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
      primaryColor: const Color.fromARGB(255, 112, 45, 45),
    );

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'OTP Login',
          theme: lightTheme,
          themeMode: _themeController.theme,
          darkTheme: darkTheme,
          home: const PhoneScreen(),
        ));
  }
}
