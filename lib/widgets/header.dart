import 'package:flutter/material.dart';
import 'package:fui_kit/models/maps.dart';
import 'package:fui_kit/widgets/icons/icon_widget.dart';
// import 'package:nike_app/main.dart';
import 'package:nike_app/pages/cart.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Drawer
          Row(
            children: [
              Builder(
                builder:
                    (context) => InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: FUI(
                          RegularRounded.ALIGN_LEFT,
                          height: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
              ),
              SizedBox(width: 12),

              // logo
              Image.asset('assets/images/nike-logo.png', height: 18),
            ],
          ),

          // Cart
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: FUI(
                RegularRounded.SHOPPING_BAG,
                height: 24,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
