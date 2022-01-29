import 'package:flutter/material.dart';
import '../../appRouter.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, POKEMON_LIST_ROUTE);
          },
          child: const Text('Launch screen'),
        ),
      ),
    );
  }
}
