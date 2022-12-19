import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/caregories_model.dart';
import 'package:shopapp/models/favourites/favourites_get_model.dart';
import 'package:shopapp/models/favourites/favourites_post_model.dart';
import 'package:shopapp/models/home_model_response.dart';
import 'package:shopapp/models/login_response.dart';
import 'package:shopapp/models/search_model_response.dart';
import 'package:shopapp/modules/components/constans.dart';
import 'package:shopapp/modules/screens/app_cycle/category/category_screen.dart';
import 'package:shopapp/modules/screens/app_cycle/favourite/favourite_screen.dart';
import 'package:shopapp/modules/screens/app_cycle/product/product_screen.dart';
import 'package:shopapp/modules/screens/app_cycle/setting/setting_screen.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_state.dart';

import 'package:shopapp/shared/network/end_points.dart';

import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(InitialState());

  static ShopAppCubit getobject(context) => BlocProvider.of(context);

  static ShopAppCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined), label: 'Category'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'Favourite'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
  ];

  List<Widget> screens = [
    const ProductScreen(),
    const CategoryScreen(),
    const FavouriteScreen(),
    SettingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentindex = index;
    if (index == 1) const CategoryScreen();
    if (index == 2) const FavouriteScreen();
    if (index == 3) SettingScreen();
    emit(ShopBottomNavState());
  }

/////////////////////HomeProducts
  Map<int?, bool?> favourites = {};
  ShopHomeResponse shopHomeResponse = ShopHomeResponse();

  void getHomeDate() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      shopHomeResponse = ShopHomeResponse.fromJson(value.data);

      shopHomeResponse.data!.products?.forEach((element) {
        favourites.addAll({element.id: element.inFavorites});
      });
      print(favourites);
      // print('fdfdfdfssfssfdss $token');
      emit(ShopHomeSuccessState());
      print(shopHomeResponse.message);
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeErrorState(error.toString()));
    });
  }

///////// CATEGORIES
  ShopCategoriesResponse shopCategoriesResponse = ShopCategoriesResponse();

  void getCategoriesDate() {
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      shopCategoriesResponse = ShopCategoriesResponse.fromJson(value.data);
      print('fdddddddddddddfdfdfssfssfdss $token');
      emit(ShopCategoriesSuccessState());
      print(shopHomeResponse.message);
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorState(error.toString()));
    });
  }

/////////////// SEARCH
  ShopSearchResponse searchResponse = ShopSearchResponse();

  void search({required String text}) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {'text': text})
        .then((value) {
      emit(ShopSearchSuccessState());
      searchResponse = ShopSearchResponse.fromJson(value.data);
      print(searchResponse.data!.data![0].name);
    }).catchError((e) {
      emit(ShopSearchErrorState(e.toString()));
      print(e.toString());
    });
  }

  ///////////////////////////// FAVOURITES POST
  ShopFavouritesPostResponse shopFavouritesResponse =
      ShopFavouritesPostResponse();

  void postFavourites(int productId) {
    emit(ShopFavouritesPostLoadingState());
    favourites[productId] = !favourites[productId]!;
    emit(ShopFavouritesPostSuccessState());
    DioHelper.postData(
            url: FAVOURITES, data: {"product_id": productId}, token: token)
        .then((value) {
      shopFavouritesResponse = ShopFavouritesPostResponse.fromJson(value.data);
      if (!shopFavouritesResponse.status!) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavourites();
      }
      emit(ShopFavouritesPostSuccessState());
    }).catchError((error) {
      emit(ShopFavouritesPostErrorState(error.toString()));
    });
  }

  //////////////////////////// FVOURITE GET

  ShopFavouritesGetResponse shopFavouritesGetResponse =
      ShopFavouritesGetResponse();

  void getFavourites() {
    emit(ShopFavouritesGetLoadingState());

    DioHelper.getData(url: FAVOURITES, token: token).then((value) {
      shopFavouritesGetResponse =
          ShopFavouritesGetResponse.fromJson(value.data);
      emit(ShopFavouritesGetSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopFavouritesGetErrorState(error.toString()));
    });
  }

  ///////GET PROFILE

  ShopLoginResponse userModelResponse = ShopLoginResponse();

  void getUser() {
    emit(ShopUserProfileLoadingState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModelResponse = ShopLoginResponse.fromJson(value.data);
      emit(ShopUserProfileSuccessState());
      print(userModelResponse.data!.name);
    }).catchError((error) {
      print(error.toString());
      emit(ShopUserProfileErrorState(error.toString()));
    });
  }

///////// UPDATE USER

  void updateUser({
    required String email,
    required String name,
    required String phone,
  }) {
    emit(ShopUserUpdateProfileLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'email': email,
      'name': name,
      'phone': phone,
    }).then((value) {
      emit(ShopUserUpdateProfileSuccessState());
    }).catchError((error) {
      emit(ShopUserUpdateProfileErrorState(error.toString()));
    });
  }
}
