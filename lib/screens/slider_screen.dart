import 'package:flutter/material.dart';
import 'package:travell_app/widgets/slide_item.dart';
import 'package:travell_app/widgets/slide_dot.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> slideList = [
    {'title': 'Explora el mundo fácilmente', 'subtitle': 'A tu deseo', 'image': 'assets/slide_image_1.png'},
    {'title': 'Llegar al lugar desconocido', 'subtitle': 'A tu destino', 'image': 'assets/slide_image_2.png'},
    {'title': 'Establece conexiones con Travello', 'subtitle': 'A tu viaje soñado', 'image': 'assets/slide_image_3.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack( 
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: slideList.length,
            itemBuilder: (context, i) {
              return SlideItem(
                title: slideList[i]['title']!,
                subtitle: slideList[i]['subtitle']!,
                image: slideList[i]['image']!,
              );
            },
          ),
          Positioned(
            bottom: 50,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    slideList.length,
                    (index) => SlideDot(
                      isActive: _currentPage == index,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_currentPage < slideList.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    } else {
                      Navigator.pushNamed(context, '/login');
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF222222), 
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}