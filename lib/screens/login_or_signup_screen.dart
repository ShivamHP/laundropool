import 'package:flutter/material.dart';
import 'package:laundropool/screens/login_screen.dart';
import 'package:laundropool/screens/signup_screen.dart';
import 'package:laundropool/values/colors.dart';
import 'package:laundropool/values/constants.dart';

class LoginOrSignUpScreen extends StatelessWidget {
  const LoginOrSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ClipPath(
            clipper: TopLowestClipper(),
            child: Container(color: AppColors().primaryColorLightest),
          ),
          ClipPath(
            clipper: TopMiddleClipper(),
            child: Container(color: AppColors().primaryColorLighter),
          ),
          ClipPath(
            clipper: TopUpperClipper(),
            child: Container(color: AppColors().primaryColor),
          ),
          Align(
            alignment: const Alignment(80, 160),
            child: ClipPath(
              clipper: BottomLowestClipper(),
              child: Container(
                color: AppColors().primaryColorLightest,
                height: (MediaQuery.of(context).size.height) * 0.99,
                width: (MediaQuery.of(context).size.width) * 0.99,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(72, 166),
            child: ClipPath(
              clipper: BottomMiddleClipper(),
              child: Container(
                color: AppColors().primaryColorLighter,
                height: (MediaQuery.of(context).size.height) * 0.99,
                width: (MediaQuery.of(context).size.width) * 0.99,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(64, 170),
            child: ClipPath(
              clipper: BottomUpperClipper(),
              child: Container(
                color: AppColors().primaryColor,
                height: (MediaQuery.of(context).size.height) * 0.99,
                width: (MediaQuery.of(context).size.width) * 0.99,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: contents(context),
          )
        ],
      ),
    );
  }
}

Widget contents(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        AppConstants().AppName,
        style: const TextStyle(
            fontSize: 40, color: Colors.black, fontWeight: FontWeight.w900),
      ),
      const SizedBox(height: 32),
      const Text(
        "Want to give clothes for washing\nbut don't have enough kgs of them?\nPool your laundary today!",
        style: TextStyle(
          fontSize: 20,
          color: Colors.black54,
          fontWeight: FontWeight.w300,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 18),
      Text(
        "Find your friends on ${AppConstants().AppName},\nPool your laundary with them,\nand save money!",
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.001,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 40),
      TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
        },
        child: const Text(
          "LOG IN",
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
              (states) =>
                  const EdgeInsets.symmetric(horizontal: 48, vertical: 4)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => Colors.white),
          side: MaterialStateProperty.resolveWith<BorderSide>(
              (states) => const BorderSide(color: Colors.black)),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
            return const StadiumBorder();
          }),
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 100),
      //   child: Row(children: const  <Widget>[
      //     Expanded(child: Divider()),
      //     SizedBox(width: 8,),
      //     Text(
      //     "OR",
      //     style: TextStyle(
      //       fontSize: 14,
      //       color: Colors.black,
      //       fontWeight: FontWeight.w700,
      //       letterSpacing: 0.001,
      //     ),
      //     textAlign: TextAlign.center,
      //   ),
      //   SizedBox(width: 8,),
      //   Expanded(child: Divider()),
      //   ]),
      // ),
      // const SizedBox(height: 10),
      // TextButton(
      //   onPressed: () {
      //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen()));
      //   },
      //   child: const Text(
      //     "REGISTER",
      //     style: TextStyle(
      //       fontSize: 14.0,
      //       color: Colors.white,
      //     ),
      //   ),
      //   style: ButtonStyle(
      //     padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
      //         (states) =>
      //             const EdgeInsets.symmetric(horizontal: 48, vertical: 4)),
      //     backgroundColor: MaterialStateProperty.resolveWith<Color>(
      //         (states) => AppColors().primaryColor),
      //     // side: MaterialStateProperty.resolveWith<BorderSide>(
      //     //     (states) => const BorderSide(color: Colors.black)),
      //     shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
      //       return const StadiumBorder();
      //     }),
      //   ),
      // ),
    ],
  );
}

class TopLowestClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 875;
    path.lineTo(138.495 * _xScaling, 71.6847 * _yScaling);
    path.cubicTo(
      203.095 * _xScaling,
      34.9158 * _yScaling,
      149.793 * _xScaling,
      -36.4346 * _yScaling,
      115.068 * _xScaling,
      -67.5136 * _yScaling,
    );
    path.cubicTo(
      92.1317 * _xScaling,
      -82.3104 * _yScaling,
      135.382 * _xScaling,
      -110.085 * _yScaling,
      145.878 * _xScaling,
      -155.415 * _yScaling,
    );
    path.cubicTo(
      156.374 * _xScaling,
      -200.746 * _yScaling,
      62.6556 * _xScaling,
      -181.855 * _yScaling,
      45.2467 * _xScaling,
      -177.172 * _yScaling,
    );
    path.cubicTo(
      27.8378 * _xScaling,
      -172.49 * _yScaling,
      -35.2772 * _xScaling,
      -147.241 * _yScaling,
      3.68831 * _xScaling,
      -132.218 * _yScaling,
    );
    path.cubicTo(
      42.6539 * _xScaling,
      -117.195 * _yScaling,
      54.2462 * _xScaling,
      -72.1771 * _yScaling,
      -2.04543 * _xScaling,
      -57.4374 * _yScaling,
    );
    path.cubicTo(
      -58.337 * _xScaling,
      -42.6978 * _yScaling,
      -36.5414 * _xScaling,
      13.1319 * _yScaling,
      40.7145 * _xScaling,
      104.305 * _yScaling,
    );
    path.cubicTo(
      117.97 * _xScaling,
      195.478 * _yScaling,
      57.7445 * _xScaling,
      117.646 * _yScaling,
      138.495 * _xScaling,
      71.6847 * _yScaling,
    );
    path.cubicTo(
      138.495 * _xScaling,
      71.6847 * _yScaling,
      138.495 * _xScaling,
      71.6847 * _yScaling,
      138.495 * _xScaling,
      71.6847 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
    throw UnimplementedError();
  }
}

class TopMiddleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 875;
    path.lineTo(119.495 * _xScaling, 71.6847 * _yScaling);
    path.cubicTo(
      184.095 * _xScaling,
      34.9158 * _yScaling,
      130.793 * _xScaling,
      -36.4346 * _yScaling,
      96.0676 * _xScaling,
      -67.5136 * _yScaling,
    );
    path.cubicTo(
      73.1317 * _xScaling,
      -82.3104 * _yScaling,
      116.382 * _xScaling,
      -110.085 * _yScaling,
      126.878 * _xScaling,
      -155.415 * _yScaling,
    );
    path.cubicTo(
      137.374 * _xScaling,
      -200.746 * _yScaling,
      43.6556 * _xScaling,
      -181.855 * _yScaling,
      26.2467 * _xScaling,
      -177.172 * _yScaling,
    );
    path.cubicTo(
      8.83775 * _xScaling,
      -172.49 * _yScaling,
      -54.2772 * _xScaling,
      -147.241 * _yScaling,
      -15.3117 * _xScaling,
      -132.218 * _yScaling,
    );
    path.cubicTo(
      23.6539 * _xScaling,
      -117.195 * _yScaling,
      35.2462 * _xScaling,
      -72.1771 * _yScaling,
      -21.0454 * _xScaling,
      -57.4374 * _yScaling,
    );
    path.cubicTo(
      -77.337 * _xScaling,
      -42.6978 * _yScaling,
      -55.5414 * _xScaling,
      13.1319 * _yScaling,
      21.7145 * _xScaling,
      104.305 * _yScaling,
    );
    path.cubicTo(
      98.9705 * _xScaling,
      195.478 * _yScaling,
      38.7445 * _xScaling,
      117.646 * _yScaling,
      119.495 * _xScaling,
      71.6847 * _yScaling,
    );
    path.cubicTo(
      119.495 * _xScaling,
      71.6847 * _yScaling,
      119.495 * _xScaling,
      71.6847 * _yScaling,
      119.495 * _xScaling,
      71.6847 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
    throw UnimplementedError();
  }
}

class TopUpperClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 875;
    path.lineTo(100.495 * _xScaling, 59.6847 * _yScaling);
    path.cubicTo(
      165.095 * _xScaling,
      22.9158 * _yScaling,
      111.793 * _xScaling,
      -48.4346 * _yScaling,
      77.0676 * _xScaling,
      -79.5136 * _yScaling,
    );
    path.cubicTo(
      54.1317 * _xScaling,
      -94.3104 * _yScaling,
      97.3817 * _xScaling,
      -122.085 * _yScaling,
      107.878 * _xScaling,
      -167.415 * _yScaling,
    );
    path.cubicTo(
      118.374 * _xScaling,
      -212.746 * _yScaling,
      24.6556 * _xScaling,
      -193.855 * _yScaling,
      7.2467 * _xScaling,
      -189.172 * _yScaling,
    );
    path.cubicTo(
      -10.1622 * _xScaling,
      -184.49 * _yScaling,
      -73.2772 * _xScaling,
      -159.241 * _yScaling,
      -34.3117 * _xScaling,
      -144.218 * _yScaling,
    );
    path.cubicTo(
      4.65385 * _xScaling,
      -129.195 * _yScaling,
      16.2462 * _xScaling,
      -84.1771 * _yScaling,
      -40.0454 * _xScaling,
      -69.4374 * _yScaling,
    );
    path.cubicTo(
      -96.337 * _xScaling,
      -54.6978 * _yScaling,
      -74.5414 * _xScaling,
      1.13189 * _yScaling,
      2.71453 * _xScaling,
      92.3049 * _yScaling,
    );
    path.cubicTo(
      79.9705 * _xScaling,
      183.478 * _yScaling,
      19.7445 * _xScaling,
      105.646 * _yScaling,
      100.495 * _xScaling,
      59.6847 * _yScaling,
    );
    path.cubicTo(
      100.495 * _xScaling,
      59.6847 * _yScaling,
      100.495 * _xScaling,
      59.6847 * _yScaling,
      100.495 * _xScaling,
      59.6847 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
    throw UnimplementedError();
  }
}

class BottomLowestClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 875;
    path.lineTo(212.531 * _xScaling, 26.0292 * _yScaling);
    path.cubicTo(
      371.128 * _xScaling,
      -23.7094 * _yScaling,
      406.733 * _xScaling,
      172.234 * _yScaling,
      404.71 * _xScaling,
      276.423 * _yScaling,
    );
    path.cubicTo(
      393.994 * _xScaling,
      336.509 * _yScaling,
      505.344 * _xScaling,
      308.019 * _yScaling,
      595.539 * _xScaling,
      359.889 * _yScaling,
    );
    path.cubicTo(
      685.733 * _xScaling,
      411.76 * _yScaling,
      512.046 * _xScaling,
      536.399 * _yScaling,
      477.861 * _xScaling,
      557.764 * _yScaling,
    );
    path.cubicTo(
      443.676 * _xScaling,
      579.129 * _yScaling,
      306.199 * _xScaling,
      643.986 * _yScaling,
      340.964 * _xScaling,
      557.315 * _yScaling,
    );
    path.cubicTo(
      375.729 * _xScaling,
      470.644 * _yScaling,
      319.694 * _xScaling,
      383.091 * _yScaling,
      209.815 * _xScaling,
      452.786 * _yScaling,
    );
    path.cubicTo(
      99.9361 * _xScaling,
      522.481 * _yScaling,
      41.7452 * _xScaling,
      401.756 * _yScaling,
      10.1817 * _xScaling,
      136.403 * _yScaling,
    );
    path.cubicTo(
      -21.3818 * _xScaling,
      -128.95 * _yScaling,
      14.2847 * _xScaling,
      88.2024 * _yScaling,
      212.531 * _xScaling,
      26.0292 * _yScaling,
    );
    path.cubicTo(
      212.531 * _xScaling,
      26.0292 * _yScaling,
      212.531 * _xScaling,
      26.0292 * _yScaling,
      212.531 * _xScaling,
      26.0292 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
    throw UnimplementedError();
  }
}

class BottomMiddleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 875;
    path.lineTo(212.531 * _xScaling, 26.0292 * _yScaling);
    path.cubicTo(
      371.128 * _xScaling,
      -23.7094 * _yScaling,
      406.733 * _xScaling,
      172.234 * _yScaling,
      404.71 * _xScaling,
      276.423 * _yScaling,
    );
    path.cubicTo(
      393.994 * _xScaling,
      336.509 * _yScaling,
      505.344 * _xScaling,
      308.019 * _yScaling,
      595.539 * _xScaling,
      359.889 * _yScaling,
    );
    path.cubicTo(
      685.733 * _xScaling,
      411.76 * _yScaling,
      512.046 * _xScaling,
      536.399 * _yScaling,
      477.861 * _xScaling,
      557.764 * _yScaling,
    );
    path.cubicTo(
      443.676 * _xScaling,
      579.129 * _yScaling,
      306.199 * _xScaling,
      643.986 * _yScaling,
      340.964 * _xScaling,
      557.315 * _yScaling,
    );
    path.cubicTo(
      375.729 * _xScaling,
      470.644 * _yScaling,
      319.694 * _xScaling,
      383.091 * _yScaling,
      209.815 * _xScaling,
      452.786 * _yScaling,
    );
    path.cubicTo(
      99.9361 * _xScaling,
      522.481 * _yScaling,
      41.7452 * _xScaling,
      401.756 * _yScaling,
      10.1817 * _xScaling,
      136.403 * _yScaling,
    );
    path.cubicTo(
      -21.3818 * _xScaling,
      -128.95 * _yScaling,
      14.2847 * _xScaling,
      88.2024 * _yScaling,
      212.531 * _xScaling,
      26.0292 * _yScaling,
    );
    path.cubicTo(
      212.531 * _xScaling,
      26.0292 * _yScaling,
      212.531 * _xScaling,
      26.0292 * _yScaling,
      212.531 * _xScaling,
      26.0292 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
    throw UnimplementedError();
  }
}

class BottomUpperClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 875;
    path.lineTo(212.531 * _xScaling, 26.0292 * _yScaling);
    path.cubicTo(
      371.128 * _xScaling,
      -23.7094 * _yScaling,
      406.733 * _xScaling,
      172.234 * _yScaling,
      404.71 * _xScaling,
      276.423 * _yScaling,
    );
    path.cubicTo(
      393.994 * _xScaling,
      336.509 * _yScaling,
      505.344 * _xScaling,
      308.019 * _yScaling,
      595.539 * _xScaling,
      359.889 * _yScaling,
    );
    path.cubicTo(
      685.733 * _xScaling,
      411.76 * _yScaling,
      512.046 * _xScaling,
      536.399 * _yScaling,
      477.861 * _xScaling,
      557.764 * _yScaling,
    );
    path.cubicTo(
      443.676 * _xScaling,
      579.129 * _yScaling,
      306.199 * _xScaling,
      643.986 * _yScaling,
      340.964 * _xScaling,
      557.315 * _yScaling,
    );
    path.cubicTo(
      375.729 * _xScaling,
      470.644 * _yScaling,
      319.694 * _xScaling,
      383.091 * _yScaling,
      209.815 * _xScaling,
      452.786 * _yScaling,
    );
    path.cubicTo(
      99.9361 * _xScaling,
      522.481 * _yScaling,
      41.7452 * _xScaling,
      401.756 * _yScaling,
      10.1817 * _xScaling,
      136.403 * _yScaling,
    );
    path.cubicTo(
      -21.3818 * _xScaling,
      -128.95 * _yScaling,
      14.2847 * _xScaling,
      88.2024 * _yScaling,
      212.531 * _xScaling,
      26.0292 * _yScaling,
    );
    path.cubicTo(
      212.531 * _xScaling,
      26.0292 * _yScaling,
      212.531 * _xScaling,
      26.0292 * _yScaling,
      212.531 * _xScaling,
      26.0292 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
    throw UnimplementedError();
  }
}
