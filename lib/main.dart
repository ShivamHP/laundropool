import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundropool/providers/user_provider.dart';
import 'package:laundropool/screens/home_screen.dart';
import 'package:laundropool/screens/onboarding_screen.dart';
import 'package:laundropool/screens/signup_screen.dart';
import 'package:laundropool/themes/dark_theme.dart';
import 'package:laundropool/themes/light_theme.dart';
import 'package:laundropool/values/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<String> userHasDetails() async {
    String res = "";
    var user = await FirebaseAuth.instance.currentUser;
    var collectionRef = FirebaseFirestore.instance.collection("users");
    await collectionRef.doc(user!.uid).get().then(
          (docSnapshot) => {
            if (docSnapshot.exists) {res = "DATA_FOUND"} else {res = "NO_DATA"}
          },
        );
    return res;
  }

  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppLightTheme(),
        themeMode: ThemeMode.light,
        darkTheme: AppDarkTheme(),
        home: StreamBuilder(
            stream: _connectivity.myStream,
            builder: (context, _connectionSnapshot) {
              if (_connectionSnapshot.hasData) {
                if (_connectionSnapshot.data.toString().startsWith("{ConnectivityResult.none: false}")
                    ) {
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: CircularProgressIndicator(
                              color: AppColors().primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Text(
                              "Wait. Looks like you are not connected to internet!")
                        ],
                      ),
                    ),
                  );
                } else {
                  return StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        // Checking if the snapshot has any data or not
                        if (snapshot.hasData) {
                          // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                          return FutureBuilder(
                            future: userHasDetails(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data == "DATA_FOUND") {
                                  return const HomeScreen();
                                } else if (snapshot.data == "NO_DATA") {
                                  return const SignupScreen();
                                }
                              }
                              return const Scaffold(
                                body: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('${snapshot.error}'),
                          );
                        }
                      }
                      // means connection to future hasnt been made yet
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors().primaryColor,
                          ),
                        );
                      }
                      return const OnBoardingScreen();
                    },
                  );
                }
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      ),
    );
  }
}

class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
