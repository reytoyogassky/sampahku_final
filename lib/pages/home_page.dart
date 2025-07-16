import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sampahku_final/pages/edukasi_page.dart';
import 'package:sampahku_final/pages/profile_page.dart';
import 'package:sampahku_final/pages/tantangan_page.dart';
import 'package:sampahku_final/pages/trash_page.dart';

const Color kScaffoldBackground = Color(0xFFF4F7F6);
const Color kDarkGreen = Color(0xFF00695C);
const Color kMediumGreen = Color(0xFF26A69A);
const Color kDarkBarColor = Color(0xFF388E3C);
const Color kLightBarColor = Color(0xFFA5D6A7);
const Color kOrangeCard = Color(0xFFFFE0B2);
const Color kBlueCard = Color(0xFFBBDEFB);
const Color kGreenCard = Color(0xFFC8E6C9);
const Color kBrownCard = Color(0xFFD7CCC8);

class SampahKUHomePage extends StatefulWidget {
  const SampahKUHomePage({super.key});

  @override
  State<SampahKUHomePage> createState() => _SampahKUHomePageState();
}

class _SampahKUHomePageState extends State<SampahKUHomePage> {
  int _selectedIndex = 0;
  String namaLengkap = '...';

  final List<Widget> _pages = const [
    HomeContent(), // Ini isi halaman utama
    TantanganPage(),
    TrashPage(),
    EdukasiPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserNamaLengkap();
  }

  Future<void> _loadUserNamaLengkap() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('pengguna').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          namaLengkap = doc['nama_lengkap'] ?? 'Pengguna';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: kScaffoldBackground,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeContent(namaLengkap: namaLengkap),
          const TantanganPage(),
          const TrashPage(),
          const EdukasiPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kDarkGreen,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Tantangan'),
          BottomNavigationBarItem(icon: Icon(Icons.delete_forever), label: 'Tambah Sampah'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Edukasi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final String namaLengkap;
  const HomeContent({super.key, this.namaLengkap = '...'});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SingleChildScrollView(
      child: Column(
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kMediumGreen, kDarkGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        user?.photoURL ??
                            'https://ui-avatars.com/api/?name=${Uri.encodeComponent(namaLengkap)}',
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SampahKU', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Haloo, $namaLengkap 👋', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
                        Text('King Plastik 🥇', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.notifications_none, color: Colors.white, size: 30),
                  ],
                ),
                const SizedBox(height: 30),
                Text('Challenge 🔥', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text('7 Hari Tanpa Plastik', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 15),
                _progressBar(),
              ],
            ),
          ),

          // BODY
          Container(
            transform: Matrix4.translationValues(0.0, -20.0, 0.0),
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: kScaffoldBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                _statistik(),
                const SizedBox(height: 30),
                _jenisSampah(namaLengkap),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressBar() {
    const double progress = 0.75;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.maxWidth * progress,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment(progress * 2 - 1, 0),
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Text('${(progress * 100).toInt()}%',
                    style: GoogleFonts.poppins(
                        color: kDarkGreen, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statistik() {
    final Map<String, List<double>> chartData = {
      'Jan': [0.6],
      'Feb': [0.7, 0.9],
      'Mar': [0.5, 0.65],
      'Apr': [0.55, 0.9],
      'Mei': [0.7, 0.8, 0.95],
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Statistik',
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
              Chip(
                label: Text('Filter',
                    style: GoogleFonts.poppins(
                        color: const Color(0xff0F9D58), fontWeight: FontWeight.w600)),
                backgroundColor: const Color(0xffE8F3F1),
                avatar: const Icon(Icons.filter_list, color: Color(0xff0F9D58)),
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _legend(kDarkBarColor, 'Organik'),
              const SizedBox(width: 20),
              _legend(kLightBarColor, 'Anorganik'),
              const Spacer(),
              Text('2025', style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: chartData.entries.map((entry) {
                return _barGroup(entry.key, entry.value);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _jenisSampah(String namaLengkap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jenis-Jenis Sampah', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('By: $namaLengkap', style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12)),
              Text('10 Juni 2025', style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12)),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: const [
                _WasteCard(color: kOrangeCard, title: 'SAMPAH PLASTIK', content1: 'Kantong Plastik, Botol Plastik, Gelas Plastik, Sterofoam, dsb'),
                _WasteCard(color: kBlueCard, title: 'SAMPAH KACA', content1: 'Botol Kaca, Piring Kaca, Botol Parfum, Gelas Kaca, Pecahan Kaca, dsb'),
                _WasteCard(color: kGreenCard, title: 'SAMPAH ORGANIK', content1: 'Sisa Makanan, Daun - daunan, Cangkang Buah, dsb'),
                _WasteCard(color: kBrownCard, title: 'SAMPAH KERTAS', content1: 'Buku, Karton, Kardus, Koran, Kertas, dsb'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legend(Color color, String label) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: GoogleFonts.poppins(color: Colors.grey.shade700)),
      ],
    );
  }

  Widget _barGroup(String month, List<double> heights) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(heights.length, (index) {
            return Container(
              height: 120 * heights[index],
              width: 10,
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                color: index.isEven ? kDarkBarColor : kLightBarColor,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text(month, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

class _WasteCard extends StatelessWidget {
  final Color color;
  final String title;
  final String content1;
  const _WasteCard({required this.color, required this.title, required this.content1});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
          const SizedBox(height: 5),
          Text(content1, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black.withOpacity(0.7))),
          const Spacer(),
          const Icon(Icons.recycling, size: 24, color: Colors.black54),
          const SizedBox(height: 5),
          Text('Sampah dapat di daur ulang', style: GoogleFonts.poppins(fontSize: 12, color: Colors.black.withOpacity(0.7))),
        ],
      ),
    );
  }
}
