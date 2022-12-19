import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/caregories_model.dart';
import 'package:shopapp/models/home_model_response.dart';
import 'package:shopapp/modules/components/components.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../shared/cubit/shop_app_cubit/shop_app_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // return ShopAppCubit.getobject(context).shopHomeResponse == null
        //     ? Container(
        //         child: null,
        //       )
        //     : productBuilder(ShopAppCubit.getobject(context).shopHomeResponse,
        //         ShopAppCubit.getobject(context).shopCategoriesResponse);
        return ConditionalBuilder(
            condition: state is ShopFavouritesPostSuccessState == true &&
                ShopAppCubit.getobject(context).shopHomeResponse.data == null &&
                ShopAppCubit.getobject(context).shopCategoriesResponse.data ==
                    null,
            builder: (context) => Center(child: CircularProgressIndicator()),
            fallback: (context) => productBuilder(
                ShopAppCubit.getobject(context).shopHomeResponse,
                ShopAppCubit.getobject(context).shopCategoriesResponse,
                context));
      },
    );
  }

  Widget productBuilder(ShopHomeResponse homeModel,
          ShopCategoriesResponse categoriesModel, context) =>
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: CarouselSlider(
                items: homeModel.data?.banners!
                            .map((e) => Image(image: NetworkImage(e.image!))) !=
                        null
                    ? homeModel.data?.banners!
                        .map((e) => Image(
                              image: NetworkImage(e.image!),
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ))
                        .toList()
                    : [Center(child: CircularProgressIndicator())],
                options: CarouselOptions(
                    // height: 200,
                    autoPlay: true,
                    initialPage: 0,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayInterval: Duration(seconds: 3),
                    scrollDirection: Axis.horizontal),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 101,
              child: categoriesModel.data?.data?.length != null
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          categoriesModel.data?.data?[index].image != null
                              ? CategoriesContainer(
                                  url: categoriesModel.data?.data?[index].image,
                                  name: categoriesModel.data?.data?[index].name)
                              : Center(child: CircularProgressIndicator()),
                      itemCount: categoriesModel.data!.data!.length,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 4,
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: homeModel.data?.products?.length != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 8,
                          children: List.generate(
                            homeModel.data!.products!.length,
                            (index) => ProduceContainer(
                                id: homeModel.data!.products![index].id!,
                                isDiscount:
                                    homeModel.data!.products![index].discount !=
                                        0,
                                name: homeModel.data!.products![index].name!,
                                url: homeModel.data!.products![index].image!,
                                oldprice: homeModel
                                            .data!.products![index].discount !=
                                        0
                                    ? homeModel.data!.products![index].oldPrice
                                        .toString()
                                    : '',
                                price: homeModel.data!.products![index].price
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
}
