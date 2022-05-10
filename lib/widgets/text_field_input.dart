import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldInput extends StatelessWidget {
  Widget svgImage;
  String hintText;
  TextInputType textInputType;
  TextEditingController textEditingController;
  int maxLines = 1;
  TextFieldInput({
    Key? key,
    required this.svgImage,
    required this.hintText,
    required this.textInputType,
    required this.textEditingController,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: textEditingController,
      maxLines: maxLines,
      minLines: 1,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8.0),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: svgImage,
        ),
      ),
      keyboardType: textInputType,
      inputFormatters: (textInputType == TextInputType.number)
          ? [FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true)]
          : [],
    );
  }
}
