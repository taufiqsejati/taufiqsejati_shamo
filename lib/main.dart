import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shamo/pages/cart_page.dart';
import 'package:shamo/pages/checkout_page.dart';
import 'package:shamo/pages/checkout_success_page.dart';
// import 'package:shamo/pages/detail_chat_page.dart';
import 'package:shamo/pages/edit_profile_page.dart';
import 'package:shamo/pages/home/main_page.dart';
// import 'package:shamo/pages/product_page.dart';
import 'package:shamo/pages/sign_in_page.dart';
import 'package:shamo/pages/sign_up_page.dart';
import 'package:shamo/pages/splash_page.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/providers/page_provider.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/providers/transaction_provider.dart';
import 'package:shamo/providers/wishlist_provider.dart';
import 'package:shamo/utils/dio_helper.dart';

import 'models/users_model.dart';
import 'pages/history_transaction_page.dart';
import 'providers/custom_provider.dart';
import 'providers/transaction_history_provider.dart';
import 'utils/setup_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Hive.registerAdapter(MUsersAdapter());
  setupGetit();
  await initApiConfig();
  await initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(
          create: (context) => TransactionHistoryProvider(),
        ),
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(create: (context) => CustomProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/home': (context) => MainPage(),
          '/edit-profile': (context) => EditProfilePage(),
          '/cart': (context) => CartPage(),
          '/checkout': (context) => CheckoutPage(),
          '/checkout-success': (context) => CheckoutSuccessPage(),
          '/history-transaction': (context) => HistoryTransactionPage(),
        },
      ),
    );
  }
}
