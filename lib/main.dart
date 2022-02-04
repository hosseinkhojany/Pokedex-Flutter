import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/appRouter.dart';
import 'package:untitled1/data/config/hive/hiveConfig.dart';
import 'package:untitled1/data/datasource/local/sharedStore.dart';

import 'bindings/appBinding.dart';

void main() async {
  await HiveConfig.init();

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
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'ic_font',
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Color(0xff293241),
              fontWeight: FontWeight.bold,
              fontSize: 20,
               fontFamily: 'ic_font'
            )
          ),
          colorScheme: ColorScheme.light(
            primary: Color(0xff293241)
          )),
      // home: _buildStack()
      initialRoute: SPLASH_ROUTE,
      initialBinding: AppBinding(),
      onGenerateRoute: router.generateRoute,
      // getPages: routes,
    );
  }
}
