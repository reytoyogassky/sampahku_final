import 'package:flutter/material.dart';

class TantanganPage extends StatelessWidget {
  const TantanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0b3348),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BACK & TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'SampahKU Tantangan',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  )
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // AKTIF
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xff48a177),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '7 Hari Tanpa Sedotan Plastik',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Hindari penggunaan sedotan plastik sekali pakai selama 7 hari berturut-turut',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(7, (index) {
                              return CircleAvatar(
                                radius: 14,
                                backgroundColor: index < 4
                                    ? Colors.white
                                    : Colors.white24,
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: index < 4
                                        ? Colors.green
                                        : Colors.white,
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text(
                              'Tandai Hari Ini Selesai',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tantangan Tersedia Lainnya :',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 15),

                    _buildTantanganCard(
                        title: 'Sehari Tanpa Kantong Plastik',
                        desc:
                            'Gunakan tas belanja alternatif tanpa menggunakan kantong plastik'),

                    const SizedBox(height: 15),
                    _buildTantanganCard(
                        title: '30 Hari Kompos',
                        desc:
                            'Buat kompos dari sampah organik dapur selama 30 hari'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

   Widget _buildTantanganCard({required String title, required String desc}) {
    return Container(
      height: 180, // Fixed height biar seragam
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff344c5a),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent[100],
                foregroundColor: Colors.green[800],
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Mulai Tantangan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}