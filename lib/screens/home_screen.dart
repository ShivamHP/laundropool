import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundropool/providers/user_provider.dart';
import 'package:laundropool/screens/create_pool_screen.dart';
import 'package:laundropool/screens/help_screen.dart';
import 'package:laundropool/screens/login_or_signup_screen.dart';
import 'package:laundropool/screens/delete_pools_screen.dart';
import 'package:laundropool/screens/my_pools_screen.dart';
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
        : Scaffold(
            key: _key,
            drawer: Drawer(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [AppColors().gradientStart, AppColors().gradientEnd],
                  begin: Alignment.center,
                  end: Alignment.bottomRight,
                )),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const SizedBox(width:8),
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
                      // trailing: IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(
                      //     Icons.edit,
                      //     color: Colors.white,
                      //     size: 20,
                      //   ),
                      //   padding: const EdgeInsets.all(2),
                      // ),
                    ),
                    const SizedBox(height: 32),
                    ListTile(
                      leading: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Delete my pools",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => MyOpenPoolsScreen())));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "My pools",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const MyPoolsScreen())));
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
                        IconButton(
                          onPressed: () {
                            _key.currentState!.openDrawer();
                          },
                          icon: Image.asset("assets/images/menu.png"),
                        ),
                        const SizedBox(width: 12),
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
                          .orderBy("available_space", descending: true)
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
