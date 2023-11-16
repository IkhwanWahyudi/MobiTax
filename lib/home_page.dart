import 'package:flutter/material.dart';
import 'package:mobi_tax/profil_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MobiTax"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.all(6),
                width: double.infinity,
                color: Colors.amber,
                alignment: Alignment.centerLeft,
                child: const Text("Hai, Nama"),
              ),
              const SizedBox(height: 10),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.green,
                padding: const EdgeInsets.only(left: 6),
                alignment: Alignment.centerLeft,
                child: const Text("Kendaraan Anda")
              ),
              ListView.builder(
                shrinkWrap: true, // Tambahkan shrinkWrap
                physics: NeverScrollableScrollPhysics(), // Tambahkan physics
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: [
                        Text("Plat Nomor ${index + 1}"),
                        Text("Kendaraan ${index + 1}"),
                        Text("Masa Berlaku ${index + 1}")
                      ],
                    ),
                  );
                },
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Tambah Kendaraan"))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Halaman Utama"),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Transaksi"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
        currentIndex: 0, // Indeks yang aktif sesuai dengan halaman "Home"
        onTap: (int index) async {
          if (index == 2) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Profile(), // menggunakan AboutPage dari about_page.dart
            ));
          }
        },
        unselectedItemColor: const Color(0xFFEAD7BB), // warna icon saat tidak dipilih
        selectedItemColor: const Color(0xFF183D3D), // warna icon saat dipilih atau aktif
        backgroundColor: const Color(0xFFBCA37F), // warna background
      ),
    );
  }
}