import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../shared/components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilderRec(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics() ,
              itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product!,context),
              separatorBuilder: (context, index) => SizedBox(height: 2.0,),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length),
          fallback: (context) =>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}
