import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdfdfd),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff1baa76), Color(0xff0b6348)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://media.discordapp.net/attachments/1122216076479045642/1377227147105538128/Raze_big_goofy_head.jpeg?ex=686cee3b&is=686b9cbb&hm=4a7f196c5b8d65602a4c7041babd6b31702b9728c63fffd104db18a0b038acf7&=&format=webp&width=441&height=376',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Yohanes Irshan',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const Text(
                  'King Plastik 👑',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.eco, size: 16, color: Colors.green),
                      SizedBox(width: 5),
                      Text(
                        '100 Point',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          _buildOption(Icons.edit, 'Ubah Profil'),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lainnya',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildOption(Icons.verified_user_outlined, 'Versi Aplikasi'),
                const SizedBox(height: 8),
                _buildOption(Icons.logout, 'Keluar',
                    isDestructive: true),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOption(IconData icon, String label,
      {bool isDestructive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          color: const Color(0xfff2f2f2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? Colors.red : Colors.green),
            const SizedBox(width: 15),
            Text(
              label,
              style: TextStyle(
                color: isDestructive ? Colors.red : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
