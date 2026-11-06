import 'package:flutter/material.dart';

class DestinationScreen extends StatelessWidget {
  const DestinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // 1. Hình ảnh 
          Image.network(
            'https://images.unsplash.com/photo-1641563634844-bcda72f71221?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8SGElMjBMb25nJTIwQmF5fGVufDB8fDB8fHww',
            width: double.infinity,
            height: 240,
            fit: BoxFit.cover,
          ),

          // 2. Phần Tiêu đề 
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: const Text(
                          'Ha Long Bay',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        'Quang Ninh, Vietnam',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.star,
                  color: Colors.red,
                ),
                const Text('5.0'),
              ],
            ),
          ),

          // 3. Phần Nút chức năng (CALL, ROUTE, SHARE)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
              _buildButtonColumn(Colors.blue, Icons.near_me, 'ROUTE'), // Đã sửa màu thành Colors.blue
              _buildButtonColumn(Colors.blue, Icons.share, 'SHARE'),
              _buildButtonColumn(Colors.blue, Icons.favorite, 'LIKE'),
            ],
          ),

          // 4. Phần Văn bản mô tả
          const Padding(
            padding: EdgeInsets.all(32),
            child: Text(
              'Ha Long Bay is a UNESCO World Heritage Site located in '
              'Quang Ninh Province, Vietnam. Famous for its emerald '
              'waters and thousands of towering limestone islands topped '
              'by rainforests, it is one of the most popular travel '
              'destinations in Southeast Asia. Popular activities include '
              'boat cruises, cave exploration, kayaking, and enjoying '
              'stunning natural landscapes.',
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

   
  static Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}