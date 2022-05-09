import 'package:conditional_builder_rec/conditional_builder_rec.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {
        if (state is ShopSuccessGetUserDataState) {
          nameController.text = state.userModel.data!.name!;
          emailController.text = state.userModel.data!.email!;
          phoneController.text = state.userModel.data!.phone!;
        }
      },
      builder: (BuildContext context, Object? state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilderRec(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [

                 if(state is ShopLoadingUpdateUserState)
                   LinearProgressIndicator(),
                  SizedBox(height: 20,),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty)
                          return 'name must not be empty';
                        else
                          return null;
                      },
                      label: 'Name',
                      prefix: Icons.person),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty)
                          return 'email must not be empty';
                        else
                          return null;
                      },
                      label: "Email",
                      prefix: Icons.email),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty)
                          return 'phone must not be empty';
                        else
                          return null;
                      },
                      label: 'phone',
                      prefix: Icons.phone),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }
                      },
                      text: 'UPDATE'),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'LOGUOT'),
                ],
              ),
            ),
          ),
          condition: ShopCubit.get(context).userModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
