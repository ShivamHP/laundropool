import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../values/colors.dart';
import 'beautiful_card.dart';
import 'request_pool_dialog.dart';
import 'user_pop_up.dart';

class BottomDialogSheet extends StatefulWidget {
  Map<String, dynamic> data;

  BottomDialogSheet({Key? key, required this.data}) : super(key: key);

  @override
  State<BottomDialogSheet> createState() => _BottomDialogSheetState();
}

class _BottomDialogSheetState extends State<BottomDialogSheet> {


  @override
  Widget build(BuildContext context) {
  List<String> _participants = widget.data["participants"].keys.toList();
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.465,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
        color: Color(0xffF1F4FB),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.data["creator"]}'s pool",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "TOTAL POOL SIZE",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            BeautifulCard(
                              content: "${widget.data["total_space"]} KG",
                              color: AppColors().primaryColor,
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: [
                            const Text(
                              "AVAILABLE SPACE",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            BeautifulCard(
                              content: "${widget.data["available_space"]} KG",
                              color: AppColors().secondaryColor,
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: [
                            const Text(
                              "LAUNDARY SERVICE",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            BeautifulCard(
                              content: "${widget.data["laundary_service"]}",
                              color: AppColors().tertiaryColor,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "POOL DESCRIPTION",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.data["bio"],
                      style: const TextStyle(fontSize: 12.0),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "EXPECTED DATE OF LAUNDARY",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                          color: Colors.grey.shade300,
                          padding: const EdgeInsets.all(8),
                          child: Text(widget.data["day_of_month"].toString()),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                          color: Colors.grey.shade300,
                          padding: const EdgeInsets.all(8),
                          child: Text(widget.data["month"].toString()),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                          color: Colors.grey.shade300,
                          padding: const EdgeInsets.all(8),
                          child: Text(widget.data["year"].toString()),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "POOLERS",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 108,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where("uid", whereIn:  _participants)
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
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      useSafeArea: false,
                                      builder: (context) {
                                        return Dialog(
                                          child: UserPopUp(
                                              data: snapshot.data!.docs[index]
                                                  .data()),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(24),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 32,
                                        backgroundImage: NetworkImage(snapshot
                                            .data!.docs[index]["photoUrl"]),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]["username"]
                                                .toString()
                                                .substring(0, 10) +
                                            "..",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${widget.data["participants"][snapshot.data!.docs[index]["uid"]]} KG",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return RequestPoolDialog(
                      data: widget.data,
                    );
                  },
                );
              },
              child: ListTile(
                title: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "REQUEST TO POOL",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => AppColors().primaryColor),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                  return const StadiumBorder();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
