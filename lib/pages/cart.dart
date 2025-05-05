import 'package:flutter/material.dart';
import 'package:fui_kit/maps/regular_rounded.dart';
import 'package:fui_kit/widgets/icons/icon_widget.dart';
// import 'package:nike_app/main.dart';
import 'package:nike_app/widgets/drawer_custom.dart';
import 'package:nike_app/widgets/header.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerCustom(
        selectedIndex: 4,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      appBar: const Header(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FUI(RegularRounded.SAD, height: 150, color: Colors.black87),
          Text(
            'Your cart is empty',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
