import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/phone_screen.dart';

class DrawerMain extends StatefulWidget {
  const DrawerMain({super.key});

  @override
  State<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const Text(
                'Profile',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const CircleAvatar(
                radius: 70,
              ),
              const Column(
                children: [
                  Text(
                    'Fahid',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'fahid@gmail.com',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '01-02-1999',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                child: const Text(
                  'Change Theme',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  _themeController.toggleTheme();
                  Navigator.pop(context); // Close the drawer
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAll(() => const PhoneScreen());
                },
                child: const Row(
                  children: [
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.logout),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeController extends GetxController {
  // Create an observable for theme mode
  var isDarkMode = false.obs;

  // Toggle the theme
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  // Get the current ThemeMode
  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
}
