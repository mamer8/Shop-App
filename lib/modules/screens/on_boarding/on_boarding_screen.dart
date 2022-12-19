import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/components/constans.dart';
import 'package:shopapp/shared/cubit/login_cubit/shop_app_login_cubit.dart';
import 'package:shopapp/shared/cubit/login_cubit/shop_app_login_state.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../login/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  bool isLast = false;
  List<Widget> pages = [
    buildPageViewItem(image: 'images/shop.png', body: 'body1', title: 'title1'),
    buildPageViewItem(image: 'images/shop.png', body: 'body2', title: 'title2'),
    buildPageViewItem(image: 'images/shop.png', body: 'body3', title: 'title3'),
  ];
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) NavigateAndReplase(context, LoginPage());
    }).catchError((error) {
      print('error${error.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    submit();
                  },
                  child: Text('SKIP'))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => pages[index],
                    itemCount: pages.length,
                    onPageChanged: (int index) {
                      if (index == pages.length - 1) {
                        setState(() {
                          isLast = true;
                          print('isLast');
                        });
                      } else {
                        setState(() {
                          isLast = false;
                          print('notLas');
                        });
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                        controller: pageController,
                        // PageController
                        count: pages.length,
                        effect: JumpingDotEffect(activeDotColor: Colors.green),
                        // your preferred effect
                        onDotClicked: (index) {}),
                    Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        print(isLast);
                        if (isLast) {
                          submit();
                        } else {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 750),
                              curve: Curves.fastLinearToSlowEaseIn);
                        }
                      },
                      backgroundColor: Colors.green,
                      child: isLast
                          ? Icon(
                              Icons.check_sharp,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildPageViewItem({
  required String image,
  required String title,
  required String body,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset(image)),
        SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          body,
          style: TextStyle(fontSize: 22),
        )
      ],
    );
