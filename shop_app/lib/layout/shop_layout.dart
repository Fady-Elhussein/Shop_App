import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import '../modules/login&register/login_screen/shoplogin_screen.dart';
import '../shared/cubit/shop_cubit.dart';
import '../shared/cubit/shop_state.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: ((context) => ShopCubit()..getHomeData()),
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Salla'),
                actions: [
                  IconButton(onPressed: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SearchScreen(),));
                  }, icon:const Icon(Icons.search)),
                  TextButton.icon(
                      onPressed: () {
                        CacheHelper.removeData(key: 'token')?.then((value) {
                          if (value!) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ShopLoginScreen(),
                                ),
                                (route) => false);
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.power_settings_new,
                      ),
                      label: const Text(
                        'Logout',
                      )),
                
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: bottomNavBar,
                currentIndex: ShopCubit.get(context).currentIndex,
                onTap: (index) {
                  ShopCubit.get(context).changeNavBar(index);
                },
              ),
              body: ShopCubit.get(context)
                  .screen[ShopCubit.get(context).currentIndex],
            );
          },
        ));
  }
}
