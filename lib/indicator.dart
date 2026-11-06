import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const SlideDemoApp());
}

class SlideDemoApp extends StatelessWidget {
  const SlideDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Complicated image slider demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Màu nền phía ngoài khung điện thoại (đổi sang xám nhạt/trắng nếu muốn)
        scaffoldBackgroundColor: const Color(0xFFD6D6D6),
      ),
      home: const MobileWrapperScreen(),
    );
  }
}

// Widget bọc giao diện theo tỷ lệ & hình dáng điện thoại ở chính giữa
class MobileWrapperScreen extends StatelessWidget {
  const MobileWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 375, // Độ rộng chuẩn màn hình điện thoại
          height: 700, // Chiều cao màn hình điện thoại
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE), // Màu nền bên trong ứng dụng
            borderRadius: BorderRadius.circular(
              32,
            ), // Bo tròn các góc như điện thoại
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: const ImageSliderScreen(),
          ),
        ),
      ),
    );
  }
}

class ImageSliderScreen extends StatefulWidget {
  const ImageSliderScreen({super.key});

  @override
  State<ImageSliderScreen> createState() => _ImageSliderScreenState();
}

class _ImageSliderScreenState extends State<ImageSliderScreen> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  // Danh sách hình ảnh trực tuyến
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1511285560929-80b456fea0bc?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1520854221256-17451cc331bf?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1542038784456-1ea8e935640e?auto=format&fit=crop&w=800&q=80',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.82);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_pageController.hasClients) return;
      int nextPage = (_currentPage + 1) % imgList.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {},
        ),
        title: const Text(
          'Complicated image slider demo',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Khu vực Slider Ảnh
          SizedBox(
            height: 220,
            child: PageView.builder(
              controller: _pageController,
              itemCount: imgList.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double scale = 1.0;
                    if (_pageController.position.haveDimensions) {
                      final page =
                          _pageController.page ?? _currentPage.toDouble();
                      scale = (1 - (page - index).abs() * 0.08).clamp(
                        0.92,
                        1.0,
                      );
                    }
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            imgList[index],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return ColoredBox(
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return ColoredBox(
                                color: Colors.grey.shade400,
                                child: const Icon(Icons.broken_image, size: 48),
                              );
                            },
                          ),
                          Positioned(
                            left: 12,
                            bottom: 12,
                            child: Text(
                              'No. $index image',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 4,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Nút tròn Indicator tự chuyển động ở dưới
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              imgList.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Colors.blue
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
