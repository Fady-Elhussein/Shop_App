import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/constants.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories_screen/categories_screen.dart';
import 'package:shop_app/modules/favorite_screen/favorite_screen.dart';
import 'package:shop_app/modules/product_screen/product_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/cubit/shop_state.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopCubitInitial());
  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screen = [
    const Productcreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
    const SettingsScreen(),
  ];
  int currentIndex = 0;
  changeNavBar(int index) {
    currentIndex = index;
    emit(ShopBottomNavBarState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(url: hOME,token: token).then((value) {
      emit(ShopSuccessHomeState());
      homeModel = HomeModel.fromJson(value?.data);
      print(homeModel?.status);
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorHomeState());
    });
  }
}
