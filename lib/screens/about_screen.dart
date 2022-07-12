import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../values/colors.dart';
import '../values/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Flexible(
              flex: 2,
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
                    "About",
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
                  "About ${AppConstants().AppName}",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors().primaryColor),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "If you want to give small amount of clothes to laundary, it can be a problem. ${AppConstants().AppName} tries to eliminate this problem by creating pools in which users can combine their clothes and go to laundary together.",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Row(
                children: [
                  Text(
                    "About developer",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors().primaryColor,
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              flex: 1,
            ),
            const SizedBox(height: 12),
            Flexible(
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/shivam.png'),
                    radius: 64,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  SizedBox(
                    height: 128,
                    width: MediaQuery.of(context).size.width - 170,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Shivam Pachchigar",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "I am a student at BITS Pilani Goa campus pursuing Electrical & Electronics engineering. Feel free to contact me for Native Android/ Flutter contributions.",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              flex: 7,
            ),
            const SizedBox(height: 36),
            Row(
              children: [
                Text(
                  "My social media handles: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors().primaryColor),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => launch(
                        "https://www.linkedin.com/in/shivam-pachchigar-675320229/"),
                    child: Container(
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff0A66C2),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(2, 2),
                                blurRadius: 5,
                                color: Color(0xffc4c4c4))
                          ]),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/images/linkedin.png",
                              width: 24,
                              height: 24,
                            ),
                            const Text(
                              "LinkedIn",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            )
                          ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => launch("https://github.com/ShivamHP"),
                    child: Container(
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff000000),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(2, 2),
                                blurRadius: 5,
                                color: Color(0xffc4c4c4))
                          ]),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/images/github.png",
                              width: 32,
                              height: 32,
                              color: Colors.white,
                            ),
                            const Text(
                              "Github",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            )
                          ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        launch("https://www.instagram.com/shpachchigar/"),
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xffffffff),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(2, 2),
                                blurRadius: 5,
                                color: Color(0xffc4c4c4))
                          ]),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/images/instagram.png",
                              width: 24,
                              height: 24,
                            ),
                            const Text(
                              "Instagram",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            Row(
              children: [
                Text(
                  "Special thanks to: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors().primaryColor),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              "Arnav Borkar for designing part of the UI; \nYuvraj Singh Bhadauria for being a great mentor; \nShrish Dwivedi and GDSC BITS Goa for getting this app to Play store; \nAnd all the beta testers who took their time to find bugs in the app!",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
