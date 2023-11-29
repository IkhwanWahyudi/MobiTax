// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:mobi_tax/kendaraan.dart';
import 'detail.dart';

class Kendaraan {
// class Kendaraan
  String kendaraan, plat, masaBerlaku, brand, paint, type, bbm;
  int transmisi, year;

  Kendaraan(this.kendaraan, this.plat, this.masaBerlaku, this.brand, this.paint,
      this.year, this.type, this.bbm, this.transmisi);
}

List<Kendaraan> kendaraans = [
// list untuk menampung semua inputan/produk
  Kendaraan("Motor", "KT 1234 WW", "2 Juli 2025", "Honda PCX", "Hitam", 2018,
      "Matic", "Bensin", 150),
  Kendaraan("Mobil", "KT 3412 OP", "5 Mei 2025", "Honda CR-V", "Putih", 2020,
      "Matic", "Bensin", 1498),
  Kendaraan("Motor", "KT 9547 BA", "23 Oktober 2025", "MX King", "Biru", 2020,
      "Manual", "Bensin", 150),
];

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 237, 237),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(70, 152, 138, 1),
        title: const Text(
          "MOBITAX",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                // Buat ke setting
              },
              icon: Icon(
                Icons.settings,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        //centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                //color: Color.fromRGBO(255,192,27, 1),
                color: Color.fromRGBO(70, 152, 138, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey, // warna bayangan
                    blurRadius: 5, // radius blur bayangan
                    offset: Offset(
                        0, 0), // pergeseran bayangan (horizontal, vertical)
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                width: 50,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Pengguna",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Kota Samarinda",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    IconButton(
                      //padding: EdgeInsets.all(10),
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        // Logika ketika tombol di tekan
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 20,
              // width: double.infinity,
              width: lebar,
              // color: Colors.green,
              // padding: const EdgeInsets.only(
              //   left: 6,
              // ),
              margin: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Kendaraan Anda",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              itemCount: kendaraans.length,
              itemBuilder: (context, index) {
                IconData kendaraan;
                if (kendaraans[index].kendaraan == "Motor") {
                  kendaraan = Icons.directions_bike;
                } else {
                  kendaraan = Icons.directions_car;
                }

                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    // Menghapus item dari daftar ketika di-swipe
                    kendaraans.removeAt(index);
                    // Menampilkan snackbar untuk memberi tahu pengguna bahwa item telah dihapus
                    // Scaffold.of(context).showSnackBar(
                    //   SnackBar(content: Text("Item deleted")),
                    // );
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                              selectedKendaraan:
                                  kendaraans[index]), // Navigasi ke DetailPage
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: lebar,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(70, 152, 138, 1),
                                ),
                                child: Icon(
                                  kendaraan,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Plat Nomor ${kendaraans[index].plat}"),
                                  Text(
                                      "Kendaraan ${kendaraans[index].kendaraan}"),
                                  Text(
                                      "Masa Berlaku ${kendaraans[index].masaBerlaku}")
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          kendaraan(), // Navigasi ke kendaraan
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
                  minimumSize:
                      const Size(250, 50), // Atur lebar dan tinggi button
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ), // Padding di sekitar icon dan teks
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15.0, // Mengatur radius untuk membuat button rounded
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: const Text(
                  'Tambah Kendaraan',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
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
