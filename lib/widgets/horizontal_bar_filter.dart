import 'package:flutter/material.dart';

class CategoryBar extends StatefulWidget {
  const CategoryBar({super.key});

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  // Vettore Categorie
  final List<String> categories = [
    'All',
    'Running',
    'Sneakers',
    'Formal',
    'Casual',
    'Hiking',
    'Training',
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(categories.length, (index) {
            final isSelected = selectedIndex == index;

            return Padding(
              padding: const EdgeInsets.only(left: 1, right: 1),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
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
                    categories[index],
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isSelected ? Colors.white : Color(0xFF9C9C9C),
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
