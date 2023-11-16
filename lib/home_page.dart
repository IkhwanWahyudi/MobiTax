// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'detail.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 237, 237),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
        // backgroundColor: Colors.white,
        title: const Text(
          "MobiTax",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top:16, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.all(6),
                width: double.infinity,
                // color: Colors.amber,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                    color: const Color.fromRGBO(70, 152, 138, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: const Text(
                  "Hai, Nama",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 20,
                // width: double.infinity,
                width: lebar,
                // color: Colors.green,
                padding: const EdgeInsets.only(
                  left: 6,
                ),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Kendaraan Anda",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  // Menambahkan fungsi GestureDetector untuk navigasi
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(), // Navigasi ke DetailPage
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: lebar,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            children: [
                              Text("Plat Nomor ${index + 1}"),
                              Text("Kendaraan ${index + 1}"),
                              Text("Masa Berlaku ${index + 1}")
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
                  minimumSize:
                      const Size(150, 50), // Atur lebar dan tinggi button
                  padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16), // Padding di sekitar icon dan teks
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30.0), // Mengatur radius untuk membuat button rounded
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Tambah Kendaraan'),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: SizedBox(
      //   height: kBottomNavigationBarHeight + 10.0,
      //   child: BottomNavigationBar(
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: "Halaman Utama",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.credit_card),
      //         label: "Transaksi",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: "Profil",
      //       ),
      //     ],
      //     currentIndex: 0,
      //     onTap: (int index) async {
      //       if (index == 2) {
      //         Navigator.of(context).push(MaterialPageRoute(
      //           builder: (context) => const Profile(),
      //         ));
      //       }
      //     },
      // unselectedItemColor: const Color.fromARGB(255, 161, 161, 159),
      // selectedItemColor: const Color.fromRGBO(70, 152, 138, 1),
      //     backgroundColor: Colors.white,
      //   ),
      // ),
    );
  }
}
