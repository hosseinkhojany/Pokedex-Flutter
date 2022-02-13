import 'package:flutter/material.dart';
import 'package:untitled1/presentation/custom_widget/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final IconData? icon;
  final ValueChanged<String> onChanged;
  final TextInputType inputType;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.controller = null,
    this.icon,
    required this.onChanged,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final themeData = Theme.of(context);
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: themeData.colorScheme.surface,
        keyboardType: inputType,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: themeData.colorScheme.surface,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
