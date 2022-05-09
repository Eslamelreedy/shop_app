import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/cubit/cubit.dart';
import '../styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  required Function function,
  required String text,
  double radius = 5.0,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
        ),
        textColor: Colors.white,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  Function? suffixPressed,
  required FormFieldValidator<String> validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  bool isReadOnly = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (String? s) {
        onSubmit!(s);
      },
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: () {
                  suffixPressed!();
                },
              )
            : null,
      ),
      readOnly: isReadOnly,
    );


Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );


void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

void showToast({required String message, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color? chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildListProduct(data, context, {bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Container(

    height: 120,

    decoration: BoxDecoration(

      borderRadius: BorderRadius.circular(5.0),

      color: Colors.white,

      boxShadow: [

      BoxShadow(

      color: Colors.grey,

      offset: Offset(0.0, 1.0), //(x,y)

      blurRadius: 1.0,

    ),

    ],

  ),



    child: Padding(

      padding: const EdgeInsets.all(8.0),

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Stack(

            alignment: AlignmentDirectional.bottomStart,

            children: [

              Image(

                image: NetworkImage(data.image!),

                width: 120,

                // fit: BoxFit.cover,

                height: 120,

              ),

              if (data.discount != 0&& isOldPrice)

                Container(

                  color: Colors.red,

                  padding: EdgeInsets.symmetric(horizontal: 5.0),

                  child: Text(

                    'DISCOUNT',

                    style: TextStyle(

                      fontSize: 8.0,

                      color: Colors.white,

                    ),

                  ),

                ),

            ],

          ),

          SizedBox(

            width: 20,

          ),

          Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(

                  data.name!,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(fontSize: 14.0, height: 1.2),

                ),

                Spacer(),

                Row(

                  children: [

                    Text(

                      data.price.toString(),

                      style: TextStyle(

                        fontSize: 12.0,

                        color: defaultColor,

                      ),

                    ),

                    SizedBox(

                      width: 5.0,

                    ),

                    if (data.discount != 0&&isOldPrice)

                      Text(

                        data.oldPrice.toString(),

                        style: TextStyle(

                          fontSize: 10.0,

                          color: Colors.grey,

                          decoration: TextDecoration.lineThrough,

                        ),

                      ),

                    Spacer(),

                    IconButton(

                        onPressed: () {

                          ShopCubit.get(context).changeFavorites(data.id!);

                        },

                        icon: CircleAvatar(

                            radius: 15,

                            backgroundColor:

                                ShopCubit.get(context).favorites[data.id]!

                                    ? defaultColor

                                    : Colors.grey,

                            child: Icon(

                              Icons.favorite_border,

                              color: Colors.white,

                            ))),

                  ],

                ),

              ],

            ),

          ),

        ],

      ),

    ),

  ),
);
