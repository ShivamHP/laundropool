import 'package:flutter/material.dart';
import 'package:laundropool/screens/login_or_signup_screen.dart';
import 'package:laundropool/values/colors.dart';
import 'package:laundropool/values/constants.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors().gradientStart, AppColors().onBoardingBackground],
          begin: Alignment.center,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 42.0, horizontal: 8.0),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32)),
              ),
              child: Lottie.asset("assets/lotties/laundary.json"),
            ),
            Flexible(
              child: Container(),
              flex: 1,
            ),
            Text(
              AppConstants().AppName,
              style: const TextStyle(
                fontSize: 44,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> LoginOrSignUpScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "POOL YOUR LAUNDARY",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ),
              style: ButtonStyle(
                side: MaterialStateProperty.resolveWith<BorderSide>(
                    (states) => const BorderSide(color: Colors.white)),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                  return const StadiumBorder();
                }),
              ),
            ),
            Flexible(child: Container(), flex: 1),
          ],
        ),
      ),
    );
  }
}
