import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_cart_app/ui/cubit/cart_cubit.dart';
import 'package:food_cart_app/ui/cubit/food_details_cubit.dart';
import 'package:food_cart_app/ui/cubit/mainpage_cubit.dart';
import 'package:food_cart_app/ui/views/mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainpageCubit()),
        BlocProvider(create: (context) => FoodDetailsCubit()),
        BlocProvider(create: (context) => CartCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Mainpage(),
      ),
    );
  }
}
