import 'package:flutter/material.dart';
import 'package:fui_kit/fui_kit.dart';
import 'package:nike_app/models/whishlist_service.dart';
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
  Offset shoeOffset = Offset.zero;
  double boxOpacity = 0.3;
  final double targetY = 350;

  String selectedSize = 'UK 7';
  Color selectedColor = Colors.red;

  // Vettore Taglie
  final List<String> sizes = ['UK 6', 'UK 7', 'UK 8', 'UK 9'];

  // Vettore Colori scarpe
  final List<Color> colors = [Colors.red, Colors.blue];

  // logica per trascinare la scarpa e aumentare l'opacità della scatola
  void handleDrag(DragUpdateDetails details) {
    setState(() {
      // sommiamo delta sia in x che in y
      shoeOffset += details.delta;
      // manteniamo l’opacità della box in base allo spostamento verticale
      boxOpacity = (shoeOffset.dy / targetY).clamp(0.3, 1.0);
    });
  }

  // Per aggiungere il prodotto al carrello e mostrare lo snackbar con un alert
  void handleRelease(DragEndDetails details) {
    if (shoeOffset.dy >= targetY) addToCart();
    // reset posizione e opacità
    setState(() {
      shoeOffset = Offset.zero;
      boxOpacity = 0.3;
    });
  }

  void addToCart() {
    CartService.instance.add(widget.product);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Aggiunto al carrello!')));
  }

  @override
  Widget build(BuildContext context) {
    final isSaved = WishlistService.instance.items.contains(widget.product);
    final cartCount = CartService.instance.count;
    final originX = (MediaQuery.of(context).size.width - 270) / 2;
    const originY = 150.0;

    // Scarpa
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

        // Back Arrow
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

        // Titolo del Prodotto
        title: Text(
          widget.product.name,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        // Cart Button
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
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: boxOpacity,
              child: Image.asset(
                'assets/images/shoebox.png',
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Positioned(
            bottom: 170,
            child: Column(
              children: [
                const Text(
                  "Swipe down to add",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
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
                      children: const [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white24,
                          ),
                        ),
                        Positioned(
                          top: 13,
                          left: 0,
                          right: 0,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white54,
                          ),
                        ),
                        Positioned(
                          top: 26,
                          left: 0,
                          right: 0,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: originY + shoeOffset.dy,
            left: originX + shoeOffset.dx,
            child: GestureDetector(
              onPanUpdate: handleDrag,
              onPanEnd: handleRelease,
              child: _shoeWidget(),
            ),
          ),

          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Size',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...sizes.map((size) {
                      final isSel = selectedSize == size;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: ChoiceChip(
                          label: Text(size),
                          selected: isSel,
                          showCheckmark: false,
                          onSelected:
                              (_) => setState(() => selectedSize = size),
                          selectedColor: Colors.white,
                          labelStyle: TextStyle(
                            fontFamily: 'Work Sans',
                            color: isSel ? Colors.black : Colors.black54,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: isSel ? Colors.black : Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    }),
                  ],
                ),

                const Spacer(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Save',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        if (isSaved) {
                          WishlistService.instance.remove(widget.product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Rimosso dalla wishlist!'),
                            ),
                          );
                        } else {
                          WishlistService.instance.add(widget.product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Aggiunto alla wishlist!'),
                            ),
                          );
                        }
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSaved ? Colors.black : Colors.white,
                          border: Border.all(
                            color: isSaved ? Colors.black : Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: FUI(
                          RegularRounded.BOOKMARK,
                          color: isSaved ? Colors.white : Colors.black,
                          height: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 130),
                    const Text(
                      'Colour',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...colors.map((color) {
                      final isSel = selectedColor == color;
                      return GestureDetector(
                        onTap: () => setState(() => selectedColor = color),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  isSel ? Colors.black : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
