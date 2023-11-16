// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'detail.dart';

class Kendaraan {
// class Kendaraan
  String kendaraan, plat, masa_berlaku;

  Kendaraan(this.kendaraan, this.plat, this.masa_berlaku);
}

List<Kendaraan> kendaraans = [
// list untuk menampung semua inputan/produk
  Kendaraan("1", "1", "1"),
  Kendaraan("2", "2", "2"),
  Kendaraan("3", "3", "3"),
  Kendaraan("4", "4", "4"),
  Kendaraan("5", "5", "5"),
  Kendaraan("6", "6", "6"),
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
                    offset: Offset(0, 0), // pergeseran bayangan (horizontal, vertical)
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
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Dhimas Eko Wiyono",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Kota Samarinda",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
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
                    // Menambahkan fungsi GestureDetector untuk navigasi
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Color.fromARGB(255, 240, 237, 237),
                        child: Icon(Icons.delete, color: Color.fromRGBO(70, 152, 138, 1)),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
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
                              builder: (context) =>
                                  DetailPage(), // Navigasi ke DetailPage
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
                                      Icons.directions_bike,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "Plat Nomor ${kendaraans[index].plat}"),
                                        Text(
                                            "Kendaraan ${kendaraans[index].kendaraan}"),
                                        Text(
                                            "Masa Berlaku ${kendaraans[index].masa_berlaku}")
                                      ],
                                    ),
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
              margin: EdgeInsets.all(
                  10), // Tambahkan margin pada Container jika diinginkan
              child: ElevatedButton.icon(
                onPressed: () {
                  // Logika ketika tombol ditekan
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
                  minimumSize:
                  const Size(150, 50), // Atur lebar dan tinggi button
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
                icon: const Icon(Icons.add),
                label: const Text('Tambah Kendaraan'),
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