// ignore_for_file: camel_case_types, library_private_types_in_public_api, use_key_in_widget_constructors

// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
      body: Column(
        children: <Widget>[
          const Expanded(
            child: SingleChildScrollView(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  'Detail',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  'Transaksi',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: lebar,
                height: tinggi * 0.74,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 240, 237, 237),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, top: 20, bottom: 20),
                        //padding: const EdgeInsets.all(20),
                        child: const Text(
                          'Transaksi',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        //margin: const EdgeInsets.only(right: 40),
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: const Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Biaya Pajak Kendaraan',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    'Rp 00',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Biaya Admin',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    'Rp 00',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    'Rp 00',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, top: 20, bottom: 20),
                        //padding: const EdgeInsets.all(20),
                        child: const Text(
                          'Alamat Pengiriman',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        //margin: const EdgeInsets.only(right: 40),
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(CupertinoIcons.location),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Rumah',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
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
                                  return const CircularProgressIndicator();
                                }

                                var jalan = snapshot.data!.docs[0]['alamat'];
                                var kecamatan =
                                    snapshot.data!.docs[0]['kecamatan'];
                                var kota = snapshot.data!.docs[0]['kota'];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      jalan,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '$kecamatan, Kota $kota',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Logika ketika tombol ditekan
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(70, 152, 138, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                    width: 8), // Jarak antara ikon dan teks
                                Text(
                                  'E-TBPKB',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Logika ketika tombol ditekan
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(70, 152, 138, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                    width: 8), // Jarak antara ikon dan teks
                                Text(
                                  'E-STNK',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
