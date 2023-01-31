import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/shop_cubit/shop_state.dart';

import '../../shared/cubit/shop_cubit/shop_cubit.dart';
import 'Product_Details_Screen.dart';

class Productcreen extends StatelessWidget {
  const Productcreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: ((context, state) {
          if(state is ShopSuccessChangeFavoritesState)
          {
            if(!state.model.status!){
              showToast(context: context, msg: state.model.message!);
            }
          }
        }),
        builder: ((context, state) {
          return cubit.homeModel != null &&
                  ShopCubit.get(context).categoriesModel != null
              ? buildBannerItem(
                  cubit.homeModel!, cubit.categoriesModel!, context, cubit)
              : loadingAnimation();
        }));
  }

  Widget buildBannerItem(HomeModel homeModel, CategoriesModel categoriesModel,
          BuildContext context, cubit) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: homeModel.data!.banners?.map((e) {
                 return Image.network(
                   '${e.image}',
                   fit: BoxFit.cover,
                   width: double.infinity,
                   errorBuilder: (context, error, stackTrace){
                       return const Text('No Image Found');
                   } ,
                   loadingBuilder: (context, child, loadingProgress) {
                     if (loadingProgress == null) {
                       return child;
                     } else {
                       return const Center(
                         child:  CircularProgressIndicator(
                           color: Colors.blue,
                         ),
                       );
                     }
                   },);
                }).toList(),
                options: CarouselOptions(
                  animateToClosest: true,
                  initialPage: 0,
                  viewportFraction: 0.9, //علشان يخود الشاشه كلها
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                )),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              'Categories',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 10.0,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: 100.0,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    buildCategoriesItem(categoriesModel.data!.data![index]),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10.0,
                ),
                itemCount: categoriesModel.data!.data!.length,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'New Products',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 25.0,
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1 / 1.59, //width / height
              children: List.generate(
                homeModel.data!.products!.length,
                (index) {
                  return AnimationConfiguration.staggeredGrid(
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: buildProductItem(
                              homeModel.data!.products![index], context, cubit),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );

  Widget buildCategoriesItem(DataModel categoriesModel) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${categoriesModel.image}'),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100.0,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              '${categoriesModel.name}',
              maxLines: 1,
              style: const TextStyle(color: Colors.white, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );

  Widget buildProductItem(
          ProductModel productModel, BuildContext context, cubit) =>
      InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(productModel.image!),
                  width: double.infinity,
                  height: 200,
                ),
                if (productModel.discount != 0)
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
                productModel.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14.0, height: 1.3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  if (productModel.discount !=
                      0) //التحتوا بس هو بتاع السعر القديم  Text هيعرض ال True  ب if  لو ال
                    Text('${productModel.oldPrice}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          height: 1.3,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.black,
                          decorationThickness: 3.0,
                        )),
                  if (productModel.discount != 0)
                    const SizedBox(
                      width: 7.0,
                    ),
                  Text(
                    //True or False ب if دا كده كده هيتعرض سواء ال
                    '${productModel.price}.LE',
                    style: const TextStyle(
                        fontSize: 14.0, height: 1.3, color: Colors.blue),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavoritesIcon(productModel.id!);

                    },
                    icon: cubit.favorites[productModel.id]
                        ? const Icon(
                            Icons.favorite,
                            size: 20.0,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            size: 20.0,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(
  productName: productModel.name!,
  productImage: productModel.image!,
  productDetails: productModel.description!,
  productPrice: productModel.price,
  productOldPrice: productModel.oldPrice,
  productDiscount: productModel.discount,
  ),
  ),
      ),
      );
}
