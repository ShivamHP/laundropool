import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laundropool/screens/home_screen.dart';
import 'package:laundropool/screens/login_or_signup_screen.dart';
import 'package:laundropool/screens/login_screen.dart';
import 'package:laundropool/values/colors.dart';
import 'package:laundropool/values/constants.dart';
import 'package:laundropool/widgets/text_field_input.dart';

import '../resources/auth_methods.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _roomNoController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  String _selectedHostel = "DH-1";

  @override
  void dispose() {
    _roomNoController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void addDataToFirebase(BuildContext context) async {
    if (_phoneController.text.length != 10 &&
        _roomNoController.text.length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter correct phone number and room numer."),
        ),
      );
      return;
    }
    var user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      String res = await AuthMethods().addUserToFirebase(
          _selectedHostel,
          _roomNoController.text.toString(),
          _phoneController.text.toString(),
          user.displayName.toString(),
          user.email.toString(),
          user.uid,
          user.photoURL.toString());
      if (res == "success") {
        SnackBar snackBar = const SnackBar(
          content: Text("Created account successfully!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        SnackBar snackBar = SnackBar(
          content: Text(res),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
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
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.white,
              child: signUpFunctionality(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget hostelPicker() {
    return Container(
      width: 120,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset("assets/images/hostel.svg"),
          ),
          const SizedBox(
            width: 4,
          ),
          DropdownButton<String>(
            value: _selectedHostel,
            items: <String>[
              "AH-1",
              "AH-2",
              "AH-3",
              "AH-4",
              "AH-5",
              "AH-6",
              "AH-7",
              "AH-8",
              "AH-9",
              "CH-1",
              "CH-2",
              "CH-3",
              "CH-4",
              "CH-5",
              "CH-6",
              "CH-7",
              "DH-1",
              "DH-2",
              "DH-3",
              "DH-4",
              "DH-5",
              "DH-6",
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedHostel = newValue!;
              });
            },
          ),
        ],
      ),
    );
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginOrSignUpScreen()));
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
          Text(
            "Get started with\n${AppConstants().AppName}",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 32),
          ),
          const SizedBox(
            height: 24,
          ),
          Flexible(
            child: Container(),
            flex: 3,
          ),
          const Text(
            "REGISTER",
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

  Widget signUpFunctionality(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const Text(
              "Hostel",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                hostelPicker(),
                const SizedBox(width: 8),
                SizedBox(
                  width: 200,
                  child: TextFieldInput(
                      svgImage: SvgPicture.asset("assets/images/room.svg"),
                      hintText: "Room number",
                      textInputType: TextInputType.number,
                      textEditingController: _roomNoController),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "Phone number",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextFieldInput(
                svgImage: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset("assets/images/phone.svg"),
                ),
                hintText: "Enter phone number",
                textInputType: TextInputType.phone,
                textEditingController: _phoneController),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_roomNoController.text == "" ||
                    _roomNoController.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill all fields"),
                    ),
                  );
                } else {
                  addDataToFirebase(context);
                }
              },
              child: const ListTile(
                title: Center(
                  child: Text(
                    "CONTINUE",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => AppColors().primaryColor),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                  return const StadiumBorder();
                }),
              ),
            ),
            const SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }
}
