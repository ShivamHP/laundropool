import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laundropool/resources/auth_methods.dart';
import 'package:laundropool/screens/home_screen.dart';
import 'package:laundropool/screens/login_or_signup_screen.dart';
import 'package:laundropool/screens/signup_screen.dart';
import 'package:laundropool/values/colors.dart';

void loginWithGoogle(BuildContext context) async {
  var user = await AuthMethods.signInWithGoogle(context: context);
  if (user != null) {
    String _name = user.displayName.toString();
    SnackBar snackBar = SnackBar(
      content: Text("Hi $_name"),
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors().gradientStart, AppColors().gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(100)),
              ),
              child: info(context),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: loginFunctionality(context),
            ),
          ),
        ],
      ),
    );
  }
}

Widget info(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginOrSignUpScreen()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        Flexible(
          child: Container(),
          flex: 2,
        ),
        const Text(
          "Welcome back!",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 32),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Yay! You're back!\nThanks for using this app.",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        ),
        Flexible(
          child: Container(),
          flex: 3,
        ),
        const Text(
          "LOG IN",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}

Widget loginFunctionality(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 32,
        ),
        const Text(
          "To get logged in, use your BITS ID.\nThis app is restricted to BITS Pilani Goa campus organization.",
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {
            loginWithGoogle(context);
          },
          child: ListTile(
            leading: SvgPicture.asset("assets/images/google_icon.svg"),
            title: const Center(
              child: Text(
                "Login with Google",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => Colors.white),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
              return const StadiumBorder();
            }),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account?",
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            GestureDetector(
                child: Text(
                  "Sign up",
                  style: TextStyle(color: AppColors().primaryColor),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                }),
          ],
        ),
        const SizedBox(
          height: 16,
        )
      ],
    ),
  );
}
