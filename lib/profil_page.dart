import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              child: const Column(
                children: [
                  Text("ID Pengguna"),
                  Text("Nama Pengguna")
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    child: Text("Data Diri")
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      child: const Row(
                        children: [
                          Icon(Icons.list_alt_sharp),
                          Text("Ubah Data Diri")
                        ]
                      ),
                    )
                  ),
                  Container(
                    child: Text("Bantuan"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline),
                          Text("Panduan")
                        ]
                      ),
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Halaman Utama"),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Transaksi"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
        currentIndex: 2, // Indeks yang aktif sesuai dengan halaman "Home"
        onTap: (int index) async {
          if (index == 0) {
            Navigator.of(context).pop();
          }
        },
        unselectedItemColor: const Color(0xFFEAD7BB), // warna icon saat tidak dipilih
        selectedItemColor: const Color(0xFF183D3D), // warna icon saat dipilih atau aktif
        backgroundColor: const Color(0xFFBCA37F), // warna background
      ),
    );
  }
}