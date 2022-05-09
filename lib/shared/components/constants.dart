

import '../../modules/shop_login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context){
      CacheHelper.deleteData(key: 'token')!.then((value) {
        if (value) {
          navigateAndFinish(context, ShopLoginScreen());
        }
      });
}

String? token ;