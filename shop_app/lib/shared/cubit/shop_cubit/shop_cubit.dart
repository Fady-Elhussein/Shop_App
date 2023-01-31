import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/constants.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favourite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories_screen/categories_screen.dart';
import 'package:shop_app/modules/favorite_screen/favorite_screen.dart';
import 'package:shop_app/modules/product_screen/product_screen.dart';
import 'package:shop_app/shared/cubit/shop_cubit/shop_state.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../modules/profile_screen/profile_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopCubitInitial());
  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screen = [
    const Productcreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];
  int currentIndex = 0;
  changeNavBar(int index) {
    currentIndex = index;
    emit(ShopBottomNavBarState());
  }

  Map<int, bool>? favorites = {};

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(url: hOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
      // ignore: avoid_print
      print(homeModel?.status);
      // ignore: avoid_function_literals_in_foreach_calls
      homeModel!.data!.products!.forEach((element) {
        favorites!.addAll({element.id!: element.inFavorites!});
      });
      emit(ShopSuccessHomeState());
    }).catchError((onError) {
      // ignore: avoid_print
      print(onError);
      emit(ShopErrorHomeState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(url: cATEGORIES).then((value) {
      emit(ShopSuccessCategoriesState());
      categoriesModel = CategoriesModel.fromJson(value?.data);
      // ignore: avoid_print
      print("The data is :${categoriesModel?.data?.data}");
      // ignore: avoid_print
      print(categoriesModel?.status);
    }).catchError((onError) {
      // ignore: avoid_print
      print("The error is :$onError");
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavoritesIcon(int productId) {
    favorites![productId] = !favorites![productId]!; // to change the status for Products that saved on this map
    emit(ShopChangeFavoritesIConState());
    DioHelper.postData(
        url: fAVORITES,
        token: token,
        data: {'product_id': productId}).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value!.data);
      if (!changeFavoritesModel!.status!) {
        favorites![productId] = !favorites![productId]!;
      }//لو في اي ايرور حصل في ال  Status رجعت ب false يرجع شكل الزرار قبل الايرور اذا كان متفقل ولا لاء
      if(changeFavoritesModel!.status==true) {
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((onError) {
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: fAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value?.data);
      // ignore: avoid_print
      print("The data of FavoritesModel :${favoritesModel?.data?.data}");
      // ignore: avoid_print
      print(favoritesModel?.status);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((onError) {
      // ignore: avoid_print
      print("The error of FavoritesModel :$onError");
      emit(ShopErrorGetFavoritesState());
    });
  }

   ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingGetProfileState());
    DioHelper.getData(
      url: pROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value?.data);
      print(userModel!.data!.name);
      print(userModel!.data!.email);
      print(userModel!.data!.phone);

      emit(ShopSuccessGetProfileState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProfileState());
    });
  }
  void updateUserData({required String name,required String phone,required String email}) {
    emit(ShopLoadingUpdateProfileState());
    DioHelper.putData(
      url: updateProfile,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value!.data);

      emit(ShopSuccessUpdateProfileState(loginModel: userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateProfileState());
    });
  }
}
