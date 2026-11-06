import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import để SettingsScreen biết LoginScreen là gì

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Trạng thái lưu trữ các công tắc bật/tắt (State)
  bool _notification = true;
  bool _darkMode = false;
  bool _rememberLogin = true;

  // Giá trị các cài đặt ứng dụng
  String _language = 'Tiếng Việt';
  String _fontSize = 'Vừa';

  // Hàm hiển thị BottomSheet để chọn tùy chọn
  void _showSelectionBottomSheet(
    String title,
    List<String> options,
    String currentValue,
    Function(String) onSelect,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...options.map((option) {
                return ListTile(
                  title: Text(option),
                  trailing: option == currentValue
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    onSelect(option);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  // Hàm hiển thị hộp thoại AlertDialog xác nhận Đăng xuất
 // Hàm hiển thị hộp thoại AlertDialog xác nhận Đăng xuất
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất khỏi tài khoản này?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Bấm HỦY thì đóng hộp thoại
              child: const Text('HỦY', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                // 1. Đóng hộp thoại xác nhận trước
                Navigator.pop(context);

                // 2. Chuyển ngay lập tức sang màn hình Đăng nhập (LoginScreen)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('ĐĂNG XUẤT'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
        // tài khoản
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              'TÀI KHOẢN',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Nhận thông báo'),
                  value: _notification,
                  onChanged: (val) {
                    setState(() => _notification = val);
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Chế độ tối'),
                  value: _darkMode,
                  onChanged: (val) {
                    setState(() => _darkMode = val);
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Nhớ đăng nhập'),
                  value: _rememberLogin,
                  onChanged: (val) {
                    setState(() => _rememberLogin = val);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

         // ứng 
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              'ỨNG DỤNG',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Ngôn ngữ'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_language, style: const TextStyle(color: Colors.grey)),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                  onTap: () {
                    _showSelectionBottomSheet(
                      'Chọn ngôn ngữ',
                      ['Tiếng Việt', 'English', 'Français'],
                      _language,
                      (selected) => setState(() => _language = selected),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Cỡ chữ'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_fontSize, style: const TextStyle(color: Colors.grey)),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                  onTap: () {
                    _showSelectionBottomSheet(
                      'Chọn cỡ chữ',
                      ['Nhỏ', 'Vừa', 'Lớn'],
                      _fontSize,
                      (selected) => setState(() => _fontSize = selected),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Về ứng dụng'),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'My Application',
                      applicationVersion: '1.0.0',
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          //  NÚT ĐĂNG XUẤT VIỀN ĐỎ 
          OutlinedButton(
            onPressed: _showLogoutDialog,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              foregroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Đăng xuất',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}