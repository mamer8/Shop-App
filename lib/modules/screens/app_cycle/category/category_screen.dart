import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/caregories_model.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_cubit.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_cubit.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_state.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition:
                ShopAppCubit.getobject(context).shopCategoriesResponse.data !=
                    null,
            builder: (context) => CategiriesBuilder(
                ShopAppCubit.getobject(context).shopCategoriesResponse),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget CategiriesBuilder(ShopCategoriesResponse shopCategoriesModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
            itemBuilder: (context, index) => buildCategories(
                name: shopCategoriesModel.data!.data![index]!.name,
                url: shopCategoriesModel.data!.data![index]!.image),
            separatorBuilder: (context, index) => Divider(),
            itemCount: 5),
      );
  Widget buildCategories({
    String? url,
    String? name,
  }) =>
      Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image(
              image: NetworkImage(url!),
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            name!,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 30),
        ],
      );
}
