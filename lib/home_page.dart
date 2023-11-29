// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    User? user = FirebaseAuth.instance.currentUser;

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
                    FutureBuilder<QuerySnapshot>(
                      // Mendapatkan koleksi data_diri dari dokumen pengguna dengan UID saat ini
                      future: FirebaseFirestore.instance
                          .collection('pengguna')
                          .doc(user?.uid)
                          .collection('data_diri')
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        var nama = snapshot.data!.docs[0]['nama'];
                        var kota = snapshot.data!.docs[0]['kota'];

                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                nama,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Kota $kota",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ]);
                      },
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
              width: lebar,
              margin: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Kendaraan Anda",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('pengguna')
                  .doc(user?.uid)
                  .collection('kendaraan')
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // return CircularProgressIndicator();
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('Tidak ada Kendaraan');
                }

                return ListView.builder(
                  shrinkWrap: true,
                  //physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var dataKendaraan = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    var jenisKendaraan = dataKendaraan['jenis'];
                    var plat = dataKendaraan['plat'];
                    var merk = dataKendaraan['merk'];

                    IconData kendaraan;
                    if (jenisKendaraan == "Motor") {
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
                        kendaraans.removeAt(index);
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(), // Navigasi ke DetailPage
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Plat Nomor $plat"),
                                      Text("Kendaraan $merk"),
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
    );
  }
}
