import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sampahku_final/pages/home_page.dart';

class TantanganPage extends StatefulWidget {
  const TantanganPage({super.key});

  @override
  State<TantanganPage> createState() => _TantanganPageState();
}

class _TantanganPageState extends State<TantanganPage> {
  List<Map<String, dynamic>> tantanganList = [];

  @override
  void initState() {
    super.initState();
    fetchTantangan();
  }

  Future<void> fetchTantangan() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('tantangan').get();

    final data = snapshot.docs.map((doc) {
      final item = doc.data();
      item['id'] = doc.id;
      return item;
    }).toList();

    setState(() {
      tantanganList = data.cast<Map<String, dynamic>>();
    });
  }

  Future<DocumentSnapshot?> _getTantanganAktif() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final userTantanganSnap = await FirebaseFirestore.instance
        .collection('pengguna_tantangan')
        .where('id_pengguna', isEqualTo: user.uid)
        .where('status', isEqualTo: 'Aktif')
        .limit(1)
        .get();

    if (userTantanganSnap.docs.isEmpty) return null;

    final progress = userTantanganSnap.docs.first['progress_hari'] ?? 0;
    final idTantangan = userTantanganSnap.docs.first['id_tantangan'];

    final detailSnap = await FirebaseFirestore.instance
        .collection('tantangan')
        .doc(idTantangan)
        .get();

    if (!detailSnap.exists) return null;

    final data = detailSnap.data();
    data?['progress_hari'] = progress;

    return detailSnap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0b3348),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SampahKUHomePage()),
                      );
                    },
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

            // TANTANGAN AKTIF
            FutureBuilder<DocumentSnapshot?>(
              future: _getTantanganAktif(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.white));
                }

                if (!snapshot.hasData || !(snapshot.data?.exists ?? false)) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Belum ada tantangan aktif.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final data = snapshot.data!.data() as Map<String, dynamic>;
                final nama = data['nama_tantangan'];
                final deskripsi = data['deskripsi'];
                final progress = data['progress_hari'] ?? 0;

                return Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xff48a177),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nama,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(deskripsi,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(7, (index) {
                          return CircleAvatar(
                            radius: 14,
                            backgroundColor: index < progress
                                ? Colors.white
                                : Colors.white24,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: index < progress
                                    ? Colors.green
                                    : Colors.white,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () async {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) return;

                          final userTantangan = await FirebaseFirestore.instance
                              .collection('pengguna_tantangan')
                              .where('id_pengguna', isEqualTo: user.uid)
                              .where('status', isEqualTo: 'Aktif')
                              .limit(1)
                              .get();

                          if (userTantangan.docs.isEmpty) return;

                          final docId = userTantangan.docs.first.id;
                          final current = userTantangan.docs.first['progress_hari'] ?? 0;

                          if (current >= 7) {
                            await FirebaseFirestore.instance
                                .collection('pengguna_tantangan')
                                .doc(docId)
                                .update({'status': 'Selesai'});
                            setState(() {});
                            return;
                          }

                          await FirebaseFirestore.instance
                              .collection('pengguna_tantangan')
                              .doc(docId)
                              .update({'progress_hari': current + 1});

                          setState(() {});
                        },
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
                );
              },
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Tantangan Tersedia Lainnya :',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 15),

            // TANTANGAN LIST
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: tantanganList.map((item) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xff344c5a),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['nama_tantangan'] ?? '',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                            item['deskripsi'] ?? '',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 13),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              final user = FirebaseAuth.instance.currentUser;
                              if (user == null) return;

                              final alreadyHas = await FirebaseFirestore.instance
                                  .collection('pengguna_tantangan')
                                  .where('id_pengguna', isEqualTo: user.uid)
                                  .where('status', isEqualTo: 'Aktif')
                                  .get();

                              if (alreadyHas.docs.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Selesaikan tantangan aktif dulu!'),
                                  ),
                                );
                                return;
                              }

                              await FirebaseFirestore.instance
                                  .collection('pengguna_tantangan')
                                  .add({
                                'id_pengguna': user.uid,
                                'id_tantangan': item['id'],
                                'status': 'Aktif',
                                'progress_hari': 0,
                              });

                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent[100],
                              foregroundColor: Colors.green[800],
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              'Mulai Tantangan',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
