
import 'package:flutter/material.dart';
import 'package:food_cart_app/colors.dart';
import 'package:food_cart_app/data/entity/foods.dart';

class ProductDetails extends StatefulWidget {
  Foods food;
  ProductDetails({required this.food});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ürün Detayı"),),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("name${widget.food.food_image}"),
          Text(widget.food.food_name, style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black),),
          Text("${widget.food.food_price} ₺",style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: mainColor),),
        ],),
      ),
    );
  }
}
