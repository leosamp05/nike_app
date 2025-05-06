import 'package:flutter/material.dart';
import 'package:nike_app/widgets/hero.dart';
import 'package:nike_app/widgets/horizontal_bar_filter.dart';
import 'package:nike_app/widgets/product_card.dart';
import 'package:nike_app/models/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Vettore dei Prodotti
    final List<Product> products = [
      Product(
        name: 'Air Max 97',
        imagePath: 'assets/images/airmax.png',
        price: 20.99,
      ),
      Product(
        name: 'React Presto',
        imagePath: 'assets/images/react_presto.png',
        price: 25.99,
      ),
      Product(
        name: 'Air Max 200',
        imagePath: 'assets/images/airmax200.png',
        price: 30.99,
      ),
      Product(
        name: 'Air Force 1',
        imagePath: 'assets/images/airforce.png',
        price: 119.99,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 90),
          children: [
            const SizedBox(height: 25),

            const HeroWidget(),

            const SizedBox(height: 14),

            const CategoryBar(),

            const SizedBox(height: 23),

            // Product List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: products.length,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Grid scroll disattivato
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.67,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
