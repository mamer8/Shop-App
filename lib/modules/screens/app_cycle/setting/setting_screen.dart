import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/components/components.dart';
import 'package:shopapp/modules/components/constans.dart';
import 'package:shopapp/modules/screens/login/login_screen.dart';

import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_cubit.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_state.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  var email_controller = TextEditingController();
  var phone_controller = TextEditingController();

  var name_controller = TextEditingController();

  GlobalKey<FormState> form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopUserUpdateProfileSuccessState) {
          ShopAppCubit.get(context).getUser();
        }
      },
      builder: (context, state) {
        var model = ShopAppCubit.get(context).userModelResponse;
        name_controller.text = model.data!.name!;
        email_controller.text = model.data!.email!;
        phone_controller.text = model.data!.phone!;
        return Scaffold(
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
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextFeild(
                        prefix: Icons.person,
                        isPassword: false,
                        onSubmitted: (value) {
                          print(value);
                        },
                        label: 'Name',
                        controller: name_controller,
                        type: TextInputType.text,
                        validator: (value) =>
                            value!.isEmpty ? 'Name cannot be blank' : null,
                      ),
                      SizedBox(
                        height: 10,
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
                        prefix: Icons.phone,
                        isPassword: false,
                        onSubmitted: (value) {
                          print(value);
                        },
                        label: 'Phone number',
                        controller: phone_controller,
                        type: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? 'Phone cannot be blank' : null,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultButton(
                          button_onPressed: () {
                            if (form_key.currentState!.validate()) {
                              CacheHelper.removeData(key: 'token')
                                  .then((value) {
                                NavigateAndReplase(context, LoginPage());
                              }).catchError((error) {
                                print(error.toString());
                              });
                              print('Form is valid');
                            } else {
                              print('Form is Not valid');
                            }
                          },
                          text: 'LOGOUT'),
                      SizedBox(
                        height: 10,
                      ),
                      ConditionalBuilder(
                          condition:
                              state is! ShopUserUpdateProfileLoadingState,
                          builder: (context) => defaultButton(
                              button_onPressed: () {
                                if (form_key.currentState!.validate()) {
                                  ShopAppCubit.getobject(context).updateUser(
                                      name: name_controller.text,
                                      email: email_controller.text,
                                      phone: phone_controller.text);
                                  //ShopAppCubit.getobject(context).getUser();
                                  print('Form is valid');
                                } else {
                                  print('Form is Not valid');
                                }
                              },
                              text: 'UPDATE'),
                          fallback: (context) => Center(
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                              )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
