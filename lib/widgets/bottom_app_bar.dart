import 'package:flutter/material.dart';
import 'package:fui_kit/fui_kit.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [
      FUI(RegularRounded.HOME, height: 27, color: Colors.black),
      FUI(RegularRounded.BOOKMARK, height: 27, color: Colors.black),
      FUI(RegularRounded.BELL, height: 27, color: Colors.black),
      FUI(RegularRounded.USER, height: 27, color: Colors.black),
    ];

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
        ),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 13)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(4, (index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSelected)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  )
                else
                  const SizedBox(height: 6),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: icons[index],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
