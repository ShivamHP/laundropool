import 'package:flutter/material.dart';

class BeautifulCard extends StatelessWidget {
  String content;
  Color color;

  BeautifulCard({Key? key, required this.content, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      constraints: const BoxConstraints(
        minHeight: 36,
        minWidth: 80,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.all(color: color),
      ),
      child: Center(
        child: Text(
          content,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ),
    );
  }
}
