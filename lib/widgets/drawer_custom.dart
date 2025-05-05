import 'package:flutter/material.dart';
import 'package:fui_kit/maps/regular_rounded.dart';
import 'package:fui_kit/widgets/icons/icon_widget.dart';

class DrawerCustom extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const DrawerCustom({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Image.asset(
                'assets/images/nike-logo-white.png',
                height: 50,
                width: 50,
              ),
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FUI(RegularRounded.HOME, height: 20, color: Colors.black87),
                  SizedBox(width: 10),
                  Text('Home'),
                ],
              ),
              selected: selectedIndex == 0,
              onTap: () {
                onItemSelected(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FUI(
                    RegularRounded.BOOKMARK,
                    height: 20,
                    color: Colors.black87,
                  ),
                  SizedBox(width: 10),
                  Text('Wishlist'),
                ],
              ),
              selected: selectedIndex == 1,
              onTap: () {
                onItemSelected(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FUI(RegularRounded.BELL, height: 20, color: Colors.black87),
                  SizedBox(width: 10),
                  Text('Inbox'),
                ],
              ),
              selected: selectedIndex == 2,
              onTap: () {
                onItemSelected(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FUI(RegularRounded.USER, height: 20, color: Colors.black87),
                  SizedBox(width: 10),
                  Text('Profile'),
                ],
              ),
              selected: selectedIndex == 3,
              onTap: () {
                onItemSelected(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
