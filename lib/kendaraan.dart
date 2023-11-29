import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class kendaraan extends StatefulWidget {
  const kendaraan({Key? key});

  @override
  State<kendaraan> createState() => _kendaraanState();
}

class _kendaraanState extends State<kendaraan> {
  final TextEditingController plat = TextEditingController();
  final TextEditingController jenis = TextEditingController();
  final TextEditingController merk = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController tahun = TextEditingController();
  final TextEditingController warna = TextEditingController();
  final TextEditingController noRangka = TextEditingController();
  final TextEditingController noMesin = TextEditingController();
  final TextEditingController noBPKB = TextEditingController();

  Future<void> tambahKendaraan() async {
    try {
      // Dapatkan UID pengguna yang saat ini terautentikasi
      String uidPengguna = FirebaseAuth.instance.currentUser!.uid;

      // Tambahkan data kendaraan ke dokumen Firestore pengguna
      await FirebaseFirestore.instance
          .collection('pengguna')
          .doc(uidPengguna)
          .collection('kendaraan')
          .add({
        'plat': plat.text,
        'jenis': jenis.text,
        'merk': merk.text,
      });

      // Data kendaraan sekarang disimpan dalam dokumen Firestore pengguna

      // Tampilkan pesan sukses atau pindah ke halaman lain jika diperlukan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kendaraan berhasil ditambahkan")),
      );

      // Anda juga bisa pindah ke halaman lain setelah berhasil menambahkan kendaraan
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HalamanBerikutnya()));
    } catch (e) {
      // Tangani kesalahan saat menambahkan kendaraan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan. Silakan coba lagi.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Kendaraan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
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
            child: Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildTextField(plat, 'Nomor Plat Kendaraan'),
                      _buildDropdown(jenis, 'Jenis Kendaraan'),
                      const SizedBox(
                        height: 15,
                      ),
                      _buildTextField(merk, 'Merk Kendaraan'),
                      _buildTextField(type, 'Tipe Kendaraan'),
                      _buildTextField(tahun, 'Tahun Kepemilikan'),
                      _buildTextField(warna, 'Warna Kendaraan'),
                      _buildTextField(noRangka, 'No. Rangka'),
                      _buildTextField(noMesin, 'No. Mesin'),
                      _buildTextField(noBPKB, 'No. BPKB'),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              tambahKendaraan();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
              minimumSize: const Size(250, 50), // Atur lebar dan tinggi button
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  15.0, // Mengatur radius untuk membuat button rounded
                ),
              ),
            ),
            child: const Text(
              'Simpan',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  Color(0xFF183D3D), // Warna outline saat dalam keadaan fokus
            ),
          ),
        ),
        maxLength: 50,
      ),
    );
  }

  Widget _buildDropdown(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: DropdownButtonFormField<String>(
        value: controller.text.isEmpty ? null : controller.text,
        items: const [
          DropdownMenuItem<String>(
            value: 'Motor',
            child: Text('Motor'),
          ),
          DropdownMenuItem<String>(
            value: 'Mobil',
            child: Text('Mobil'),
          ),
        ],
        onChanged: (String? value) {
          if (value != null) {
            setState(() {
              controller.text = value;
            });
          }
        },
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF183D3D),
            ),
          ),
        ),
      ),
    );
  }
}
