import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_state.dart';

class Productcreen extends StatelessWidget {
  const Productcreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: ((context, state) {}),
        builder: ((context, state) {
          return ShopCubit.get(context).homeModel != null
              ? buildBannerItem(ShopCubit.get(context).homeModel!)
              : loadingAnimation();
        }));
  }

  Widget buildBannerItem(HomeModel homeModel) => SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
                items: homeModel.data!.banners?.map((e) {
                  return Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
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
              height: 10.0,
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1 / 1.4, //width / height
              children: List.generate(
                  homeModel.data!.products!.length,
                  (index) =>
                      buildCategoriesItem(homeModel.data!.products![index])),
            ),
          ],
        ),
      );

  Widget buildCategoriesItem(ProductModel productModel) => Column(
        children: [
          Image(
            image: NetworkImage(productModel.image!),
            width: double.infinity,
            height: 200,
            fit: BoxFit.fill,
          ),
          Text(
            productModel.name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14.0, height: 1.3),
          ),
          Text(
            '${productModel.price}.LE',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14.0, height: 1.3),
          ),
        ],
      );
}
