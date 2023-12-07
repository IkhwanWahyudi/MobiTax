// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themeModeData.dart';

class DetailPage extends StatefulWidget {
  final String DocumentId;
  const DetailPage({Key? key, required this.DocumentId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  User? user = FirebaseAuth.instance.currentUser;

  void refreshUI() {
    setState(() {});
  }

  Future<void> bayar(String id, int masa) async {
    try {
      // Dapatkan UID pengguna yang saat ini terautentikasi
      String uidPengguna = FirebaseAuth.instance.currentUser!.uid;

      // Mendapatkan tanggal saat ini
      DateTime now = DateTime.now();

      // Memformat tanggal dengan format "dd-MM-yyyy"
      String formattedDate =
          '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';

      masa += 365;

      // Mendapatkan koleksi data_diri dari dokumen pengguna dengan UID saat ini
      await FirebaseFirestore.instance
          .collection('pengguna')
          .doc(uidPengguna)
          .collection('kendaraan')
          .doc(id)
          .update({
        'status': 'Sudah dibayar',
        'tanggal_pembayaran': formattedDate,
        'masa': masa
        // Tambahkan field lain yang ingin Anda update
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pajak berhasil dibayar")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan. Silakan coba lagi.")),
      );
    }
  }
  
  Future<void> batal(String id, int masa) async {
    try {
      // Dapatkan UID pengguna yang saat ini terautentikasi
      String uidPengguna = FirebaseAuth.instance.currentUser!.uid;

      masa -= 365;

      // Mendapatkan koleksi data_diri dari dokumen pengguna dengan UID saat ini
      await FirebaseFirestore.instance
          .collection('pengguna')
          .doc(uidPengguna)
          .collection('kendaraan')
          .doc(id)
          .update({
        'status': 'Belum Terbayar',
        'tanggal_pembayaran': "",
        'masa': masa
        // Tambahkan field lain yang ingin Anda update
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pajak berhasil dibayar")),
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
    var selectedDocumentId = widget.DocumentId;
    int pajak = 0;
    ThemeData selectedTheme = Provider.of<ThemeModeData>(context).getTheme();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: selectedTheme.primaryColor,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Detail Kendaraan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 237, 237),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('pengguna')
              .doc(user?.uid)
              .collection('kendaraan')
              .doc(selectedDocumentId)
              .get(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (!snapshot.hasData) {
              return Text('Data kendaraan tidak ditemukan');
            }

            var dataKendaraan = snapshot.data!.data() as Map<String, dynamic>;
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
            var masa = dataKendaraan['masa'];

            bool isTerbayar = false;

            if (dataKendaraan['status'] == 'Sudah dibayar') {
              isTerbayar = true;
            } else {
              isTerbayar = false;
            }

            return Column(
              children: <Widget>[
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
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
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedTheme.primaryColor,
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
                            Column(
                              children: [
                                Container(
                                  width: 30, // Atur ukuran ikon
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedTheme.primaryColor,
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
                            Column(
                              children: [
                                Container(
                                  width: 30, // Atur ukuran ikon
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedTheme.primaryColor,
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
                            Column(
                              children: [
                                Container(
                                  width: 30, // Atur ukuran ikon
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedTheme.primaryColor,
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
                            Column(
                              children: [
                                Container(
                                  width: 30, // Atur ukuran ikon
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedTheme.primaryColor,
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
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Detail Informasi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: selectedTheme.primaryColor,
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
                    ),
                  ),
                )),

                // Tombol Bayar
                Container(
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.all(10.0),
                  // color: Colors.white,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!isTerbayar) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            if (transmisi < 100) {
                              pajak = 50000;
                            } else if (transmisi >= 100 && transmisi < 150) {
                              pajak = 200000;
                            } else if (transmisi >= 150 && transmisi < 200) {
                              pajak = 400000;
                            } else if (transmisi >= 200 && transmisi < 1000) {
                              pajak = 700000;
                            } else if (transmisi >= 1000 && transmisi < 2000) {
                              pajak = 1000000;
                            } else if (transmisi >= 2000) {
                              pajak = 2000000;
                            }
                            return AlertDialog(
                              title: Text('Pembayaran'),
                              content: Text(
                                  'Total pajak yang perlu dibayarkan : Rp. $pajak'),
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
                                    // Tutup dialog setelah menghapus
                                    bayar(selectedDocumentId, masa);
                                    Navigator.of(context).pop();

                                    // Perbarui UI dengan memanggil metode refreshUI
                                    refreshUI();
                                  },
                                  child: Text('Proses'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            if (transmisi < 100) {
                              pajak = 50000;
                            } else if (transmisi >= 100 && transmisi < 150) {
                              pajak = 200000;
                            } else if (transmisi >= 150 && transmisi < 200) {
                              pajak = 400000;
                            } else if (transmisi >= 200 && transmisi < 1000) {
                              pajak = 700000;
                            } else if (transmisi >= 1000 && transmisi < 2000) {
                              pajak = 1000000;
                            } else if (transmisi >= 2000) {
                              pajak = 2000000;
                            }
                            return AlertDialog(
                              title: Text('Pemberitahuan'),
                              content: Text(
                                  'Anda yakin ingin membatalkan proses pembayaran pajak?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                    // Perbarui UI dengan memanggil metode refreshUI
                                    refreshUI();
                                  },
                                  child: Text('Tidak'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // Tutup dialog setelah menghapus
                                    batal(selectedDocumentId, masa);
                                    Navigator.of(context).pop();

                                    // Perbarui UI dengan memanggil metode refreshUI
                                    refreshUI();
                                  },
                                  child: Text('Yakin'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isTerbayar ? Colors.grey : selectedTheme.primaryColor,
                    ),
                    child: Text(
                      isTerbayar?
                      'Batal Proses':'Proses',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
