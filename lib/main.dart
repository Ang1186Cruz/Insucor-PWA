
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/helpers/custom_route.dart';
import 'package:flutter_shop_app/providers/customers.dart';
import 'package:flutter_shop_app/screens/edit_customers_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/splash_screen.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/product_detail_screen.dart';
import './screens/customers_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (_, auth, previousProducts) => Products(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (_, auth, previousOrders) => Orders(auth.token, auth.userId,
              previousOrders == null ? [] : previousOrders.orders),
        ),
        ChangeNotifierProxyProvider<Auth, Customers>(
          create: null,
          update: (_, auth, previousCustomers) => Customers(auth.token, auth.userId,
              previousCustomers == null ? [] : previousCustomers.items),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) {
          return MaterialApp(
            localizationsDelegates: [
                GlobalMaterialLocalizations.delegate
              ],
              supportedLocales: [
                const Locale('es')
              ],
            title: 'Mi Tienda',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.amber, 
              accentColor: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Lato',
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                }
              )
            ),
            home: auth.isAuth?
               CustomersScreen() //ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              ProductsOverviewScreen.routeName:(_) => ProductsOverviewScreen(),
              ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
              CartScreen.routeName: (_) => CartScreen(),
              OrdersScreen.routeName: (_) => OrdersScreen(),
              UserProductsScreen.routeName: (_) => UserProductsScreen(),
              EditProductScreen.routeName: (_) => EditProductScreen(),
              EditcustomerScreen.routeName:(_) => EditcustomerScreen(),
            },
          );
        },
      ),
    );
  }
}
