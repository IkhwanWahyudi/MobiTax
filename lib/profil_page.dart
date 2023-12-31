// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobi_tax/edit_profile.dart';
import 'package:mobi_tax/sign_in.dart';
import 'package:provider/provider.dart';
import 'themeModeData.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key});

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    User? user = FirebaseAuth.instance.currentUser;
    ThemeData selectedTheme = Provider.of<ThemeModeData>(context).getTheme();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 237, 237),
      appBar: AppBar(
        backgroundColor: selectedTheme.primaryColor,
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
            Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: selectedTheme.primaryColor,
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
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('pengguna')
                      .doc(user?.uid)
                      .collection('data_diri')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    var nama = snapshot.data!.docs[0]['nama'];
                    var nik = snapshot.data!.docs[0]['nik'];

                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
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
                          SizedBox(width: 10),
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    nik,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
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
                                  ),
                                ],
                              )),
                              IconButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => SignIn(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                    );
                  },
                )),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                // Mendapatkan koleksi data_diri dari dokumen pengguna dengan UID saat ini
                stream: FirebaseFirestore.instance
                    .collection('pengguna')
                    .doc(user?.uid)
                    .collection('data_diri')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Data sedang dimuat');
                  }

                  var nama = snapshot.data!.docs[0]['nama'];
                  var alamat = snapshot.data!.docs[0]['alamat'];
                  var kecamatan = snapshot.data!.docs[0]['kecamatan'];
                  var kota = snapshot.data!.docs[0]['kota'];

                  return ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                        height: 60,
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: selectedTheme.primaryColor,
                              size: 30,
                            ),
                            SizedBox(width: 30),
                            Expanded(
                              child: Text(
                                nama,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1, // Lebar garis
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 60,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: selectedTheme.primaryColor,
                              size: 30,
                            ),
                            SizedBox(width: 30), // Jarak antara ikon dan teks
                            Expanded(
                              child: Text(
                                alamat,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1, // Lebar garis
                        //color: Colors.black, // Warna garis
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        //margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        height: 60,
                        child: Row(
                          children: [
                            Icon(
                              Icons.my_location_outlined,
                              color: selectedTheme.primaryColor,
                              size: 30,
                            ),
                            SizedBox(width: 30), // Jarak antara ikon dan teks
                            Expanded(
                              child: Text(
                                kecamatan,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1, // Lebar garis
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 60,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_city_outlined,
                              color: selectedTheme.primaryColor,
                              size: 30,
                            ),
                            SizedBox(width: 30), // Jarak antara ikon dan teks
                            Expanded(
                              child: Text(
                                'Kota $kota',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1, // Lebar garis
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProfile(), // Navigasi ke edit_profile
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedTheme.primaryColor,
                            fixedSize: Size(lebar, 40),
                          ),
                          child: Text(
                            'Edit Profil',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
