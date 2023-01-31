import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopCubitInitial extends ShopStates {}

class ShopBottomNavBarState extends ShopStates {}

class ShopLoadingHomeState extends ShopStates {}

class ShopSuccessHomeState extends ShopStates {}

class ShopErrorHomeState extends ShopStates {}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesIConState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopLoadingGetProfileState extends ShopStates {}

class ShopErrorGetProfileState extends ShopStates {}

class ShopSuccessGetProfileState extends ShopStates {}

class ShopLoadingUpdateProfileState extends ShopStates {}

class ShopErrorUpdateProfileState extends ShopStates {}

class ShopSuccessUpdateProfileState extends ShopStates {
  ShopLoginModel loginModel;
  ShopSuccessUpdateProfileState({
    required this.loginModel,
  });
}
