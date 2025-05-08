import 'package:flutter/material.dart';
import 'package:fui_kit/fui_kit.dart';
import 'package:nike_app/models/cart_service.dart';
import 'package:nike_app/pages/cart.dart';

/// Un AppBar personalizzato che ascolta CartService.instance
/// e mostra il badge aggiornato automaticamente.
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
        children: [
          Builder(
            builder:
                (ctx) => InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => Scaffold.of(ctx).openDrawer(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const FUI(
                      RegularRounded.ALIGN_LEFT,
                      height: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
          ),
          const SizedBox(width: 12),
          Image.asset('assets/images/nike-logo.png', height: 18),
        ],
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: AnimatedBuilder(
            animation: CartService.instance,
            builder: (ctx, _) {
              final cartCount = CartService.instance.count;
              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap:
                    () => Navigator.push(
                      ctx,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const FUI(
                        RegularRounded.SHOPPING_BAG,
                        height: 24,
                        color: Colors.black,
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
              );
            },
          ),
        ),
      ],
    );
  }
}
