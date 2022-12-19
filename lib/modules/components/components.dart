import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/shared/cubit/shop_app_cubit/shop_app_cubit.dart';

Widget defaultButton(
        {double button_width = double.maxFinite,
        Color button_color = Colors.lightBlueAccent,
        double button_height = 40,
        double radius = 10,
        required VoidCallback button_onPressed,
        required String text}) =>
    Container(
      width: button_width,
      height: button_height,
      decoration: BoxDecoration(
          color: button_color,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: MaterialButton(
        onPressed: button_onPressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );

Widget defaultTextFeild({
  ValueChanged<String?>? onSubmitted,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  VoidCallback? onpressedicon,
  required TextEditingController controller,
  required TextInputType type,
  String? Function(String?)? validator,
  VoidCallback? onTap,
  VoidCallback? onPress,
  ValueChanged<String?>? onChanged,
  String? initialValue,
  bool keyboardeanabled = true,
}) =>
    TextFormField(
        initialValue: initialValue,
        controller: controller,
        onTap: onTap,
        enabled: keyboardeanabled,
        onChanged: onChanged,
        validator: validator,
        obscureText: isPassword ? true : false,
        onFieldSubmitted: onSubmitted,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: onpressedicon,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
        ));

Widget TheText({required String text}) => Text(
      text,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );

void navigateTo() {}

ShowToast({required String msg, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      // gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 4,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { Success, Error, Warning }

Color toastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.Success:
      color = Colors.green;
      break;
    case ToastStates.Error:
      color = Colors.red;
      break;
    case ToastStates.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}

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
Widget CategoriesContainer({
  String? url,
  String? name,
}) =>
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Image(
          image: NetworkImage(url!),
          fit: BoxFit.cover,
          height: 100,
          width: 100,
        ),
        Container(
          child: Text(
            name!,
            style:
                TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis),
          ),
          width: 100,
          height: 20,
          color: Colors.black.withOpacity(.7),
          alignment: Alignment.center,
        )
      ]),
    );
