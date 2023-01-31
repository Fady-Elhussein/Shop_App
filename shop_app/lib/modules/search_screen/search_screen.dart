import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app/modules/product_screen/Product_Details_Screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/search_cubit/search_cubit.dart';

import '../../models/search_model.dart';
import '../../shared/cubit/search_cubit/search_states.dart';
class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defulttextformfiled(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) return 'Search For Any Thing';
                        return null;
                      },
                      onFieldSubmitted: (String? text) {
                        cubit.search(text!);
                      },
                      text: "Search",
                      prefixIcon:const Icon(Icons.search),
                      readOnly: false,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(
                        color: Colors.blue,
                        backgroundColor: Colors.green,
                      ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    if (state is! SearchSuccessState)
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue, width: 1),
                            ),
                            child: const Icon(
                              Icons.search,
                              size: 60.0,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Search For What You Want',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: GridView.count(
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1 / 1.59, //width / height
                          children: List.generate(
                            cubit.searchModel!.data!.data!.length,
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
                                        cubit.searchModel!.data!.data![index],context
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}




Widget buildProductItem(Product model,context) =>
    InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(
          productName: model.name!,
          productImage: model.image!,
          productDetails: model.description!,
          productPrice: model.price,
          productDiscount: model.discount??0,
         ),)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.network(
                 model.image!,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.blue,
                    );
                  }

              },),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
            child: Text(
              model.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14.0, height: 1.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children:[
                Text(
                  '${model.price}.LE',
                  style: const TextStyle(
                      fontSize: 14.0, height: 1.3, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
