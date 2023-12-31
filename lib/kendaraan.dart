import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'themeModeData.dart';

class kendaraan extends StatefulWidget {
  bool isEdit;
  String idKendaraan;

  kendaraan({super.key, required this.idKendaraan, required this.isEdit});

  @override
  State<kendaraan> createState() => _kendaraanState();
}

class _kendaraanState extends State<kendaraan> {
  final TextEditingController plat = TextEditingController();
  final TextEditingController jenis = TextEditingController();
  final TextEditingController merk = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController warna = TextEditingController();
  final TextEditingController bbm = TextEditingController();
  final TextEditingController transmisi = TextEditingController();
  final TextEditingController brand = TextEditingController();
  final TextEditingController noRangka = TextEditingController();
  final TextEditingController noMesin = TextEditingController();
  final TextEditingController noBPKB = TextEditingController();
  final TextEditingController selectedYearController = TextEditingController();
  final List<int> availableYears =
      List.generate(20, (index) => DateTime.now().year - index);
  int selectedYear = DateTime.now().year;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // supaya inputan textfield plat kendaraan selalu uppercase
    plat.addListener(() {
      final currentText = plat.text;
      final uppercaseText = currentText.toUpperCase();

      if (currentText != uppercaseText) {
        plat.text = uppercaseText;
        plat.selection = TextSelection.fromPosition(
          TextPosition(offset: plat.text.length),
        );
      }
    });
  }

  Future<void> tambahKendaraan() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      // =========== VALIDASI INPUT KENDARAAN ===============
      if (jenis.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Peringatan'),
              content: const Text('Jenis kendaraan masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else if (selectedYearController.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Peringatan'),
              content: const Text('Tahun Kepemilikan masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

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
        'type': type.text,
        'tahun': int.parse(selectedYearController.text),
        'warna': warna.text,
        'rangka': noRangka.text,
        'mesin': noMesin.text,
        'bpkb': noBPKB.text,
        'brand': brand.text,
        'transmisi': int.tryParse(transmisi.text) ?? 0,
        'bbm': bbm.text,
        'status': 'Belum Terbayar',
        'masa': 30
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kendaraan berhasil ditambahkan")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan. Silakan coba lagi.")),
      );
    }
  }

  Future<void> editKendaraan() async {
    String selectedDocumentId = widget.idKendaraan;

    if (!_formKey.currentState!.validate()) return;
    try {
      // =========== VALIDASI INPUT KENDARAAN ===============
      if (jenis.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Peringatan'),
              content: const Text('Jenis kendaraan masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else if (selectedYearController.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Peringatan'),
              content: const Text('Tahun Kepemilikan masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      // Dapatkan UID pengguna yang saat ini terautentikasi
      String uidPengguna = FirebaseAuth.instance.currentUser!.uid;

      // Tambahkan data kendaraan ke dokumen Firestore pengguna
      await FirebaseFirestore.instance
          .collection('pengguna')
          .doc(uidPengguna)
          .collection('kendaraan')
          .doc(selectedDocumentId)
          .update({
        'plat': plat.text,
        'jenis': jenis.text,
        'merk': merk.text,
        'type': type.text,
        'tahun': int.parse(selectedYearController.text),
        'warna': warna.text,
        'rangka': noRangka.text,
        'mesin': noMesin.text,
        'bpkb': noBPKB.text,
        'brand': brand.text,
        'transmisi': int.tryParse(transmisi.text) ?? 0,
        'bbm': bbm.text
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kendaraan berhasil diubah")),
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
    ThemeData selectedTheme = Provider.of<ThemeModeData>(context).getTheme();
    bool isEdit = widget.isEdit;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: selectedTheme.primaryColor,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          isEdit ? 'Edit Kendaraan' : 'Tambah Kendaraan',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 237, 237),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _textfield(plat, 'Nomor Plat Kendaraan', 'plat'),
                      _buildDropdown(jenis, 'Jenis Kendaraan'),
                      const SizedBox(
                        height: 15,
                      ),
                      _textfield(merk, 'Merk Kendaraan', 'merk'),
                      _textfield(bbm, 'Bahan Bakar Kendaraan', 'bbm'),
                      _buildNumericTextField(
                          transmisi, 'Transmisi Kendaraan (CC)', 'transmisi'),
                      _textfield(brand, 'Brand Kendaraan', 'brand'),
                      _textfield(type, 'Tipe Kendaraan', 'type'),
                      _dropdownYear(
                          selectedYearController, 'Tahun Kepemilikan'),
                      const SizedBox(
                        height: 15,
                      ),
                      _textfield(warna, 'Warna Kendaraan', 'warna'),
                      _buildNumericTextField(noRangka, 'No. Rangka', 'rangka'),
                      _buildNumericTextField(noMesin, 'No. Mesin', 'mesin'),
                      _buildNumericTextField(noBPKB, 'No. BPKB', 'bpkb'),
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
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              if (isEdit) {
                editKendaraan();
              } else {
                tambahKendaraan();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedTheme.primaryColor,
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

  //======= WIDGET TEXT FIELD ============
  Widget _textfield(
      TextEditingController controller, String labelText, String field) {
    int jumlahKarakter = 100;
    bool isEdit = widget.isEdit;
    String uidPengguna = FirebaseAuth.instance.currentUser!.uid;
    String selectedDocumentId = widget.idKendaraan;

    if (labelText == 'Nomor Plat Kendaraan' ||
        labelText == 'Bahan Bakar Kendaraan' ||
        labelText == 'Warna Kendaraan') {
      jumlahKarakter = 10;
    } else if (labelText == 'Merk Kendaraan' ||
        labelText == 'Brand Kendaraan' ||
        labelText == 'Tipe Kendaraan') {
      jumlahKarakter = 15;
    }
    if (isEdit) {
      return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('pengguna')
              .doc(uidPengguna)
              .collection('kendaraan')
              .doc(selectedDocumentId)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Tampilkan loading spinner atau indikator lainnya jika data masih dimuat
              return const CircularProgressIndicator();
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.text = data[field];

            return Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '$labelText wajib diisi';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: labelText,
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                ),
                maxLength: jumlahKarakter,
              ),
            );
          });
    } else {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$labelText wajib diisi';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(),
            // focusedBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color:
            //     Color(0xFF183D3D), // Warna outline saat dalam keadaan fokus
            //   ),
            // ),
          ),
          maxLength: jumlahKarakter,
        ),
      );
    }
  }

  Widget _buildNumericTextField(
      TextEditingController controller, String labelText, String field) {
    int jumlahKarakter = 100;
    bool isEdit = widget.isEdit;
    String uidPengguna = FirebaseAuth.instance.currentUser!.uid;
    String selectedDocumentId = widget.idKendaraan;
    if (labelText == 'Transmisi Kendaraan (CC)') {
      jumlahKarakter = 5;
    } else if (labelText == 'No. Rangka' ||
        labelText == 'No. Mesin' ||
        labelText == 'No. BPKB') {
      jumlahKarakter = 15;
    }

    if (isEdit) {
      return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('pengguna')
              .doc(uidPengguna)
              .collection('kendaraan')
              .doc(selectedDocumentId)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Tampilkan loading spinner atau indikator lainnya jika data masih dimuat
              return const CircularProgressIndicator();
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.text = data[field].toString();

            return Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '$labelText wajib diisi';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: labelText,
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                ),
                maxLength: jumlahKarakter,
              ),
            );
          });
    } else {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(
              decimal: false, signed: false),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$labelText wajib diisi';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(),
          ),
          maxLength: jumlahKarakter,
        ),
      );
    }
  }

  //==========WIDGET DROPDOWN============
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
            controller.text = value;
          }
        },
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _dropdownYear(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: DropdownButtonFormField<String>(
        value: controller.text.isEmpty ? null : controller.text,
        items: availableYears.map((year) {
          return DropdownMenuItem<String>(
            value: year.toString(),
            child: Text('$year'),
          );
        }).toList(),
        onChanged: (String? value) {
          if (value != null) {
            controller.text = value;
          }
        },
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
