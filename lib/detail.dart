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
  bool isNantiSajaSelected = false;
  bool isBayarSekarangSelected = false;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    var selectedDocumentId = widget.selectedDocumentId;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          const Expanded(
            child: SingleChildScrollView(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  'Detail',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  'Kendaraan',
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
                height: tinggi * 0.69,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 40),
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
                      // var brand = dataKendaraan['brand'];
                      var tahun = dataKendaraan['tahun'];
                      var warna = dataKendaraan['warna'];
                      var type = dataKendaraan['type'];
                      // var transmisi= dataKendaraan['transmisi'];
                      // var bbm = dataKendaraan['bbm'];
                      var jenis = dataKendaraan['jenis'];
                      var merk = dataKendaraan['merk'];
                      var rangka = dataKendaraan['rangka'];
                      var bpkb = dataKendaraan['bpkb'];
                      var mesin = dataKendaraan['mesin'];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'brand',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
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
                                    tahun,
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
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
                              const Spacer(),
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
                              const Spacer(),
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
                                    'CC',
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
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
                                    "bbm",
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Detail Informasi',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 117, 117, 117)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nama Pemilik',
                                style: TextStyle(fontSize: 15),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  'Nana',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jenis',
                                style: TextStyle(fontSize: 15),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  jenis,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Merk',
                                style: TextStyle(fontSize: 15),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  merk,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tipe',
                                style: TextStyle(fontSize: 15),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  type,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'No. Rangka',
                                style: TextStyle(fontSize: 15),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  rangka,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'No. Mesin',
                                style: TextStyle(fontSize: 15),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  mesin,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'No. BPKB',
                                style: TextStyle(fontSize: 15),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  bpkb,
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
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isNantiSajaSelected = !isNantiSajaSelected;
                  isBayarSekarangSelected = false;
                });
              },
              child: SizedBox(
                height: 60.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                  decoration: BoxDecoration(
                    border: isNantiSajaSelected
                        ? const Border(
                            bottom: BorderSide(
                              width: 4.0,
                              color: Color(0xFF183D3D),
                            ),
                          )
                        : null,
                  ),
                  child: Text(
                    'Nanti Saja',
                    style: TextStyle(
                      color: isNantiSajaSelected
                          ? Color(0xFF183D3D)
                          : Colors.black,
                      fontWeight: isNantiSajaSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isBayarSekarangSelected = !isBayarSekarangSelected;
                  isNantiSajaSelected = false;
                });
              },
              child: SizedBox(
                height: 60.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                  decoration: BoxDecoration(
                    border: isBayarSekarangSelected
                        ? const Border(
                            bottom: BorderSide(
                              width: 4.0,
                              color: Color(0xFF183D3D),
                            ),
                          )
                        : null,
                  ),
                  child: Text(
                    'Bayar Sekarang',
                    style: TextStyle(
                      color: isBayarSekarangSelected
                          ? Color(0xFF183D3D)
                          : Colors.black,
                      fontWeight: isBayarSekarangSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
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
