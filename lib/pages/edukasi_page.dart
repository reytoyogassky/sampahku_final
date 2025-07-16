import 'package:flutter/material.dart';
import 'package:sampahku_final/pages/home_page.dart';
class EdukasiPage extends StatelessWidget {
  const EdukasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe9f3fb),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SampahKUHomePage()),
            );
          },
        ),
        
        title: const Text(
          'Edukasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          EdukasiCard(
            imageUrl: 'lib/assets/images/edu1.jpeg', // ganti sesuai kebutuhan
            title: 'Jenis-Jenis Sampah',
            author: 'Yohanes Irshan',
            date: '10 Juni 2025',
          ),
          SizedBox(height: 20),
          EdukasiCard(
            imageUrl: 'lib/assets/images/edu1.jpeg', // ganti sesuai kebutuhan
            title: 'Pengelolaan Sampah',
            author: 'Yohanes Irshan',
            date: '20 Juni 2025',
          ),
        ],
      ),
    );
  }
}

class EdukasiCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String date;

  const EdukasiCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('By : $author',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600)),
                    Text(date,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
