// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobi_tax/kendaraan.dart';
import 'package:provider/provider.dart';
import 'detail.dart';
import 'setting.dart';
import 'themeModeData.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Metode untuk memperbarui UI
  void refreshUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    User? user = FirebaseAuth.instance.currentUser;
    ThemeData selectedTheme = Provider.of<ThemeModeData>(context).getTheme();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 237, 237),
      appBar: AppBar(
        backgroundColor: selectedTheme.primaryColor,
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SettingsPage(),
                  ),
                );
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
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 90,
              width: lebar,
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
                // Mendapatkan koleksi data_diri dari dokumen pengguna dengan UID saat ini
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
                  var kota = snapshot.data!.docs[0]['kota'];

                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: 50,
                    height: 10,
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
                        SizedBox(width: 10), // Jarak antara ikon dan teks

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                nama,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Kota $kota",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
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
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('pengguna')
                    .doc(user?.uid)
                    .collection('kendaraan')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {}

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    //return Text('Tidak ada Kendaraan');
                    return const Center(
                      child: Text('Tidak ada Kendaraan'),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    //physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var idKendaraan = snapshot.data!.docs[index].id;
                      var dataKendaraan = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      var jenisKendaraan = dataKendaraan['jenis'];
                      var plat = dataKendaraan['plat'];
                      var merk = dataKendaraan['merk'];
                      var masa = dataKendaraan['masa'];

                      IconData iconKendaraan;
                      if (jenisKendaraan == "Motor") {
                        iconKendaraan = Icons.directions_bike;
                      } else {
                        iconKendaraan = Icons.directions_car;
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Konfirmasi'),
                                content: Text(
                                    'Apakah Anda yakin ingin menghapus kendaraan ini?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();

                                      // Perbarui UI dengan memanggil metode refreshUI
                                      refreshUI();
                                    },
                                    child: Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // Hapus dokumen dari Firestore
                                      var docRef = FirebaseFirestore.instance
                                          .collection('pengguna')
                                          .doc(user?.uid)
                                          .collection('kendaraan')
                                          .doc(snapshot.data!.docs[index].id);

                                      await docRef
                                          .delete(); // Perubahan di sini, menambahkan await

                                      // Tutup dialog setelah menghapus
                                      Navigator.of(context).pop();

                                      // Perbarui UI dengan memanggil metode refreshUI
                                      refreshUI();
                                    },
                                    child: Text('Hapus'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    DocumentId:
                                        idKendaraan), // Navigasi ke DetailPage
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: lebar,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey, // warna bayangan
                                      blurRadius: 5, // radius blur bayangan
                                      offset: Offset(0,
                                          0), // pergeseran bayangan (horizontal, vertical)
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: selectedTheme.primaryColor,
                                      ),
                                      child: Icon(
                                        iconKendaraan,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "$plat",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "$merk",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: selectedTheme.primaryColor,
                                              //fontWeight: FontWeight.bold
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 7),
                                          Text(
                                            "Masa Berlaku : ${masa.toString()} Hari",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => kendaraan(
                                              idKendaraan: idKendaraan,
                                              isEdit: true,
                                            ), // Navigasi ke kendaraan
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
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
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => kendaraan(
                        idKendaraan: "",
                        isEdit: false,
                      ), // Navigasi ke kendaraan
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedTheme.primaryColor,
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
