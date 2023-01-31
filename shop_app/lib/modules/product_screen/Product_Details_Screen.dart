import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productName;
  final dynamic productPrice;
  final dynamic productOldPrice;
  final String productImage;
  final String productDetails;
  final dynamic productDiscount;


  const ProductDetailsScreen({super.key, required this.productName, required this.productPrice, required this.productImage, required this.productDetails, this.productOldPrice, required this.productDiscount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body:buildProductDetails(
        productDetails: productDetails,
        productImage: productImage,
        productDiscount: productDiscount,
        productOldPrice: productOldPrice,
        productPrice: productPrice
      ),
    );
  }
}
Widget buildProductDetails(
    {productImage, productDiscount, productOldPrice, productPrice, productDetails})=> SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image(image:NetworkImage(productImage),fit: BoxFit.fill),
              const SizedBox(height: 20.0,),
              if(productDiscount !=0)
              Text('$productOldPrice.LE',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.black,
                    decorationThickness: 3.0,
                  )),
              Text(
                '$productPrice.LE',
                style: const TextStyle(
                    color: Colors.blue),
              ),
              Text(productDetails)

            ],
        ),
      ) ,
      ) ;
