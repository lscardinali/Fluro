import 'package:checkout/bloc/cart_cubit.dart';
import 'package:checkout/bloc/promotion_cubit.dart';
import 'package:checkout/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => PromotionCubit()),
      ],
      child: MaterialApp(
        initialRoute: Routes.products,
        routes: Routes.appRoutes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
          cardTheme: CardTheme(color: Colors.grey[200], elevation: 0),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
        darkTheme: ThemeData(
          cardTheme: CardTheme(color: Colors.grey[800]),
          scaffoldBackgroundColor: Colors.grey[900],
          badgeTheme: const BadgeThemeData(
            textColor: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.green, brightness: Brightness.dark),
        ),
      ),
    );
  }
}
