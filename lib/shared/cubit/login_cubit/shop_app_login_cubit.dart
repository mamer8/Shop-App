import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_response.dart';

import 'package:shopapp/shared/cubit/login_cubit/shop_app_login_state.dart';
import 'package:shopapp/shared/network/end_points.dart';

import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit getobject(context) => BlocProvider.of(context);
  late ShopLoginResponse loginResponse;
  bool isPassword = true;

  void toglePassword() {
    isPassword = !isPassword;
    emit(ShopLoginShowPasswordState(ispass: isPassword));
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginResponse = ShopLoginResponse.fromJson(value.data);
      //print(loginResponse.data!.token);
      emit(ShopLoginSuccessState(loginResponse));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  ShopLoginResponse registerModel = ShopLoginResponse();
  void userResgister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'name': name,
      'phone': phone,
      'password': password,
    }).then((value) {
      registerModel = ShopLoginResponse.fromJson(value.data);
      //print(loginResponse.data!.token);
      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
