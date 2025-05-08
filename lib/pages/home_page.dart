import 'package:flutter/material.dart';
import 'package:nike_app/widgets/hero.dart';
import 'package:nike_app/widgets/horizontal_bar_filter.dart';
import 'package:nike_app/widgets/product_card.dart';
import 'package:nike_app/models/product.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final categories = [
    'All',
    'Running',
    'Sneakers',
    'Formal',
    'Casual',
    'Hiking',
    'Training',
  ];

  int selectedCategoryIndex = 0;

  // Vettore dei Prodotti
  final allProducts = <Product>[
    Product(
      name: 'Air Max 97',
      imagePath: 'assets/images/airmax.png',
      price: 20.99,
      category: 'Running',
    ),
    Product(
      name: 'React Presto',
      imagePath: 'assets/images/react_presto.png',
      price: 25.99,
      category: 'Running',
    ),
    Product(
      name: 'Air Max 200',
      imagePath: 'assets/images/airmax200.png',
      price: 30.99,
      category: 'All',
    ),
    Product(
      name: 'Air Force 1',
      imagePath: 'assets/images/airforce.png',
      price: 119.99,
      category: 'Sneakers',
    ),
    Product(
      name: 'Air Max 97',
      imagePath: 'assets/images/airmax.png',
      price: 20.99,
      category: 'Running',
    ),
    Product(
      name: 'React Presto',
      imagePath: 'assets/images/react_presto.png',
      price: 25.99,
      category: 'Running',
    ),
    Product(
      name: 'Air Max 200',
      imagePath: 'assets/images/airmax200.png',
      price: 30.99,
      category: 'All',
    ),
    Product(
      name: 'Air Force 1',
      imagePath: 'assets/images/airforce.png',
      price: 119.99,
      category: 'Sneakers',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered =
        (selectedCategoryIndex == 0)
            ? allProducts
            : allProducts
                .where((p) => p.category == categories[selectedCategoryIndex])
                .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: const SizedBox(height: 25)),
          SliverToBoxAdapter(child: const HeroWidget()),
          SliverToBoxAdapter(child: const SizedBox(height: 14)),

          // Barra dei filtri sticky
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyFilterBarDelegate(
              child: CategoryBar(
                categories: categories,
                selectedIndex: selectedCategoryIndex,
                onTap: (i) => setState(() => selectedCategoryIndex = i),
              ),
              height: 50,
            ),
          ),

          SliverToBoxAdapter(child: const SizedBox(height: 23)),

          // Griglia prodotti
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, idx) => ProductCard(product: filtered[idx]),
                childCount: filtered.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
            ),
          ),

          SliverToBoxAdapter(child: const SizedBox(height: 90)),
        ],
      ),
    );
  }
}

// Delegate che tiene la CategoryBar pinnata in cima
class _StickyFilterBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _StickyFilterBarDelegate({required this.child, required this.height});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: child);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _StickyFilterBarDelegate old) {
    return old.child != child || old.height != height;
  }
}
