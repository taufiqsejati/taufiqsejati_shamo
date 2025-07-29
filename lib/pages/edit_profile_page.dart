import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/theme.dart';

import '../utils/config.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isLoading = false;
  // String? name = '';
  // String? userName = '';
  // String? email = '';

  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    nameController.text = Config().users.name.toString();
    usernameController.text = Config().users.username.toString();
    emailController.text = Config().users.email.toString();

    handleEdit() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.updateProfile(
        email: emailController.text,
        name: nameController.text,
        username: usernameController.text,
        token: user.token.toString(),
      )) {
        // Navigator.pushNamed(context, '/home');
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text('Gagal Update Profile!', textAlign: TextAlign.center),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    PreferredSizeWidget header() {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: primaryTextColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: Text('Edit Profile', style: primaryTextStyle),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: primaryColor),
            onPressed: handleEdit,
          ),
        ],
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name', style: secondaryTextStyle.copyWith(fontSize: 13)),
            TextFormField(
              style: primaryTextStyle,
              // initialValue: "${user.name}",
              controller: nameController,
              decoration: InputDecoration(
                // hintText: user.name,
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: subtitleColor),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget usernameInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username', style: secondaryTextStyle.copyWith(fontSize: 13)),
            TextFormField(
              style: primaryTextStyle,
              // initialValue: "${user.username}",
              controller: usernameController,
              decoration: InputDecoration(
                // hintText: '@${user.username}',
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: subtitleColor),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            TextFormField(
              style: primaryTextStyle,
              // initialValue: "${user.email}",
              controller: emailController,
              decoration: InputDecoration(
                // hintText: user.email,
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: subtitleColor),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: defaultMargin),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('${user.profilePhotoUrl!}&size=54'),
                ),
              ),
            ),
            nameInput(),
            usernameInput(),
            emailInput(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(),
      resizeToAvoidBottomInset: false,
    );
  }
}
