import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/components/constans.dart';
import 'package:shopapp/modules/screens/app_cycle/search/search_screen.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_cubit.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_state.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('My Shop'),
            titleSpacing: 20,
            actions: [
              IconButton(
                  onPressed: () {
                    NavigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              // IconButton(
              //     onPressed: () {
              //       NewsCubit.get(context).changeThemeMode();
              //     },
              //     icon: Icon(Icons.brightness_2_outlined))
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
