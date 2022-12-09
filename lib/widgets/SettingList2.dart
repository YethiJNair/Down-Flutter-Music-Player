import 'package:down/widgets/popUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:down/widgets/NotificationList.dart';
import 'package:down/widgets/SettingsList.dart';
import 'package:share_plus/share_plus.dart';

class SettingList2 extends StatelessWidget {
  const SettingList2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    showAboutDialog(
                      
                        context: context,
                        applicationName: "Down",
                        applicationIcon: Image.asset(
                          "assets/logo.jpg",
                          height: 32,
                          width: 32,
                        ),
                        applicationVersion: "1.0.1",
                        children: [
                          const Text(
                              "Down is an offline music player app which allows use to hear music from their local storage and also do functions like add to favorites , create playlists , recently played , mostly played etc."),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("App developed by Yethi J Nair.")
                        ]);
                  },
                  leading: const Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "About",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                        fontSize: 18),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Share.share("https://github.com/sinan70257/musify",
                        subject: "Github Repo Of This App");
                  },
                  leading: const Icon(
                    Icons.share,
                    size: 35,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Share",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                        fontSize: 18),
                  ),
                ),
                const NotificationList(
                    title: "Notification", logo: Icons.notifications),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return settingmenupopup(
                              mdFilename: 'termsandconditons.md');
                        });
                  },
                  leading: const Icon(
                    Icons.book,
                    size: 35,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Terms And Conditions",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                        fontSize: 18),
                  ),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return settingmenupopup(
                              mdFilename: 'privacypolicy.md');
                        });
                  },
                  leading: const Icon(
                    Icons.privacy_tip,
                    size: 35,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Privacy policy",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
