import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_cart_app/colors.dart';
import 'package:food_cart_app/data/entity/cart_foods.dart';
import 'package:food_cart_app/ui/cubit/cart_cubit.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getFoodsFromCart("serdar");
  }

  int calculateTotalPrice(List<CartFoods> foodList) {
    int total = 0;
    for (var food in foodList) {
      var price = food.food_price;
      var quantity = food.food_quantity;
      total += price * quantity;
    }
    return total;
  }

  //siparişi onaylamak
  void _confirmOrder() {
    context.read<CartCubit>().clearCart("serdar");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sipariş Onaylandı"),
          content: Text("Siparişiniz başarıyla alındı."),
          actions: [
            TextButton(
              child: Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sepetim",
          style: TextStyle(
              color: Colors.white, fontFamily: "Pacifico", fontSize: 22),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: mainColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CartCubit, List<CartFoods>>(
              builder: (context, foodList) {
                if (foodList.isNotEmpty) {
                  int totalPrice = calculateTotalPrice(foodList);

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: foodList.length,
                          itemBuilder: (context, index) {
                            var food = foodList[index];
                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        "http://kasimadalan.pe.hu/yemekler/resimler/${food.food_image}",
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            food.food_name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Fiyat: ₺${food.food_price}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey[600]),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Adet: ${food.food_quantity}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.grey,
                                              size: 30),
                                          onPressed: () {
                                            context.read<CartCubit>().deleteFoodsFromCart(
                                                food.food_cart_id,
                                                food.user_name);
                                          },
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '₺ ${food.food_price * food.food_quantity}',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, -1),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Toplam: ₺$totalPrice",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Siparişi onayla işlemleri
                                _confirmOrder();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "Siparişi Onayla",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                      'Sepetinizde ürün bulunmuyor.',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
