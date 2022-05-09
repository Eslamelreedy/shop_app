import 'package:conditional_builder_rec/conditional_builder_rec.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../register/shop_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      builder: (BuildContext context, state) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.bottom]);

        var loginCubit = ShopLoginCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Image.asset(
                        'assets/images/online.png',
                        height: 160,
                        width: 160,
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        'login now to browse our exclusive offer',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: emailAddressController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return ' please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        isPassword: loginCubit.isPassword,
                        onSubmit: (value) {
                          if (globalKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                                email: emailAddressController.text,
                                password: passwordController.text);
                          }
                        },
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return ' password is too short';
                          }
                        },
                        label: 'Password',
                        prefix: Icons.lock_outline,
                        suffix: loginCubit.suffix,
                        suffixPressed: () {
                          loginCubit.changePasswordVisibility();
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilderRec(
                        builder: (BuildContext context) => defaultButton(
                            function: () {
                              if (globalKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailAddressController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'Login',
                            isUpperCase: true,
                            background: defaultColor),
                        condition: state is! ShopLoginLoadingState,
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account ?'),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, ShopRegisterScreen());
                            },
                            child: Text(
                              'Register Now'.toUpperCase(),
                              style: TextStyle(color: defaultColor),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);
        if (state is ShopLoginSuccessState) {
          if (state.loginModel.status!) {
            print(state.loginModel.data!.token);
            print(state.loginModel.message);
            CacheHelper.saveData(
                key: 'token', value: state.loginModel.data!.token);
            token = state.loginModel.data!.token;
            cubit.getUserData();
            cubit.getFavoritesData();
            cubit.getCategoriesData();
            cubit.getHomeData();
            cubit.currentIndex = 0;

            navigateAndFinish(context, ShopLayout());
          } else {
            print(state.loginModel.message);
            showToast(
                message: state.loginModel.message!, state: ToastStates.ERROR);
          }
        }
      },
    );
  }
}
