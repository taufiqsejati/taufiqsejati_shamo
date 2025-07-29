import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/theme.dart';

import '../utils/config.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isLoggedIn = false;
  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      await Provider.of<ProductProvider>(context, listen: false).getProducts();
      if (_isLoggedIn) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil("/home", (route) => false);
      } else {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil("/sign-in", (route) => false);
      }
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _checkIfLoggedIn();

    // getInit();

    super.initState();
  }

  void _checkIfLoggedIn() {
    setState(() {
      _isLoggedIn = Config().isLoggedIn;
    });
  }

  // getInit() async {
  //   await Provider.of<ProductProvider>(context, listen: false).getProducts();
  //   Navigator.pushNamed(context, '/sign-in');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image_splash.png'),
            ),
          ),
        ),
      ),
    );
  }
}
