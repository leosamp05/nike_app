import 'package:flutter/material.dart';
import 'package:nike_app/pages/product_page.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:nike_app/models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 241, 241, 241),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SimpleShadow(
              opacity: 0.30,
              color: Colors.black,
              offset: Offset(0, 10.26),
              sigma: 20.52,
              child: Image.asset(
                widget.product.imagePath,
                height: 160,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.product.name,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              fontFamily: 'Work Sans',
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${widget.product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'Work Sans',
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 42,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12), // bordo grigio
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductPage(product: widget.product),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
