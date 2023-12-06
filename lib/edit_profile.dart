// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // final TextEditingController _nikController = TextEditingController();
  // final TextEditingController _namaController = TextEditingController();
  // final TextEditingController _alamatController = TextEditingController();
  // final TextEditingController _kecamatanController = TextEditingController();
  // final TextEditingController _kotaController = TextEditingController();
  // Define controllers for each TextField
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Inisialisasi nilai controller dengan data dari akun saat ini
    getUserData();
  }

  // Mengambil data dari akun saat ini dan mengisi nilai controller
  void getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    var snapshot = await FirebaseFirestore.instance
        .collection('pengguna')
        .doc(user?.uid)
        .collection('data_diri')
        .get();

    var data = snapshot.docs[0].data();

    setState(() {
      _nikController.text = data['nik'];
      _namaController.text = data['nama'];
      _alamatController.text = data['alamat'];
      _kecamatanController.text = data['kecamatan'];
      _kotaController.text = data['kota'];
    });
  }

  Future<void> editDataDiri() async {
    try {
      if (!_formKey.currentState!.validate()) return;
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
        'nik': _nikController.text,
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
            'Edit Profil',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 70,
                  child: Row(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama Lengkap wajib diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Nama Lengkap',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 70,
                child: Row(
                  children: [
                    Icon(
                      Icons.credit_card,
                      color: Color.fromRGBO(70, 152, 138, 1),
                      size: 30,
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: TextFormField(
                        controller: _nikController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'NIK wajib diisi';
                          } else if (value.length < 15) {
                            return 'NIK setidaknya sebanyak 15 karakter';
                          }
                          return null; // Return null for no validation errors
                        },
                        decoration: InputDecoration(
                          labelText: 'NIK',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 70,
                child: Row(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Alamat wajib diisi';
                          }
                          return null; // Return null for no validation errors
                        },
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 70,
                child: Row(
                  children: [
                    Icon(
                      Icons.my_location_outlined,
                      color: Color.fromRGBO(70, 152, 138, 1),
                      size: 30,
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: TextFormField(
                        autocorrect: true,
                        controller: _kecamatanController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kecamatan wajib diisi';
                          }
                          return null; // Return null for no validation errors
                        },
                        decoration: InputDecoration(
                          labelText: 'Kecamatan',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 70,
                child: Row(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kota wajib diisi';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Kota',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
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
                  onPressed: () => editDataDiri(),
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
          ),
        ));
  }
}
