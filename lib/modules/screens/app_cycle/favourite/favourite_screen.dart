import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopapp/models/favourites/favourites_get_model.dart';

import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_cubit.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_state.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopFavouritesGetSuccessState) {
          print(ShopAppCubit.getobject(context).favourites);
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: true,
            builder: (context) => productBuilder(
                ShopAppCubit.getobject(context).shopFavouritesGetResponse,
                context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productBuilder(ShopFavouritesGetResponse favouriteModel, context) =>
      SingleChildScrollView(
        child: Column(
          children: [

            Container(
              child: favouriteModel.data?.data?.length != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 8,
                          children: List.generate(
                            favouriteModel.data!.data!.length,
                            (index) => ProduceContainer(
                                id: favouriteModel.data!.data![index].product!.id!,
                                isDiscount: favouriteModel
                                        .data!.data![index].product!.discount !=
                                    0,
                                name: favouriteModel
                                    .data!.data![index].product!.name!,
                                url: favouriteModel
                                    .data!.data![index].product!.image!,
                                oldprice: favouriteModel.data!.data![index]
                                            .product!.discount !=
                                        0
                                    ? favouriteModel
                                        .data!.data![index].product!.oldPrice
                                        .toString()
                                    : '',
                                price: favouriteModel
                                    .data!.data![index].product!.price
                                    .toString(),
                                context: context),
                          ),
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      );
  Widget ProduceContainer(
          {required String url,
          required String name,
          required String price,
          required int id,
          required String oldprice,
          required bool isDiscount,
          context}) =>
      Card(
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: NetworkImage(url)),
              isDiscount
                  ? Container(
                      color: Colors.red,
                      child: Text(' DISCOUNT ! ',
                          style: TextStyle(color: Colors.white)),
                    )
                  : Container(
                      child: null,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              ),
              Text(
                name,
                style: TextStyle(height: 1.2),
              ),
              Row(
                children: [
                  Text(price,
                      style: TextStyle(
                        color: Colors.blue,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    oldprice,
                    style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        ShopAppCubit.get(context).postFavourites(id);
                      },
                      child: ShopAppCubit.get(context).favourites[id]!
                          ? Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                            )),
                ],
              ),
            ],
          ),
        ),
      );
}
