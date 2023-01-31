import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/cubit/shop_cubit/shop_cubit.dart';
import '../../shared/cubit/shop_cubit/shop_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return cubit.categoriesModel?.data != null
            ? AnimationLimiter(
                child: ListView.builder(
                padding: EdgeInsets.all(width / 30),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: cubit.categoriesModel!.data!.data!.length,
                itemBuilder: (context, index) => buildCategoriesItem(
                    cubit.categoriesModel!.data!.data![index], index, width),
              ))
            : loadingAnimation();
      },
    );
  }

  Widget buildCategoriesItem(DataModel model, int index, double width) =>
      AnimationConfiguration.staggeredList(
        delay: const Duration(milliseconds: 100),
        position: index,
        child: SlideAnimation(
          duration: const Duration(milliseconds: 2500),
          curve: Curves.fastLinearToSlowEaseIn,
          horizontalOffset: 30,
          verticalOffset: 300.0,
          child: FlipAnimation(
            duration: const Duration(milliseconds: 3000),
            curve: Curves.fastLinearToSlowEaseIn,
            flipAxis: FlipAxis.y,
            child: Container(
              margin: EdgeInsets.only(bottom: width / 20),
              height: width / 4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image(
                      image: NetworkImage('${model.image}'),
                      height: 80.0,
                      width: 80.0),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    '${model.name}',
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
