import 'package:flutter/material.dart';

class kendaraan extends StatefulWidget {
  const kendaraan({Key? key});

  @override
  State<kendaraan> createState() => _kendaraanState();
}

class _kendaraanState extends State<kendaraan> {
  final TextEditingController nama = TextEditingController();
  final TextEditingController jenis = TextEditingController();
  final TextEditingController merk = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController tahun = TextEditingController();
  final TextEditingController warna = TextEditingController();
  final TextEditingController noRangka = TextEditingController();
  final TextEditingController noMesin = TextEditingController();
  final TextEditingController noBPKB = TextEditingController();

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
            height: tinggi * 0.75,
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
                      _buildTextField(nama, 'Nama Pemilik'),
                      _buildTextField(jenis, 'Jenis Kendaraan'),
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
        child: FloatingActionButton.extended(
          onPressed: () {
            const mySnackBar = SnackBar(
              content: Text("Berhasil Simpan data"),
              duration: Duration(seconds: 3),
              padding: EdgeInsets.all(10),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
          },
          backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          label: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Text('Simpan'),
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
              color: Colors.green,
            ),
          ),
        ),
        maxLength: 50,
      ),
    );
  }
}
