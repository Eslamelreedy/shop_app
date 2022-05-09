
import '../../models/change_favorites_model/change_favorites_model.dart';
import '../../models/login_model/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavSate extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {
  final String error;

  ShopErrorCategoriesDataState(this.error);
}

class ShopSuccessChangeFavoritesDataState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesDataState(this.model);
}

class ShopChangeFavoritesDataState extends ShopStates {}

class ShopErrorChangeFavoritesDataState extends ShopStates {
  final String error;

  ShopErrorChangeFavoritesDataState(this.error);
}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {
  final String error;

  ShopErrorGetFavoritesState(this.error);
}
class ShopSuccessGetUserDataState extends ShopStates {
  ShopLoginModel userModel;

  ShopSuccessGetUserDataState(this.userModel);
}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopErrorGetUserDataState extends ShopStates {
  final String error;

  ShopErrorGetUserDataState(this.error);
}

class ShopSuccessUpdateUserState extends ShopStates {
  ShopLoginModel userModel;

  ShopSuccessUpdateUserState(this.userModel);
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopErrorUpdateUserState extends ShopStates {
  final String error;

  ShopErrorUpdateUserState(this.error);
}

