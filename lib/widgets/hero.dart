import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HeroSlide {
  final String title;
  final String subtitle;
  final String buttonText;
  final String imagePath;
  final List<Color> gradientColors;

  HeroSlide({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imagePath,
    required this.gradientColors,
  });
}

class HeroWidget extends StatefulWidget {
  const HeroWidget({super.key});

  @override
  State<HeroWidget> createState() => _HeroWidgetState();
}

class _HeroWidgetState extends State<HeroWidget> {
  late final PageController _pageController;

  int _currentPage = 0;

  final List<HeroSlide> _slides = [
    HeroSlide(
      title: '20% ',
      subtitle: 'on your first purchase',
      buttonText: 'Shop Now',
      imagePath: 'assets/images/green-shoe.png',
      gradientColors: const [Color(0xFF1D4F4E), Color(0xFFEDC54E)],
    ),
    HeroSlide(
      title: '30% ',
      subtitle: 'Off selected models',
      buttonText: 'Discover',
      imagePath: 'assets/images/airforce.png',
      gradientColors: const [Color(0xFF3A6EA5), Color(0xFF84B6F4)],
    ),

    // Aggiungere altre slide qui
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            onPageChanged: (idx) => setState(() => _currentPage = idx),
            itemBuilder: (context, idx) {
              final slide = _slides[idx];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          colors: slide.gradientColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: slide.title,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Discount\n',
                                  style: const TextStyle(fontSize: 24),
                                ),
                                TextSpan(
                                  text: slide.subtitle,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 12,
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              slide.buttonText,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Immagine sovrapposta
                    Positioned(
                      right: -10,
                      top: -10,
                      child: SimpleShadow(
                        opacity: 0.3,
                        color: Colors.black,
                        offset: const Offset(0, 10),
                        sigma: 20,
                        child: Image.asset(
                          slide.imagePath,
                          height: 180,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // Indicatore slide (puntini)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_slides.length, (idx) {
            bool active = idx == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 12 : 6,
              height: active ? 12 : 6,
              decoration: BoxDecoration(
                color: active ? Colors.black : Colors.black26,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}
