import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/appRouter.dart';
import 'package:untitled1/controller/loginController.dart';
import 'package:untitled1/data/datasource/local/sharedStore.dart';
import 'package:untitled1/presentation/custom_widget/rounded_input_field.dart';

class SignUpScreen extends StatelessWidget {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool useVerticalLayout = screenSize.width < screenSize.height;
    bool hideDetailPanel = screenSize.shortestSide < 250;
    return Scaffold(
      body: Flex(
          direction: useVerticalLayout ? Axis.vertical : Axis.horizontal,
          children: [
            if (hideDetailPanel == false) ...[
              Flexible(
                  child: Container(
                alignment: Alignment.center,
                color: Color(0xffE0FBFC),
                child: Text(
                  "LOGIN VIEW\nBRANDING",
                  style: useVerticalLayout
                      ? TextStyle(fontSize: 32)
                      : TextStyle(fontSize: 64),
                  textAlign: TextAlign.center,
                ),
              )),
            ],
            Flexible(
                child: GetBuilder<LoginController>(
                    builder: (controller) => Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 450),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    RoundedInputField(
                                      controller: emailController,
                                      hintText: "Enter valid email...",
                                      inputType: TextInputType.emailAddress,
                                      icon: !controller.isEmailValid.value
                                          ? Icons.error
                                          : Icons.email,
                                      onChanged: (text) => {
                                        controller
                                            .updateEmailValidateState(text)
                                      },
                                    ),
                                    SizedBox(height: 16),
                                    RoundedInputField(
                                      hintText: "Enter password...",
                                      icon: Icons.password_rounded,
                                      inputType: TextInputType.text,
                                      onChanged: (text) {},
                                    ),
                                    SizedBox(height: 50),
                                    OutlinedButton(
                                      onPressed: () {
                                        if (controller.isEmailValid.value) {
                                          SharedStore.setUserToken(
                                              emailController.text);
                                          Navigator.pushReplacementNamed(
                                              context, POKEMON_LIST_ROUTE);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                            "Email not valid!",
                                            textAlign: TextAlign.center,
                                          )));
                                        }
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(16.0),
                                        child: Text(
                                          "Log In",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))),
          ]),
    );
  }
}

