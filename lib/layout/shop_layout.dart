
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../modules/search/search_screen.dart';
import '../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('On The Basket'),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      SearchScreen(),
                    );
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: Material(
            elevation: 50,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),

            child: Container(

              decoration: BoxDecoration(


                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight:Radius.circular(20.0) )
              ,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                  ),
                ],
              ),


              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SalomonBottomBar(
                  onTap: (index) {
                    cubit.changeBottom(index);
                  },
                  currentIndex: cubit.currentIndex,
                  items:  [
                    SalomonBottomBarItem(
                      icon: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                    SalomonBottomBarItem(icon: Icon(Icons.apps), title: Text('Categories')),
                    SalomonBottomBarItem(
                        icon: Icon(Icons.favorite), title: Text('Favorite')),
                    SalomonBottomBarItem(
                        icon: Icon(Icons.settings), title: Text('Settings')),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
