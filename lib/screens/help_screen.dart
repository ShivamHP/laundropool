import 'package:flutter/material.dart';

import '../values/colors.dart';
import '../values/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Help",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            const SizedBox(height: 36),
            Row(
              children: [
                Text(
                  "Contact the developer",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors().primaryColor),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(width: 12),
            Card(
              child: ListTile(
                onTap: () {
                  launch(
                    'mailto:shivampachchigar14112@gmail.com?subject=LaundroPool suggestions/bug reports&body=I\'m happy to use this app, but I\'ve some issue:\n',
                  );
                },
                title: const Text(
                  "Email developer",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                leading: const Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Row(
                children: [
                  Text(
                    "Frequently asked questions",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: AppColors().primaryColor),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              flex: 1,
            ),
            const SizedBox(height: 12),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ExpansionTile(
                      textColor: AppColors().secondaryColor,
                      iconColor: AppColors().secondaryColor,
                      title: const Text(
                        "What does this app do?",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4,
                          ),
                          child: Text(
                              "This app helps to find people who wants to pool their laundary with you"),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      textColor: AppColors().secondaryColor,
                      iconColor: AppColors().secondaryColor,
                      title: const Text(
                        "What shouldn't I just call my friends to pool laundary?",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4,
                          ),
                          child: Text(
                            "You ask this question to yourself: If you can call your friend to talk to him then why do you use social media? \n${AppConstants().AppName} is like a social media for laundary.",
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      textColor: AppColors().secondaryColor,
                      iconColor: AppColors().secondaryColor,
                      title: const Text(
                        "What data am I sharing in this app?",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4,
                          ),
                          child: Text(
                            "Your phone number is being shared with whomever you pool your laundary. \nThe developer trusts BITSians that they'll not misuse this feature. \nKeep in mind, the developer is not responsible for any damages made on your phone number.",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              flex: 7,
            )
          ],
        ),
      ),
    );
  }
}
