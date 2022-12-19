import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/components/constans.dart';
import 'package:shopapp/modules/screens/app_cycle/home_screen.dart';
import 'package:shopapp/modules/screens/login/login_screen.dart';
import 'package:shopapp/modules/screens/on_boarding/on_boarding_screen.dart';
import 'package:shopapp/shared/cubit/bloc_observed.dart';
import 'package:shopapp/shared/cubit/login_cubit/shop_app_login_cubit.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_cubit.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_state.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  dynamic onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null) {
      widget = HomeLayout();
    } else {
      widget = LoginPage();
    }
  } else {
    widget = OnBoardingScreen();
  }

  print(onBoarding);

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  MyApp({this.startWidget});

  final dynamic startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => ShopAppCubit()
              ..getHomeDate()
              ..getFavourites()
              ..getUser()
              ..getCategoriesDate(),
          ),
          BlocProvider(
            create: (BuildContext context) => ShopLoginCubit(),
          )
        ],
        child: BlocConsumer<ShopAppCubit, ShopAppStates>(
          listener: (context, state) {},
          builder: (context, state) => MaterialApp(
              title: 'Flutter Demo',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: startWidget),
        ));
  }
}
