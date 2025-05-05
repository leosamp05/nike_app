import 'package:flutter/material.dart';
import 'package:fui_kit/fui_kit.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:nike_app/models/product.dart';
import 'package:nike_app/models/cart_service.dart';
import 'package:nike_app/pages/cart.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  double shoeY = 0;
  double boxOpacity = 0.3;
  final double targetY = 350;

  String selectedSize = 'UK 7';
  Color selectedColor = Colors.red;

  final List<String> sizes = ['UK 6', 'UK 7', 'UK 8', 'UK 9'];
  final List<Color> colors = [Colors.red, Colors.blue];

  void handleDrag(DragUpdateDetails details) {
    final dy = details.delta.dy;
    if (dy > 0) {
      setState(() {
        shoeY = (shoeY + dy).clamp(0.0, targetY);
        boxOpacity = (shoeY / targetY).clamp(0.3, 1.0);
      });
    }
  }

  void handleRelease(DragEndDetails details) {
    if (shoeY >= targetY) {
      CartService.instance.add(widget.product);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Aggiunto al carrello!')));
    }
    // reset di posizione e opacità
    setState(() {
      shoeY = 0;
      boxOpacity = 0.3;
    });
  }

  void resetBoxOpacity() {
    setState(() => boxOpacity = 0.3);
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = CartService.instance.count;

    Widget _shoeWidget() {
      return Transform.rotate(
        angle: -0.3,
        child: SimpleShadow(
          opacity: .3,
          color: Colors.black,
          offset: const Offset(0, 22),
          sigma: 45,
          child: Image.asset(
            widget.product.imagePath,
            height: 270,
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 7, top: 7),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Icon(Icons.arrow_back, color: Colors.black, size: 20),
              ),
            ),
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartPage()),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FUI(
                      RegularRounded.SHOPPING_BAG,
                      color: Colors.black,
                      height: 24,
                    ),
                  ),
                  if (cartCount > 0)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Sfondo NIKE
          Positioned(
            top: 90,
            child: RotatedBox(
              quarterTurns: 1,
              child: Text(
                'NIKE',
                style: TextStyle(
                  fontSize: 200,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade100,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),

          // Dettagli prezzo/taglie/colore
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      text: '\$',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Work Sans',
                      ),
                      children: [
                        TextSpan(
                          text: widget.product.price.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Work Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '10% OFF',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Work Sans',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Size',
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                sizes.map((size) {
                                  final isSel = selectedSize == size;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: ChoiceChip(
                                      label: Text(size),
                                      selected: isSel,
                                      showCheckmark: false,
                                      onSelected:
                                          (_) => setState(
                                            () => selectedSize = size,
                                          ),
                                      selectedColor: Colors.white,
                                      labelStyle: TextStyle(
                                        fontFamily: 'Work Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color:
                                              isSel
                                                  ? Colors.black
                                                  : Colors.black12,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            'Save',
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: FUI(
                                    RegularRounded.BOOKMARK,
                                    height: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 120),
                              // colori
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Colour',
                                    style: TextStyle(
                                      fontFamily: 'Work Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Column(
                                    children:
                                        colors.map((color) {
                                          final isSel = selectedColor == color;
                                          return GestureDetector(
                                            onTap:
                                                () => setState(
                                                  () => selectedColor = color,
                                                ),
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                bottom: 8,
                                              ),
                                              padding: const EdgeInsets.all(4),
                                              width: 28,
                                              height: 28,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: color,
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color:
                                                      isSel
                                                          ? Colors.black
                                                          : Colors
                                                              .grey
                                                              .shade300,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: DragTarget<Product>(
              onWillAccept: (_) {
                setState(() => boxOpacity = 1.0);
                return true;
              },
              onLeave: (_) => resetBoxOpacity(),
              onAccept: (product) {
                CartService.instance.add(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Aggiunto al carrello!')),
                );
                setState(() {});
                resetBoxOpacity();
              },
              builder: (context, candidate, rejected) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: boxOpacity,
                  child: Image.asset(
                    'assets/images/shoebox.png',
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),

          Positioned(
            bottom: 170,
            child: Column(
              children: [
                Text(
                  "Swipe down to add",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SizedBox(
                      width: 24,
                      height: 50,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: const FUI(
                              RegularRounded.ANGLE_SMALL_DOWN,
                              color: Colors.white24,
                              height: 24,
                            ),
                          ),
                          Positioned(
                            top: 13,
                            left: 0,
                            right: 0,
                            child: const FUI(
                              RegularRounded.ANGLE_SMALL_DOWN,
                              color: Colors.white54,
                              height: 24,
                            ),
                          ),
                          Positioned(
                            top: 26,
                            left: 0,
                            right: 0,
                            child: const FUI(
                              RegularRounded.ANGLE_SMALL_DOWN,
                              color: Colors.white,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 150 + shoeY,
            left: (MediaQuery.of(context).size.width - 270) / 2,
            child: GestureDetector(
              onPanUpdate: handleDrag,
              onPanEnd: handleRelease,
              child: _shoeWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
