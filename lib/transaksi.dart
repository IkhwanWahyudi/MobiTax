// ignore_for_file: camel_case_types, library_private_types_in_public_api, use_key_in_widget_constructors

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

    return Scaffold(
      backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
      // appBar: AppBar(
      //   backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
      // ),
      body: Column(
        children: <Widget>[
          const Expanded(
            child: SingleChildScrollView(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  'Detail',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  'Transaksi',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(left: 40),
              //   child: Text(
              //     'Detail',
              //     style: TextStyle(fontSize: 10, color: Colors.white),
              //     textAlign: TextAlign.left,
              //   ),
              // ),
              // const Padding(
              //   padding: EdgeInsets.only(left: 40),
              //   child: Text(
              //     'Transaksi',
              //     style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white),
              //     textAlign: TextAlign.left,
              //   ),
              // ),
              const SizedBox(height: 30),
              Container(
                width: lebar,
                height: tinggi * 0.69,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 240, 237, 237),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  //padding: const EdgeInsets.only(top: 20, left: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                        //padding: const EdgeInsets.all(20),
                        child: Text(
                          'Transaksi',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      // const Text(
                      //   'Transaksi',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        //margin: const EdgeInsets.only(right: 40),
                        margin: EdgeInsets.only(right: 10, left: 10),
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
                          ],
                        ),
                      ),
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
