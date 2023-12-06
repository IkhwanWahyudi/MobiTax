// ignore_for_file: camel_case_types, library_private_types_in_public_api, use_key_in_widget_constructors

// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobi_tax/detailTransaksi.dart';
import 'package:provider/provider.dart';
import 'themeModeData.dart';

class transaksi extends StatefulWidget {
  @override
  _transaksiState createState() => _transaksiState();
}

class _transaksiState extends State<transaksi> {
  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    User? user = FirebaseAuth.instance.currentUser;
    ThemeData selectedTheme = Provider.of<ThemeModeData>(context).getTheme();
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: selectedTheme.primaryColor,
        elevation: 0,
        title: const Text(
          'Transaksi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      // backgroundColor: const Color.fromARGB(255, 240, 237, 237),
      body: Center(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('pengguna')
                    .doc(user?.uid)
                    .collection('kendaraan')
                    .where('status', isEqualTo: 'Sudah dibayar')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Data sedang dimuat');
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {}

                  double pajak = 0;

                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    if (snapshot.data!.docs[i]['transmisi'] < 100) {
                      pajak += 50000;
                    } else if (snapshot.data!.docs[i]['transmisi'] >= 100 &&
                        snapshot.data!.docs[i]['transmisi'] < 150) {
                      pajak += 200000;
                    } else if (snapshot.data!.docs[i]['transmisi'] >= 150 &&
                        snapshot.data!.docs[i]['transmisi'] < 200) {
                      pajak += 400000;
                    } else if (snapshot.data!.docs[i]['transmisi'] >= 200 &&
                        snapshot.data!.docs[i]['transmisi'] < 1000) {
                      pajak += 700000;
                    } else if (snapshot.data!.docs[i]['transmisi'] >= 1000 &&
                        snapshot.data!.docs[i]['transmisi'] < 2000) {
                      pajak += 1000000;
                    } else if (snapshot.data!.docs[i]['transmisi'] >= 2000) {
                      pajak += 2000000;
                    }
                  }

                  double biayaAdmin = pajak * 0.01;
                  double totalPajak = pajak + biayaAdmin;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 170,
                        // decoration: BoxDecoration(
                        //     color: Colors.blueGrey
                        // ),
                        child: Stack(
                          children: [
                            Container(
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: selectedTheme.primaryColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey, // warna bayangan
                                    blurRadius: 5, // radius blur bayangan
                                    offset: Offset(0,
                                        0), // pergeseran bayangan (horizontal, vertical)
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  // Pindah ke halaman lain saat kontainer diklik
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const detailTransaksi(), // Navigasi ke DetailTransaksi
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  height: tinggi * 0.8,
                                  //margin: const EdgeInsets.only(right: 40),
                                  margin: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey, // warna bayangan
                                        blurRadius: 5, // radius blur bayangan
                                        offset: Offset(0,
                                            0), // pergeseran bayangan (horizontal, vertical)
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Biaya Pajak Kendaraan',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          Container(
                                            child: Text(
                                              'Rp $pajak',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Biaya Admin',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          Container(
                                            child: Text(
                                              'Rp $biayaAdmin',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        height: 1, // Lebar garis
                                        //color: Colors.black, // Warna garis
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Total',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Container(
                                            child: Text(
                                              'Rp $totalPajak',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              alignment: Alignment.centerLeft,
              //padding: const EdgeInsets.all(20),
              child: const Text(
                'Detail Transaksi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey, // warna bayangan
                          blurRadius: 5, // radius blur bayangan
                          offset: Offset(0, 0), // pergeseran bayangan (horizontal, vertical)
                        ),
                      ],
                    ),
                    child: Text(
                      'Transaksi $index', // Ganti dengan data sesuai kebutuhan Anda
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),


            // Container(
            //   margin: const EdgeInsets.only(
            //       left: 10, top: 10, bottom: 20),
            //   //padding: const EdgeInsets.all(20),
            //   child: const Text(
            //     'Alamat Pengiriman',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 15,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   //margin: const EdgeInsets.only(right: 40),
            //   margin: const EdgeInsets.only(right: 10, left: 10),
            //   decoration: const BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(10),
            //     ),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey, // warna bayangan
            //         blurRadius: 5, // radius blur bayangan
            //         offset: Offset(0,
            //             0), // pergeseran bayangan (horizontal, vertical)
            //       ),
            //     ],
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Row(
            //         children: [
            //           Icon(
            //             CupertinoIcons.location,
            //             color: Colors.black,
            //           ),
            //           Padding(
            //             padding: EdgeInsets.only(left: 20),
            //             child: Text(
            //               'Rumah',
            //               style: TextStyle(
            //                   fontSize: 15, color: Colors.black),
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(
            //         height: 8,
            //       ),
            //       FutureBuilder<QuerySnapshot>(
            //         // Mendapatkan koleksi data_diri dari dokumen pengguna dengan UID saat ini
            //         future: FirebaseFirestore.instance
            //             .collection('pengguna')
            //             .doc(user?.uid)
            //             .collection('data_diri')
            //             .get(),
            //         builder: (BuildContext context,
            //             AsyncSnapshot<QuerySnapshot> snapshot) {
            //           if (snapshot.connectionState ==
            //               ConnectionState.waiting) {
            //             return const CircularProgressIndicator();
            //           }
            //
            //           var jalan = snapshot.data!.docs[0]['alamat'];
            //           var kecamatan =
            //               snapshot.data!.docs[0]['kecamatan'];
            //           var kota = snapshot.data!.docs[0]['kota'];
            //
            //           return Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 jalan,
            //                 style: const TextStyle(
            //                     fontSize: 15, color: Colors.black),
            //               ),
            //               const SizedBox(
            //                 height: 8,
            //               ),
            //               Text(
            //                 '$kecamatan, Kota $kota',
            //                 style: const TextStyle(
            //                     fontSize: 15, color: Colors.black),
            //               ),
            //             ],
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
