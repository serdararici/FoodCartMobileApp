
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_cart_app/colors.dart';
import 'package:food_cart_app/data/entity/foods.dart';
import 'package:food_cart_app/ui/cubit/food_details_cubit.dart';
import 'package:food_cart_app/ui/views/cart.dart';

var foodQuantity = 1;
var totalFoodPrice = 0;
class FoodDetails extends StatefulWidget {
  Foods food;
  FoodDetails({required this.food});


  @override
  State<FoodDetails> createState() => _ProductDetailsState();
}


class _ProductDetailsState extends State<FoodDetails> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodQuantity = 1;
    totalFoodPrice = widget.food.food_price;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ürün Detayı",
        style: TextStyle(color: Colors.white,fontFamily:"Pacifico", fontSize: 22 ),),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white), // İkonu değiştir
          onPressed: () {
            Navigator.of(context).pop(); // Geri gitme işlemi
          },
        ),
        backgroundColor: mainColor,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 200,height: 200,
              child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.food.food_image}", height: 100, fit: BoxFit.cover)),
          Text(widget.food.food_name, style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black),),
          Text("${widget.food.food_price} ₺",style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: mainColor),),
          const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                if(foodQuantity != 1){
                  foodQuantity--;
                }else{
                  foodQuantity = 1;
                }
                setState(() {
                  foodQuantity;
                  totalFoodPrice = (foodQuantity*widget.food.food_price);
                });
              },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(), // Butonu yuvarlak yapmak için
                  padding: EdgeInsets.all(15), // Butonun boyutunu ayarlamak için
                  backgroundColor: mainColor, // Butonun arka plan rengini kırmızı yapmak için
                ),
                child: Icon(Icons.remove,color: Colors.white,size: 30)),
              //const Spacer(),
              Text("$foodQuantity",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 50),),
              //const Spacer(),
              ElevatedButton(onPressed: (){
                setState(() {
                  foodQuantity++;
                  totalFoodPrice = (foodQuantity*widget.food.food_price);
                });
              },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), // Butonu yuvarlak yapmak için
                    padding: EdgeInsets.all(15), // Butonun boyutunu ayarlamak için
                    backgroundColor: mainColor, // Butonun arka plan rengini kırmızı yapmak için
                  ),
                  child: Icon(Icons.add,color: Colors.white,size: 30)),
            ],
          ),
          Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("₺${totalFoodPrice}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              ElevatedButton(onPressed: (){
                // Sepete ekleme İşlemi
                context.read<FoodDetailsCubit>()
                    .addFoods(widget.food.food_name,
                  widget.food.food_image,
                  widget.food.food_price,
                  foodQuantity,
                  "serdar",);
                //sepete ekleme bildirimi göstermek için
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                  content: Text('Ürün sepete eklendi: ${widget.food.food_name}'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green, // İsteğe bağlı, renk ayarı
                  ),
                );
              }, style: ElevatedButton.styleFrom(
                //shape:  // Butonu yuvarlak yapmak için
                padding: EdgeInsets.all(15), // Butonun boyutunu ayarlamak için
                backgroundColor: mainColor, // Butonun arka plan rengini kırmızı yapmak için
              ), child: const Text("Sepete Ekle",style: TextStyle(fontSize: 22,color: Colors.white),)),
            ],
          ),
          Spacer(),
        ],
        ),
      ),
    );
  }
}
