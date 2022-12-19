import 'package:shopapp/models/login_response.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginShowPasswordState extends ShopLoginStates {
  bool ispass;
  ShopLoginShowPasswordState({required this.ispass});
}

class ShopOnBoardingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  ShopLoginResponse loginResponse;
  ShopLoginSuccessState(this.loginResponse);
}

class ShopLoginErrorState extends ShopLoginStates {
  final dynamic error;
  ShopLoginErrorState(this.error);
}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopRegisterSuccessState extends ShopLoginStates {
  ShopLoginResponse registerResponse;
  ShopRegisterSuccessState(this.registerResponse);
}

class ShopRegisterErrorState extends ShopLoginStates {
  final dynamic error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterLoadingState extends ShopLoginStates {}
