import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundropool/providers/user_provider.dart';
import 'package:laundropool/screens/create_pool_screen.dart';
import 'package:laundropool/screens/help_screen.dart';
import 'package:laundropool/screens/login_or_signup_screen.dart';
import 'package:laundropool/screens/my_open_pools_screen.dart';
import 'package:laundropool/values/colors.dart';
import 'package:laundropool/values/constants.dart';
import 'package:laundropool/widgets/beautiful_card.dart';
import 'package:laundropool/widgets/laundary_card.dart';
import 'package:provider/provider.dart';
import 'package:laundropool/models/user_model.dart' as model;
import 'package:http/http.dart' as http;

import '../resources/auth_methods.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  void logOut() async {
    await AuthMethods.signOut(context: context);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => LoginOrSignUpScreen(),
      ),
    );
  }

  void fetchUser() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return (user == null)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : (!user.email.endsWith("@goa.bits-pilani.ac.in") &&
                !user.email.contains("shivampachchigar14112@gmail.com"))
            ? Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "This app can only be accessed by Google account provided by BITS Pilani, Goa campus. Please logout and sign up with BITS ID",
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => logOut(),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors().primaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text(
                          "LOGOUT",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height:24),
                    const Text("Sorry for inconvenience!")
                  ],
                ),
              )
            : Scaffold(
                key: _key,
                endDrawer: Drawer(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        AppColors().gradientStart,
                        AppColors().gradientEnd
                      ],
                      begin: Alignment.center,
                      end: Alignment.bottomRight,
                    )),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.photoUrl),
                            radius: 32,
                          ),
                          title: Text(
                            user.username,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            "${user.hostel} ${user.roomNumber}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                            padding: const EdgeInsets.all(2),
                          ),
                        ),
                        const SizedBox(height: 32),
                        ListTile(
                          leading: const Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                          ),
                          title: const Text(
                            "My open pools",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => MyOpenPoolsScreen())));
                          },
                        ),
                        // ListTile(
                        //   leading: const Icon(
                        //     Icons.timeline,
                        //     color: Colors.white,
                        //   ),
                        //   title: const Text(
                        //     "Past pools",
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        //   onTap: () {},
                        // ),
                        // ListTile(
                        //   leading: const Icon(
                        //     Icons.notifications,
                        //     color: Colors.white,
                        //   ),
                        //   title: const Text(
                        //     "Notifications",
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        //   onTap: () {},
                        // ),
                        ListTile(
                          leading: const Icon(
                            Icons.help,
                            color: Colors.white,
                          ),
                          title: const Text(
                            "Help",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const HelpScreen(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          title: const Text(
                            "About",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const AboutScreen(),
                              ),
                            );
                          },
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          title: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            logOut();
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      Flexible(
                        flex: 1,
                        child: Row(
                          children: [
                            Text(
                              AppConstants().AppName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 32),
                            ),
                            Expanded(child: Container()),
                            // IconButton(
                            //   padding: const EdgeInsets.all(4),
                            //   onPressed: () {},
                            //   icon: const Icon(
                            //     Icons.notifications,
                            //   ),
                            // ),
                            // IconButton(
                            //   padding: const EdgeInsets.all(4),
                            //   onPressed: () {},
                            //   icon: const Icon(
                            //     Icons.timeline,
                            //   ),
                            // ),
                            IconButton(
                              padding: const EdgeInsets.all(4),
                              onPressed: () {
                                _key.currentState!.openEndDrawer();
                              },
                              icon: const Icon(Icons.menu),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),
                      Flexible(
                        child: Row(
                          children: [
                            Text(
                              "Open pools",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: AppColors().primaryColor),
                            ),
                            Expanded(child: Container()),
                            // IconButton(
                            //   onPressed: () {},
                            //   icon: const Icon(Icons.search),
                            // ),
                          ],
                        ),
                        flex: 1,
                      ),
                      const SizedBox(height: 12),
                      Flexible(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('pools')
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return LaundaryCard(
                                    data: snapshot.data!.docs[index].data());
                              },
                            );
                          },
                        ),
                        flex: 14,
                      )
                    ],
                  ),
                ),
                resizeToAvoidBottomInset: false,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreatePoolScreen(),
                      ),
                    );
                  },
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.add,
                      color: AppColors().primaryColor,
                      size: 32,
                    ),
                  ),
                ),
              );
  }
}
