import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundropool/values/colors.dart';
import 'package:laundropool/widgets/beautiful_card.dart';

import 'bottom_dialog_sheet.dart';

class UserLaundaryCard extends StatefulWidget {
  Map<String, dynamic> data;

  UserLaundaryCard({Key? key, required this.data}) : super(key: key);

  @override
  State<UserLaundaryCard> createState() => _UserLaundaryCardState();
}

class _UserLaundaryCardState extends State<UserLaundaryCard> {
  removePool(String docID) {
    var collection = FirebaseFirestore.instance.collection("pools");
    collection.doc(docID).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              enableDrag: true,
              context: context,
              builder: (context) {
                return BottomDialogSheet(data: widget.data);
              },
            );
          },
          child: Card(
            elevation: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  color: Color(0xffF1F4FB),
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${widget.data["creator"]}'s Pool",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.cancel_rounded,
                size: 24,
                color: Colors.red,
              ),
              radius: 12,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actionsPadding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      title: const Text(
                        "Do you really want to delete this pool?",
                        style: TextStyle(fontSize: 16),
                      ),
                      actions: [
                        GestureDetector(
                          onTap: (){
                            removePool(widget.data["uid"]);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors().primaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "  YES  ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  });
              // removePool(widget.data["uid"]);
            },
          ),
        ),
      ],
    );
  }
}
