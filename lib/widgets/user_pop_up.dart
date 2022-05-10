import 'package:flutter/material.dart';
import 'package:laundropool/values/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPopUp extends StatefulWidget {
  Map<String, dynamic> data;
  UserPopUp({Key? key, required this.data}) : super(key: key);

  @override
  State<UserPopUp> createState() => _UserPopUpState();
}

class _UserPopUpState extends State<UserPopUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 108,
              color: AppColors().primaryColor,
            ),
          ),
          Positioned(
            top: 60,
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.data["photoUrl"]),
              radius: 48,
            ),
          ),
          Positioned(
            top: 160,
            child: Text(
              widget.data["username"].toString().toUpperCase(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            top: 196,
            child: SizedBox(
              width: 300,
              child: GestureDetector(
                onTap: () => launch("tel://${widget.data["phoneNumber"]}"),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${widget.data["hostel"]} | ${widget.data["roomNumber"]}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      color: AppColors().primaryColor,
                      child: SizedBox(
                        height: 48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.call, color: Colors.white),
                            SizedBox(width: 16),
                            Text(
                              "CALL",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
