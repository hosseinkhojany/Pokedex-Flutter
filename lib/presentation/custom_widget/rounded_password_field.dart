import 'package:flutter/material.dart';
import 'package:untitled1/presentation/custom_widget/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key? key,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: themeData.colorScheme.surface,
        decoration: InputDecoration(
        hintText: "Password",
        icon: Icon(
        Icons.lock,
        color: themeData.colorScheme.surface,
      ),
      suffixIcon: Icon(
          Icons.visibility,
          color: themeData.colorScheme.surface,
      ),
      border: InputBorder.none,
    ),)
    ,
    );
  }
}
