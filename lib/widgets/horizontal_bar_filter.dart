// lib/widgets/category_bar.dart
import 'package:flutter/material.dart';

class CategoryBar extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CategoryBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(categories.length, (i) {
            final isSelected = i == selectedIndex;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () => onTap(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    categories[i],
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color:
                          isSelected ? Colors.white : const Color(0xFF9C9C9C),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
