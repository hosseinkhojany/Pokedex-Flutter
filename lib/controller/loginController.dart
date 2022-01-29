import 'package:get/get.dart';
import 'package:untitled1/data/repository/loginRepo.dart';

class LoginController extends GetxController {

  final LoginRepository _loginRepository;

  LoginController(this._loginRepository);

  RxBool isEmailValid = false.obs;

  void updateEmailValidateState(String text) {
    isEmailValid.value = text.endsWith("@gmail.com");
    update();
  }
}
