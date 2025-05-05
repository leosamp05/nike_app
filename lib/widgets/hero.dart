import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HeroWidget extends StatefulWidget {
  const HeroWidget({super.key});

  @override
  State<HeroWidget> createState() => _HeroWidgetState();
}

class _HeroWidgetState extends State<HeroWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: 175,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1D4F4E), Color(0xFFEDC54E)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '20% ',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Discount',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'on your first purchase',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Work Sans',
                      fontSize: 16.5,
                      fontWeight: FontWeight.normal,
                      // height: -0.1,
                    ),
                  ),

                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 8,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Shop Now',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: -7,
              child: SimpleShadow(
                opacity: 0.30, // Default: 0.5
                color: Colors.black, // Default: Black
                offset: Offset(0, 15.11), // Default: Offset(2, 2)
                sigma: 30.21,
                child: Image.asset(
                  'assets/images/green-shoe.png',
                  height: 172,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            bool isActive = index == 0; // attivo il primo
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 10 : 6,
              height: isActive ? 10 : 6,
              decoration: BoxDecoration(
                color: isActive ? Colors.black : Colors.black26,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}
