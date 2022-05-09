
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'models/search_model/cubit/cubit.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/register/cubit/cubit.dart';
import 'modules/shop_login/cubit/cubit.dart';
import 'modules/shop_login/shop_login_screen.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      DioHelper.init();
      WidgetsFlutterBinding.ensureInitialized();
      await CacheHelper.init();
      var isDark = CacheHelper.getBooleanData(key: 'isDark') ?? false;

      token = CacheHelper.getStringData(key: 'token');
      print(token.toString());

      var onBoarding = CacheHelper.getBooleanData(key: 'onBoarding');
      Widget? widget;

      if (onBoarding != null) {
        if (token != null) {
          widget = ShopLayout();
        } else {
          widget = ShopLoginScreen();
        }
      } else {
        widget = OnBoardingScreen();
      }

      runApp(MyApp(isDark, widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  late final bool isDark;
  late final Widget startWidget;



  MyApp(this.isDark, this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
            create: (BuildContext context) => ShopRegisterCubit()),
        BlocProvider(
            create: (BuildContext context) => SearchCubit()),
        BlocProvider(create: (BuildContext context) => ShopLoginCubit()),
        BlocProvider(
            create: (BuildContext context) =>
                AppCubit()..changeAppMode(fromShared: isDark)),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: darkTheme,
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );

  }
}
