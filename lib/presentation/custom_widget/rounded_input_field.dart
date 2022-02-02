import 'package:flutter/material.dart';
import 'package:untitled1/presentation/custom_widget/text_field_container.dart';
import 'package:untitled1/utils/consts.dart';


class RoundedInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final IconData? icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField(
      {
        Key? key,
        required this.hintText,
        this.controller = null,
        this.icon,
        required this.onChanged
      }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
