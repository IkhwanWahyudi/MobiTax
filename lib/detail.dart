// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final int selectedDocumentId;
  const DetailPage({Key? key, required this.selectedDocumentId})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    var selectedDocumentId = widget.selectedDocumentId;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Detail Kendaraan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 237, 237),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                //padding: const EdgeInsets.only(top: 20, left: 40),
                padding: const EdgeInsets.all(15),
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

                    if (!snapshot.hasData) {
                      return Text('Data kendaraan tidak ditemukan');
                    }

                    var dataKendaraan =
                    snapshot.data!.docs[selectedDocumentId].data()
                    as Map<String, dynamic>;
                    var brand = dataKendaraan['brand'];
                    var tahun = dataKendaraan['tahun'];
                    var warna = dataKendaraan['warna'];
                    var type = dataKendaraan['type'];
                    var transmisi = dataKendaraan['transmisi'];
                    var bbm = dataKendaraan['bbm'];
                    var jenis = dataKendaraan['jenis'];
                    var merk = dataKendaraan['merk'];
                    var rangka = dataKendaraan['rangka'];
                    var bpkb = dataKendaraan['bpkb'];
                    var mesin = dataKendaraan['mesin'];

                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            brand,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 30, // Atur ukuran ikon
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(70, 152, 138, 1),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.timer,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                    height: 5), // Jarak antara ikon dan teks
                                Text(
                                  tahun.toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            //const Spacer(),
                            Column(
                              children: [
                                Container(
                                  width: 30, // Atur ukuran ikon
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(70, 152, 138, 1),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.paintbrush,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                    height: 5), // Jarak antara ikon dan teks
                                Text(
                                  warna,
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            //const Spacer(),
                            Column(
                              children: [
                                Container(
                                  width: 30, // Atur ukuran ikon
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(70, 152, 138, 1),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.barcode,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                    height: 5), // Jarak antara ikon dan teks
                                Text(
                                  type,
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            //const Spacer(),
                            Column(
                              children: [
                                Container(
                                  width: 30, // Atur ukuran ikon
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(70, 152, 138, 1),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.speedometer,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                    height: 5), // Jarak antara ikon dan teks
                                Text(
                                  '${transmisi.toString()} CC',
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            // const Spacer(),
                            Column(
                              children: [
                                Container(
                                  width: 30, // Atur ukuran ikon
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(70, 152, 138, 1),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.flame,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                    height: 5), // Jarak antara ikon dan teks
                                Text(
                                  bbm,
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            //Spacer(),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Detail Informasi',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 117, 117, 117)
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Jenis',
                              style: TextStyle(fontSize: 15),
                            ),
                            Container(
                              child: Text(
                                jenis,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Merk',
                              style: TextStyle(fontSize: 15),
                            ),
                            Container(
                              child: Text(
                                merk,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tipe',
                              style: TextStyle(fontSize: 15),
                            ),
                            Container(
                              child: Text(
                                type,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No. Rangka',
                              style: TextStyle(fontSize: 15),
                            ),
                            Container(
                              child: Text(
                                rangka.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No. Mesin',
                              style: TextStyle(fontSize: 15),
                            ),
                            Container(
                              child: Text(
                                mesin.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No. BPKB',
                              style: TextStyle(fontSize: 15),
                            ),
                            Container(
                              child: Text(
                                bpkb.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            )
          ),

          // Tombol Bayar
          Container(
            width: double.infinity,
            height: 60,
            padding: const EdgeInsets.all(10.0),
            // color: Colors.white,
            child: ElevatedButton(
              onPressed: () {
                // Logika ketika tombol Bayar ditekan
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(70, 152, 138, 1),
              ),
              child: Text(
                'Bayar',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
