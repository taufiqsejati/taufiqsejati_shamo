import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/widgets/product_card.dart';
import 'package:shamo/widgets/product_tile.dart';

import '../../dimens.dart';
import '../../models/product_model.dart';
import '../../widgets/custom_tabbar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  List<ProductModel> data = [];
  late TabController _tabController;
  final chips = [
    'All Shoes',
    'Sport',
    'Hiking',
    'Basketball',
    'Training',
    'Running',
  ];

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() async {
    if (_tabController.indexIsChanging) {
      setState(() {
        isLoading = true;
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hallo, ${user.name}',
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '@${user.username}',
                    style: subtitleTextStyle.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('${user.profilePhotoUrl!}&size=54'),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget categories() {
      return CustomTabbar(
        list: chips,
        tabController: _tabController,
        isScrollable: true,
      );
      // return Container(
      //   margin: EdgeInsets.only(top: defaultMargin),
      //   child: SingleChildScrollView(
      //     scrollDirection: Axis.horizontal,
      //     child: Row(
      //       children: [
      //         SizedBox(width: defaultMargin),
      //         Container(
      //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      //           margin: EdgeInsets.only(right: 16),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(12),
      //             color: primaryColor,
      //           ),
      //           child: Text(
      //             'All Shoes',
      //             style: primaryTextStyle.copyWith(
      //               fontSize: 13,
      //               fontWeight: medium,
      //             ),
      //           ),
      //         ),
      //         Container(
      //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      //           margin: EdgeInsets.only(right: 16),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(12),
      //             border: Border.all(color: subtitleColor),
      //             color: transparentColor,
      //           ),
      //           child: Text(
      //             'Running',
      //             style: subtitleTextStyle.copyWith(
      //               fontSize: 13,
      //               fontWeight: medium,
      //             ),
      //           ),
      //         ),
      //         Container(
      //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      //           margin: EdgeInsets.only(right: 16),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(12),
      //             border: Border.all(color: subtitleColor),
      //             color: transparentColor,
      //           ),
      //           child: Text(
      //             'Training',
      //             style: subtitleTextStyle.copyWith(
      //               fontSize: 13,
      //               fontWeight: medium,
      //             ),
      //           ),
      //         ),
      //         Container(
      //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      //           margin: EdgeInsets.only(right: 16),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(12),
      //             border: Border.all(color: subtitleColor),
      //             color: transparentColor,
      //           ),
      //           child: Text(
      //             'Basketball',
      //             style: subtitleTextStyle.copyWith(
      //               fontSize: 13,
      //               fontWeight: medium,
      //             ),
      //           ),
      //         ),
      //         Container(
      //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      //           margin: EdgeInsets.only(right: 16),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(12),
      //             border: Border.all(color: subtitleColor),
      //             color: transparentColor,
      //           ),
      //           child: Text(
      //             'Hiking',
      //             style: subtitleTextStyle.copyWith(
      //               fontSize: 13,
      //               fontWeight: medium,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // );
    }

    Widget popularProductsTitle() {
      return Container(
        margin: EdgeInsets.only(
          // top: defaultMargin,
          top: Spacing.dp,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Popular Products',
          style: primaryTextStyle.copyWith(fontSize: 22, fontWeight: semiBold),
        ),
      );
    }

    Widget popularProducts() {
      var all = productProvider.products;
      // AllMovies.where((i) => i.isAnimated).toList()
      List<ProductModel> sport = productProvider.products
          .where((e) => e.categoriesId == 1)
          .toList();
      List<ProductModel> hiking = productProvider.products
          .where((e) => e.categoriesId == 2)
          .toList();
      List<ProductModel> basketBall = productProvider.products
          .where((e) => e.categoriesId == 3)
          .toList();
      List<ProductModel> training = productProvider.products
          .where((e) => e.categoriesId == 4)
          .toList();
      List<ProductModel> running = productProvider.products
          .where((e) => e.categoriesId == 5)
          .toList();
      return Container(
        child: [
          Container(
            margin: EdgeInsets.only(top: 14),
            child: all.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: defaultMargin),
                        Row(
                          children: all
                              .map((product) => ProductCard(product))
                              .toList(),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 278,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Data Tidak Tersedia",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ),
          Container(
            margin: EdgeInsets.only(top: 14),
            child: sport.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: defaultMargin),
                        Row(
                          children: sport
                              .map((product) => ProductCard(product))
                              .toList(),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 278,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Data Tidak Tersedia",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ),
          Container(
            margin: EdgeInsets.only(top: 14),
            child: hiking.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: defaultMargin),
                        Row(
                          children: hiking
                              .map((product) => ProductCard(product))
                              .toList(),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 278,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Data Tidak Tersedia",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ),
          Container(
            margin: EdgeInsets.only(top: 14),
            child: basketBall.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: defaultMargin),
                        Row(
                          children: basketBall
                              .map((product) => ProductCard(product))
                              .toList(),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 278,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Data Tidak Tersedia",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ),
          Container(
            margin: EdgeInsets.only(top: 14),
            child: training.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: defaultMargin),
                        Row(
                          children: training
                              .map((product) => ProductCard(product))
                              .toList(),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 278,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Data Tidak Tersedia",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ),
          Container(
            margin: EdgeInsets.only(top: 14),
            child: running.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: defaultMargin),
                        Row(
                          children: running
                              .map((product) => ProductCard(product))
                              .toList(),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 278,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Data Tidak Tersedia",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ),
        ][_tabController.index],
      );
      // return Container(
      //   margin: EdgeInsets.only(top: 14),
      //   child: SingleChildScrollView(
      //     scrollDirection: Axis.horizontal,
      //     child: Row(
      //       children: [
      //         SizedBox(width: defaultMargin),
      //         Row(
      //           children: productProvider.products
      //               .map((product) => ProductCard(product))
      //               .where((e) => e.product.categoriesId == 5)
      //               .toList(),
      //         ),
      //       ],
      //     ),
      //   ),
      // );
    }

    Widget newArrivalsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'New Arrivals',
          style: primaryTextStyle.copyWith(fontSize: 22, fontWeight: semiBold),
        ),
      );
    }

    Widget newArrivals() {
      return Container(
        margin: EdgeInsets.only(top: 14),
        child: Column(
          children: productProvider.products
              .map((product) => ProductTile(product))
              .toList(),
        ),
      );
    }

    return ListView(
      children: [
        header(),
        SizedBox(height: Spacing.xl),
        categories(),
        popularProductsTitle(),
        popularProducts(),
        newArrivalsTitle(),
        newArrivals(),
      ],
    );
  }
}
