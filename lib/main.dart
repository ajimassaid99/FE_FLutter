import 'package:flutter/material.dart';
import 'package:triangel_virtual/triangel_virtual_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuPilihan = [
    {'title': 'Info Program', 'icon': Icons.info},
    {'title': 'Info Lokasi Faskes', 'icon': Icons.location_on},
    {'title': 'Info Peserta', 'icon': Icons.person},
    {'title': 'Pendaftaran Pelayanan', 'icon': Icons.app_registration},
    {'title': 'Konsultasi Dokter', 'icon': Icons.medical_services},
    {'title': 'TriAngel Virtual', 'icon': Icons.medical_services},
    // Tambahkan menu lainnya sesuai kebutuhan
  ];

  final List<Map<String, dynamic>> menuLainnya = [
    {'title': 'Info Jadwal Telekonsultasi', 'icon': Icons.schedule},
    {'title': 'Panduan Penggunaan', 'icon': Icons.help_outline},
    {'title': 'Menu Chat', 'icon': Icons.chat},
    // Tambahkan menu lainnya sesuai kebutuhan
  ];

  void _onMenuTap(BuildContext context, String title) {
    if (title == 'TriAngel Virtual') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TriangleVirtualScreen()),
      );
    } else {
      // Navigasi atau logika lainnya saat menu diklik
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Menu $title diklik')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Menu Lainnya'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Menu Pilihanmu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: menuPilihan.length,
              itemBuilder: (context, index) {
                return MenuItem(
                  title: menuPilihan[index]['title'],
                  icon: menuPilihan[index]['icon'],
                  onTap: () => _onMenuTap(context, menuPilihan[index]['title']),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text('Menu Lainnya',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: menuLainnya.length,
              itemBuilder: (context, index) {
                return MenuItem(
                  title: menuLainnya[index]['title'],
                  icon: menuLainnya[index]['icon'],
                  onTap: () => _onMenuTap(context, menuLainnya[index]['title']),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue.shade100,
            child: Icon(icon, size: 28, color: Colors.blue),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
