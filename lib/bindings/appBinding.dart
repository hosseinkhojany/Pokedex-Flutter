import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:untitled1/controller/loginController.dart';
import 'package:untitled1/controller/pokemonContoller.dart';
import 'package:untitled1/utils/consts.dart';

import '../data/config/logging_interceptor.dart';
import '../data/datasource/pokemonDs.dart';
import '../data/repository/loginRepo.dart';
import '../data/repository/pokemonRepo.dart';

class AppBinding implements Bindings {

  Dio _dio() {
    final options = BaseOptions(
      baseUrl: BASE_API_URL,
      connectTimeout: AppLimit.DIO_TIME_OUT,
      receiveTimeout: AppLimit.DIO_TIME_OUT,
      sendTimeout: AppLimit.DIO_TIME_OUT,
    );

    var dio = Dio(options);
    dio.interceptors.add(LoggingInterceptor());
    return dio;
  }

  @override
  void dependencies() {
    initThings();
    initControllers();
  }
  void initThings(){
    Get.lazyPut(_dio,);
  }
  void initControllers(){
    Get.lazyPut(() => LoginController(LoginRepository()));
    Get.lazyPut(() => PokemonController(PokemonRepository(PokemonDs(Get.find()))));
  }
}
