// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final String brand = "Honda PCX";
  final String paint = "Hitam";
  final String year = "2018";
  final String type = "matic";
  final String cc = "150 CC";
  final String bbm = "Bensin";

  bool isNantiSajaSelected = false;
  bool isBayarSekarangSelected = false;

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brand,
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
                                year,
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
                                paint,
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
                                cc,
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
                                bbm,
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
                      const Row(
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
                              'Sepeda Motor',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
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
                              'Honda',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
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
                              'XXXXXXXXXXXXXXXXX',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
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
                              '00000000000000',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
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
                              '000000000000000',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
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
                              '0000000000000000',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
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
                              color: Colors.green,
                            ),
                          )
                        : null,
                  ),
                  child: Text(
                    'Nanti Saja',
                    style: TextStyle(
                      color: isNantiSajaSelected ? Colors.green : Colors.black,
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
                              color: Colors.green,
                            ),
                          )
                        : null,
                  ),
                  child: Text(
                    'Bayar Sekarang',
                    style: TextStyle(
                      color:
                          isBayarSekarangSelected ? Colors.green : Colors.black,
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
