import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:laundropool/models/pool_model.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../screens/home_screen.dart';
import '../values/colors.dart';

class RequestPoolDialog extends StatefulWidget {
  Map<String, dynamic> data;

  RequestPoolDialog({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<RequestPoolDialog> createState() => _RequestPoolDialogState();
}

class _RequestPoolDialogState extends State<RequestPoolDialog> {
  double _weightSliderValue = 0;
  double _price = 0;
  ConfettiController _confettiController = ConfettiController();
  var db = FirebaseFirestore.instance;

  addUserToPool(String uid, String poolId, int space_required) async {
    List<dynamic> poolers = [];
    int available_space = 0;
    await db.collection("pools").doc(poolId).get().then((value) => {
          poolers = value["people"],
          available_space = value["available_space"]
        });
    poolers.add(uid);
    await db.collection("pools").doc(poolId).update({
      "people": poolers,
      "available_space": available_space - space_required,
    });
  }

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      title: const Text(
        "Request pool",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3.6,
                    width: double.infinity,
                    // color: Colors.grey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.data["available_space"] != 0
                            ? const Text(
                                "Select the amount of weight:",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              )
                            : Container(),
                        widget.data["available_space"] == 0
                            ? const Text(
                                "Sorry, no space left!\nPlease find another pool",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : Row(
                                children: [
                                  Slider(
                                      activeColor: AppColors().primaryColor,
                                      inactiveColor: Colors.grey.shade200,
                                      label: _weightSliderValue.toString()[0],
                                      value: _weightSliderValue,
                                      max: widget.data["available_space"]
                                          .toDouble(),
                                      min: 0,
                                      divisions: widget.data["available_space"],
                                      onChanged: (double pos) {
                                        if (pos != 0) {
                                          setState(
                                            () {
                                              _weightSliderValue = pos;
                                              _price = _weightSliderValue *
                                                  widget.data["price"] /
                                                  widget.data["total_space"];
                                            },
                                          );
                                        }
                                      }),
                                  Text(
                                    "${_weightSliderValue.toString()[0]} KG",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 32),
                        widget.data["available_space"] != 0
                            ? Text(
                                "₹ ${_price.ceil().toInt()}",
                                style: const TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 95, 95, 95)),
                              )
                            : Container(),
                        const Spacer(),
                        GestureDetector(
                          onTap: _weightSliderValue == 0
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Weight cannot be 0 kg."),
                                    ),
                                  );
                                }
                              : () async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Completed request!"),
                                    ),
                                  );
                                  _confettiController.play();
                                  await addUserToPool(
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .getUser
                                        .uid,
                                    widget.data["uid"],
                                    _weightSliderValue.toInt(),
                                  );
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: _weightSliderValue == 0
                                    ? Colors.grey
                                    : AppColors().primaryColor,
                              ),
                              child: const Center(
                                child: Text(
                                  "REQUEST",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi * 1.5,
                numberOfParticles: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
