import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;

  const AlreadyHaveAnAccountCheck({Key? key, required this.login, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final themeData = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: TextStyle(color:themeData.colorScheme.surface,),
        ),
        GestureDetector(
          onTap:() => {
            if(press != null){
               press.call()
            }
          },
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(
              color: themeData.colorScheme.surface,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
