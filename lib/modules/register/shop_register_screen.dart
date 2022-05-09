import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../shop_login/cubit/cubit.dart';
import '../shop_login/cubit/states.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {
  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var registerCubit = ShopRegisterCubit.get(context);

    return BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: defaultColor),
                      ),
                      Text(
                        'Register now to browse our exclusive offer',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.deepPurpleAccent),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return ' please enter your name';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person),
                      SizedBox(
                        height: 15.0,
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
                        isPassword: registerCubit.isPassword,
                        onSubmit: (value) {
                          if (globalKey.currentState!.validate()) {
                            ShopRegisterCubit.get(context).userRegister(
                                email: emailAddressController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                name: nameController.text);
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
                        suffix: registerCubit.suffix,
                        suffixPressed: () {
                          registerCubit.changePasswordVisibility();
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return ' please enter your phone';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone),
                      SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilderRec(
                        builder: (BuildContext context) => defaultButton(
                            function: () {
                              if (globalKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailAddressController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'Register',
                            isUpperCase: true,
                            background: defaultColor),
                        condition: state is! ShopRegisterLoadingState ,
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
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


        if (state is ShopRegisterSuccessState) {
          if (state.registerModel.status!) {
            print(state.registerModel.data!.token);
            print(state.registerModel.message);
            CacheHelper.saveData(
                key: 'token', value: state.registerModel.data!.token);
            token = state.registerModel.data!.token;
            cubit.getUserData();
            cubit.getFavoritesData();
            cubit.getCategoriesData();
            cubit.getHomeData();
            cubit.currentIndex = 0;

            navigateAndFinish(context, ShopLayout());
          } else {
            print(state.registerModel.message);
            showToast(
                message: state.registerModel.message!, state: ToastStates.ERROR);
          }
        }
      },
    );
  }
}
