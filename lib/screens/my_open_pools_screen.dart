import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundropool/providers/user_provider.dart';
import 'package:laundropool/screens/create_pool_screen.dart';
import 'package:laundropool/screens/help_screen.dart';
import 'package:laundropool/screens/login_or_signup_screen.dart';
import 'package:laundropool/values/colors.dart';
import 'package:laundropool/values/constants.dart';
import 'package:laundropool/widgets/beautiful_card.dart';
import 'package:laundropool/widgets/laundary_card.dart';
import 'package:provider/provider.dart';
import 'package:laundropool/models/user_model.dart' as model;
import 'package:http/http.dart' as http;

import '../resources/auth_methods.dart';
import '../widgets/user_laundary_card.dart';
import 'about_screen.dart';

class MyOpenPoolsScreen extends StatefulWidget {
  const MyOpenPoolsScreen({Key? key}) : super(key: key);

  @override
  State<MyOpenPoolsScreen> createState() => _MyOpenPoolsScreenState();
}

class _MyOpenPoolsScreenState extends State<MyOpenPoolsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    fetchUser();
    super.initState();
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  Flexible(
                    child: Row(
                      children: [
                        Text(
                          "My open pools",
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
                          .where('creator', isEqualTo: user.username)
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
                            return UserLaundaryCard(
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
            
          );
  }
}
