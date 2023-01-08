import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/network/local/cache_helper.dart';
import '../login&register/login_screen/shoplogin_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                      onPressed: () {
                        CacheHelper.removeData(key: 'token')?.then((value) {
                          if (value!) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ShopLoginScreen(),
                                ),
                                (route) => false);
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.power_settings_new,
                      ),
                      label: const Text(
                        'Sign Out',
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
