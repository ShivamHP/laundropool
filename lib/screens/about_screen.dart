import 'package:flutter/material.dart';

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
                        color: AppColors().primaryColor),
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
            Expanded(
              child: Container(),
              flex: 2,
            ),
            Text(
              "Thank you for using this app!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors().primaryColorLightest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
