import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SampahKuHomePage extends StatefulWidget {
  const SampahKuHomePage({super.key});

  @override
  State<SampahKuHomePage> createState() => _SampahKuHomePageState();
}

class _SampahKuHomePageState extends State<SampahKuHomePage> {
  @override
  Widget build(BuildContext context) {
    // Membuat status bar di atas menjadi terang (cocok untuk background gelap)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildBody(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        elevation: 4.0,
        child: const Icon(Icons.add_home_outlined, color: Color(0xFF0D4D44)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // WIDGET UNTUK BAGIAN HEADER (AREA HIJAU)
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF63BFA9), Color(0xFF0D4D44)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris untuk Avatar, Nama, dan Notifikasi
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 30, color: Colors.grey),
              ),
              const SizedBox(width: 15),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SampahKU',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Haloo, Yohanes Irshan 👋',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    'King Plastik 🥇',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.notifications_none,
                  color: Colors.white, size: 30),
            ],
          ),
          const SizedBox(height: 30),
          // Bagian Challenge
          const Text(
            'Challenge 🔥',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            '7 Hari Tanpa Plastik',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 15),
          // Progress Bar
          Stack(
            children: [
              Container(
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.75,
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const Positioned.fill(
                child: Center(
                  child: Text(
                    '75%',
                    style: TextStyle(
                        color: Color(0xFF0D4D44), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // WIDGET UNTUK BAGIAN BODY (AREA PUTIH)
  Widget _buildBody() {
    return Container(
      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatistik(),
            const SizedBox(height: 30),
            _buildJenisSampah(),
          ],
        ),
      ),
    );
  }

  // WIDGET UNTUK KARTU STATISTIK
  Widget _buildStatistik() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Statistik',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Chip(
              label: const Text('Filter', style: TextStyle(color: Colors.green)),
              backgroundColor: Colors.green.withOpacity(0.2),
              avatar: const Icon(Icons.filter_list, color: Colors.green),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            _buildLegend(Colors.green, 'Organik'),
            const SizedBox(width: 20),
            _buildLegend(Colors.lightGreen, 'Anorganik'),
            const Spacer(),
            const Text('2025', style: TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 20),
        // Bar Chart Sederhana
        SizedBox(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar('Jan', 0.6, Colors.green),
              _buildBar('Feb', 0.7, Colors.lightGreen),
              _buildBar('Feb', 0.9, Colors.green),
              _buildBar('Mar', 0.5, Colors.lightGreen),
              _buildBar('Mar', 0.65, Colors.green),
              _buildBar('Apr', 0.55, Colors.lightGreen),
              _buildBar('Apr', 0.9, Colors.green),
              _buildBar('Mei', 0.7, Colors.lightGreen),
              _buildBar('Mei', 0.8, Colors.green),
              _buildBar('Mei', 0.95, Colors.lightGreen),
            ],
          ),
        ),
      ],
    );
  }

  // WIDGET UNTUK KARTU JENIS-JENIS SAMPAH
  Widget _buildJenisSampah() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Jenis-Jenis Sampah',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'By: Yohanes Irshan',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                Text(
                  '10 Juni 2025',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildWasteCard(
                color: Colors.orange.shade100,
                title: 'SAMPAH PLASTIK',
                content1: 'Kantong Plastik, Botol Plastik, Gelas Plastik, Sterofoam, dsb',
                content2: 'Sampah plastik dapat didaur ulang menjadi kerajinan tangan ataupun menjadi bahan barang yang dapat digunakan kembali.',
              ),
              _buildWasteCard(
                color: Colors.blue.shade100,
                title: 'SAMPAH KACA',
                content1: 'Botol Kaca, Piring Kaca, Botol Parfum, Gelas Kaca, Pecahan Kaca, dsb',
                content2: 'Sampah kaca dapat didaur ulang untuk pembuatan batu tiruan ataupun vas/pot cantik.',
              ),
              _buildWasteCard(
                color: Colors.green.shade100,
                title: 'SAMPAH ORGANIK',
                content1: 'Sisa Makanan, Daun - daunan, Cangkang Buah, dsb',
                content2: 'Sampah organik dapat dimanfaatkan sebagai pupuk, pakan ternak, biogas dan listrik.',
              ),
              _buildWasteCard(
                color: Colors.brown.shade100,
                title: 'SAMPAH KERTAS',
                content1: 'Buku, Karton, Kardus, Koran, Kertas, dsb',
                content2: 'Sampah kertas dapat didaur ulang menjadi kerajinan tangan dan bahan pembuatan kertas beku.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // WIDGET UNTUK BOTTOM NAVIGATION BAR
  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: const Color(0xFF0D4D44),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.bar_chart, 'Report', true),
            _buildNavItem(null, 'Tambah Sampah', false), // Placeholder
            _buildNavItem(Icons.book_outlined, 'Edukasi', false),
            _buildNavItem(Icons.person_outline, 'Profile', false),
          ],
        ),
      ),
    );
  }

  // === WIDGET-WIDGET PEMBANTU ===

  // Item untuk Navigasi Bawah
  Widget _buildNavItem(IconData? icon, String label, bool isActive) {
    if (icon == null) {
      // Ini adalah placeholder untuk area tombol tengah
      return const SizedBox(width: 40);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isActive ? Colors.white : Colors.white54),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
              color: isActive ? Colors.white : Colors.white54, fontSize: 12),
        ),
      ],
    );
  }

  // Bar untuk Chart Statistik
  Widget _buildBar(String label, double heightFactor, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 120 * heightFactor,
          width: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  // Legend untuk Chart Statistik
  Widget _buildLegend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  // Kartu untuk Jenis Sampah
  Widget _buildWasteCard(
      {required Color color,
      required String title,
      required String content1,
      required String content2}) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 5),
          Text(content1, style: const TextStyle(fontSize: 12)),
          const Spacer(),
          const Icon(Icons.recycling, size: 24),
          const SizedBox(height: 5),
          Text(content2, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}