import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  int currentIndex = 0;

  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);
  ThemeMode appMode = ThemeMode.dark;

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark)!.then((value) {
        emit(AppChangeModeState());
      }).catchError((error) {
        print(error.toString());
      });
    }
  }
}
