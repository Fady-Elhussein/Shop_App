import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../models/favourite_model.dart';
import '../../shared/cubit/shop_cubit/shop_cubit.dart';
import '../../shared/cubit/shop_cubit/shop_state.dart';
import '../product_screen/Product_Details_Screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return cubit.favoritesModel?.data!=null
              ?  GridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1 / 1.59, //width / height
                  children: List.generate(
                    cubit.favoritesModel!.data!.total!,
                    (index) {
                      return  AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            columnCount: 2,
                            child: ScaleAnimation(
                              duration: const Duration(milliseconds: 900),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: FadeInAnimation(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 40,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: buildProductItem(
                                      cubit.favoritesModel!.data!.data![index],context
                                     ),
                                ),
                              ),
                            ),
                          );
                        },
                  ),
                )
              : loadingAnimation();
        });
  }

  Widget buildProductItem(FavouritesData  model,context) =>
      InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.product!.image!),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.product!.discount != 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Container(
                      color: Colors.red,
                      child: const Text(
                        "Discount",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
              child: Text(
                model.product!.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14.0, height: 1.3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  if (model.product!.discount !=
                      0) //التحتوا بس هو بتاع السعر القديم  Text هيعرض ال True  ب if  لو ال
                    Text('${model.product!.oldPrice}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          height: 1.3,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.black,
                          decorationThickness: 3.0,
                        )),
                  if (model.product!.discount != 0)
                    const SizedBox(
                      width: 7.0,
                    ),
                  Text(
                    //True or False ب if دا كده كده هيتعرض سواء ال
                    '${model.product!.price}.LE',
                    style: const TextStyle(
                        fontSize: 14.0, height: 1.3, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(
  productName: model.product!.name!,
  productImage: model.product!.image!,
  productDetails: model.product!.description!,
  productPrice: model.product!.price,
  productOldPrice: model.product!.oldPrice,
  productDiscount: model.product!.discount,
  ),
  ),
  ),
      );
}
