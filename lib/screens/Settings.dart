import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:farm_sanctuary_delivery/screens/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../services/sessionService.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late final SessionService _session;

  @override
  void initState() {
    _session = SessionService();
    _session.init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white.withOpacity(.94),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Settings",
          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SimpleUserCard(
              userName: _session.login.toString(),
              userProfilePic: AssetImage(
                "assets/images/Logo farmSanctuary delivery.png",
              ),
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title: 'Appearance',
                  titleStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  subtitle: "Make Ziar'App yours",
                  onTap: () {},
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.fingerprint,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Privacy',
                  titleStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  subtitle: "Lock Ziar'App to improve your privacy",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Dark mode',
                  titleStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  subtitle: "Automatic",
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  titleStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  subtitle: "Learn more about Ziar'App",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {
                    _session.signout();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                  },
                  icons: Icons.exit_to_app_rounded,
                  iconStyle: IconStyle(iconsColor: Colors.grey, backgroundColor: Colors.transparent),
                  title: "Sign Out",
                  titleStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
