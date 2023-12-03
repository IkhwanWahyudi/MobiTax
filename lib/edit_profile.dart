// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();

  Future<void> editDataDiri() async {
    try {
      // Dapatkan UID pengguna yang saat ini terautentikasi
      String uidPengguna = FirebaseAuth.instance.currentUser!.uid;

// Mendapatkan koleksi data_diri dari dokumen pengguna dengan UID saat ini
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('pengguna')
          .doc(uidPengguna)
          .collection('data_diri')
          .get();
      // Mengambil ID dokumen dari dokumen pertama dalam koleksi
      String idDokumenDataDiri = querySnapshot.docs[0].id;
      await FirebaseFirestore.instance
          .collection('pengguna')
          .doc(uidPengguna)
          .collection('data_diri')
          .doc(idDokumenDataDiri)
          .update({
        'nama': _namaController.text,
        'alamat': _alamatController.text,
        'kota': _kotaController.text,
        'kecamatan': _kecamatanController.text,
        // Tambahkan field lain yang ingin Anda update
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data diri berhasil diubah")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan. Silakan coba lagi.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    // var tinggi = MediaQuery.of(context).size.height;
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      //backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
      backgroundColor: const Color.fromARGB(255, 240, 237, 237),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(70, 152, 138, 1),
        elevation: 0,
        title: Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const Expanded(
            //   child: SingleChildScrollView(),
            // ),
            Container(
              height: 90,
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
                //margin: EdgeInsets.only(left: 10, right: 10),
                //margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                //margin: EdgeInsets.all(10),
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

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Center(
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.black,
                                  size: 40,
                                ),
                              ),
                            ),
                            SizedBox(width: 10), // Jarak antara ikon dan teks
                            Container(
                              width: 230,
                              // decoration: BoxDecoration(
                              //   color: Colors.blue,
                              // ),
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Id Pengguna',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                    //textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    nama,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    //textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 70,
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Color.fromRGBO(70, 152, 138, 1),
                            size: 30,
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: TextFormField(
                              controller: _namaController,
                              decoration: InputDecoration(
                                labelText: 'Nama Lengkap',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 15)
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 70,
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Color.fromRGBO(70, 152, 138, 1),
                            size: 30,
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: TextFormField(
                              controller: _alamatController,
                              decoration: InputDecoration(
                                labelText: 'Alamat',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 15)
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 70,
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.my_location_outlined,
                            color: Color.fromRGBO(70, 152, 138, 1),
                            size: 30,
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: TextFormField(
                              controller: _kecamatanController,
                              decoration: InputDecoration(
                                labelText: 'Kecamatan',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 15)
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 70,
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.location_city_outlined,
                            color: Color.fromRGBO(70, 152, 138, 1),
                            size: 30,
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: TextFormField(
                              controller: _kotaController,
                              decoration: InputDecoration(
                                labelText: 'Kota',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 15)
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      editDataDiri();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(70, 152, 138, 1),
                      // padding: EdgeInsets.symmetric(vertical: 15), // Button padding
                      fixedSize: Size(lebar, 40),
                    ),
                    child: Text(
                      'Update Data',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
