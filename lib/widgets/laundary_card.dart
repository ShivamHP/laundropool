import 'package:flutter/material.dart';
import 'package:laundropool/values/colors.dart';
import 'package:laundropool/widgets/beautiful_card.dart';

import 'bottom_dialog_sheet.dart';

class LaundaryCard extends StatefulWidget {
  Map<String, dynamic> data;

  LaundaryCard({Key? key, required this.data}) : super(key: key);

  @override
  State<LaundaryCard> createState() => _LaundaryCardState();
}

class _LaundaryCardState extends State<LaundaryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            // crossAxisAlignment: CrossAxisAlignment.baseline,
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
    );
  }
}
