import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/modules/components/components.dart';
import 'package:shopapp/modules/components/constans.dart';
import 'package:shopapp/modules/screens/app_cycle/home_screen.dart';
import 'package:shopapp/modules/screens/login/register_screen.dart';
import 'package:shopapp/shared/cubit/login_cubit/shop_app_login_cubit.dart';
import 'package:shopapp/shared/cubit/login_cubit/shop_app_login_state.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

class LoginPage extends StatelessWidget {
  var email_controller = TextEditingController();

  var pass_controller = TextEditingController();

  GlobalKey<FormState> form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = ShopLoginCubit.getobject(context);
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          if (state.loginResponse.status == true) {
            ShowToast(
                msg: state.loginResponse.message.toString(),
                state: ToastStates.Success);
            print(state.loginResponse.data!.token);

            CacheHelper.saveData(
                    key: 'token', value: state.loginResponse.data!.token)
                .then((value) {
              token = state.loginResponse.data!.token;
            });
            NavigateAndReplase(context, HomeLayout());
          } else {
            ShowToast(
                msg: state.loginResponse.message.toString(),
                state: ToastStates.Error);
          }
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: form_key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TheText(text: 'Login'),
                    SizedBox(
                      height: 30,
                    ),
                    defaultTextFeild(
                      prefix: Icons.email,
                      isPassword: false,
                      onSubmitted: (value) {
                        print(value);
                      },
                      label: 'Email Adress',
                      controller: email_controller,
                      type: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty ? 'Email cannot be blank' : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextFeild(
                      prefix: Icons.lock,
                      suffix: cubit.isPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      isPassword: cubit.isPassword,
                      onpressedicon: () {
                        cubit.toglePassword();
                      },
                      onSubmitted: (value) {
                        print(value);
                      },
                      label: 'Password',
                      controller: pass_controller,
                      type: TextInputType.visiblePassword,
                      validator: (value) =>
                          value!.isEmpty ? 'Password cannot be blank' : null,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ConditionalBuilder(
                        condition: state != ShopLoginLoadingState(),
                        builder: (context) => defaultButton(
                            button_onPressed: () {
                              if (form_key.currentState!.validate()) {
                                cubit.userLogin(
                                    email: email_controller.text,
                                    password: pass_controller.text);
                                print('Form is valid');
                              } else {
                                print('Form is Not valid');
                              }
                            },
                            text: 'login'),
                        fallback: (context) => CircularProgressIndicator(
                              color: Colors.green,
                            )),
                    Row(
                      children: [
                        Text('Don\'t have an account?'),
                        TextButton(
                            onPressed: () {
                              NavigateTo(context, RegisterPage());
                            },
                            child: Text('Register now'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
