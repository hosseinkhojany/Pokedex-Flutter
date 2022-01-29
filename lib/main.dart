import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/appRouter.dart';
import 'package:untitled1/utils/sharedStore.dart';

import 'bindings/appBinding.dart';


void main() {

  SharedStore.init();

  runApp(MyApp(
    router: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {

  final AppRouter router;
  const MyApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: _buildStack()
      initialRoute: SPLASH_ROUTE,
      initialBinding: AppBinding(),
      onGenerateRoute: router.generateRoute,
      // getPages: routes,
    );
  }



}
