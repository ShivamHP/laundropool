import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundropool/providers/user_provider.dart';
import 'package:laundropool/values/colors.dart';
import 'package:laundropool/values/constants.dart';
import 'package:provider/provider.dart';
import 'package:laundropool/models/user_model.dart' as model;
import '../widgets/user_laundary_card.dart';

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
    return Scaffold(
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
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Delete pools",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            const SizedBox(height: 36),
            Flexible(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('pools')
                    .where('creator', isEqualTo: user.username)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return const Center(
                  //     // child: CircularProgressIndicator(),
                  //     child: SizedBox(),
                  //   );
                  // }
                  if(snapshot.connectionState == ConnectionState.active){
                    return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return UserLaundaryCard(
                          data: snapshot.data!.docs[index].data());
                    },
                  );
                  }
                  return const Center(
                      // child: CircularProgressIndicator(),
                      child: SizedBox(),
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
