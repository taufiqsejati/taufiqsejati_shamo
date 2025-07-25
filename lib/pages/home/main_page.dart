import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/pages/home/chat_page.dart';
import 'package:shamo/pages/home/home_page.dart';
import 'package:shamo/pages/home/profile_page.dart';
import 'package:shamo/pages/home/wishlist_page.dart';
import 'package:shamo/providers/page_provider.dart';
import 'package:shamo/theme.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget cartButton() {
      return FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        backgroundColor: secondaryColor,
        child: Image.asset('assets/icon_cart.png', width: 20),
      );
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomAppBar(
          color: backgroundColor4,
          shape: CircularNotchedRectangle(),
          // height: 80,
          notchMargin: 12,
          padding: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: backgroundColor4,
              elevation: 0,
              // currentIndex: currentIndex,
              currentIndex: pageProvider.currentIndex,
              onTap: (value) {
                print(value);
                // currentIndex = value;
                // setState(() {});
                pageProvider.currentIndex = value;
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 0),
                    child: Image.asset(
                      'assets/icon_home.png',
                      width: 21,
                      color: pageProvider.currentIndex == 0
                          // currentIndex == 0
                          ? primaryColor
                          : Color(0xff808191),
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 0),
                    child: Image.asset(
                      'assets/icon_chat.png',
                      width: 20,
                      color: pageProvider.currentIndex == 1
                          // currentIndex == 1
                          ? primaryColor
                          : Color(0xff808191),
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 0),
                    child: Image.asset(
                      'assets/icon_wishlist.png',
                      width: 20,
                      color: pageProvider.currentIndex == 2
                          // currentIndex == 2
                          ? primaryColor
                          : Color(0xff808191),
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 0),
                    child: Image.asset(
                      'assets/icon_profile.png',
                      width: 18,
                      color: pageProvider.currentIndex == 3
                          // currentIndex == 3
                          ? primaryColor
                          : Color(0xff808191),
                    ),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return HomePage();
          break;
        case 1:
          return ChatPage();
          break;
        case 2:
          return WishlistPage();
          break;
        case 3:
          return ProfilePage();
          break;

        default:
          return HomePage();
      }
    }

    return Scaffold(
      backgroundColor: pageProvider.currentIndex == 0
          ? backgroundColor1
          : backgroundColor3,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
