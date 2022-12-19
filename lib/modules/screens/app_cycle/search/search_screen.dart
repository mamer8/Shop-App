import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopapp/modules/components/components.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_cubit.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_state.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                defaultTextFeild(
                  onChanged: (value) {
                    // ShopAppCubit.get(context).search(text: value!);
                  },
                  prefix: Icons.search,
                  isPassword: false,
                  onSubmitted: (value) {
                    ShopAppCubit.get(context).search(text: value!);
                  },
                  label: 'Search',
                  controller: searchController,
                  type: TextInputType.text,
                ),
                if (state is ShopSearchLoadingState) LinearProgressIndicator(),
                if (state is ShopSearchSuccessState)
                  Container(
                    child: ShopAppCubit.getobject(context)
                                .searchResponse
                                .data
                                ?.data
                                ?.length !=
                            null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: StaggeredGrid.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 8,
                                children: List.generate(
                                  ShopAppCubit.getobject(context)
                                      .searchResponse
                                      .data!
                                      .data!
                                      .length,
                                  (index) => ProduceContainer(
                                      id: ShopAppCubit.getobject(context)
                                          .searchResponse
                                          .data!
                                          .data![index]
                                          .id!,
                                      name: ShopAppCubit.getobject(context)
                                          .searchResponse
                                          .data!
                                          .data![index]
                                          .name!,
                                      url: ShopAppCubit.getobject(context)
                                          .searchResponse
                                          .data!
                                          .data![index]
                                          .image!,
                                      price: ShopAppCubit.getobject(context)
                                          .searchResponse
                                          .data!
                                          .data![index]
                                          .price
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
          ),
        );
      },
    );
  }

  Widget ProduceContainer(
          {required String url,
          required String name,
          required String price,
          required int id,
          context}) =>
      Card(
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: NetworkImage(url)),
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
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      );
}
