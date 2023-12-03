import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final TextEditingController warna = TextEditingController();
  final TextEditingController bbm = TextEditingController();
  final TextEditingController transmisi = TextEditingController();
  final TextEditingController brand = TextEditingController();
  final TextEditingController noRangka = TextEditingController();
  final TextEditingController noMesin = TextEditingController();
  final TextEditingController noBPKB = TextEditingController();
  final TextEditingController selectedYearController = TextEditingController();
  final List<int> availableYears = List.generate(20, (index) => DateTime.now().year - index);
  int selectedYear = DateTime.now().year;

  // Future<void> tambahKendaraan() async {
  //   try {
  //     // Dapatkan UID pengguna yang saat ini terautentikasi
  //     String uidPengguna = FirebaseAuth.instance.currentUser!.uid;
  //
  //     // Tambahkan data kendaraan ke dokumen Firestore pengguna
  //     await FirebaseFirestore.instance
  //         .collection('pengguna')
  //         .doc(uidPengguna)
  //         .collection('kendaraan')
  //         .add({
  //       'plat': plat.text,
  //       'jenis': jenis.text,
  //       'merk': merk.text,
  //       'type': type.text,
  //       'tahun': selectedYear,
  //       'warna': warna.text,
  //       'rangka': int.tryParse(noRangka.text) ?? 0,
  //       'mesin': int.tryParse(noMesin.text) ?? 0,
  //       'bpkb': int.tryParse(noBPKB.text) ?? 0,
  //       'brand': brand.text,
  //       'transmisi': int.tryParse(transmisi.text) ?? 0,
  //       'bbm': bbm.text,
  //     });
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Kendaraan berhasil ditambahkan")),
  //     );
  //
  //     Navigator.pop(context);
  //     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HalamanBerikutnya()));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Terjadi kesalahan. Silakan coba lagi.")),
  //     );
  //   }
  // }

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
    try {
      // =========== VALIDASI INPUT KENDARAAN ===============
      if (plat.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text('Plat masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else if (jenis.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text('Jenis kendaraan masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else if (merk.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text('Merek kendaraan masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else if (bbm.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text('Bahan Bakar kendaraan masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else if (transmisi.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text('Transmisi kendaraan masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else if (brand.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text('Brand kendaraan masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else if (type.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text('Tipe kendaraan masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
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
              title: Text('Peringatan'),
              content: Text('Tahun Kepemilikan masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else if (warna.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text('Warna Kendaraan masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else if (noRangka.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text('Nomor Rangka masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else if (noMesin.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text('Nomor Mesin masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else if (noBPKB.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text('Nomor BPKB masih kosong.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
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
        'rangka': int.tryParse(noRangka.text) ?? 0,
        'mesin': int.tryParse(noMesin.text) ?? 0,
        'bpkb': int.tryParse(noBPKB.text) ?? 0,
        'brand': brand.text,
        'transmisi': int.tryParse(transmisi.text) ?? 0,
        'bbm': bbm.text,
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


  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Tambah Kendaraan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context); // Kembali ke halaman sebelumnya
        //   },
        // ),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 237, 237),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _textfieldPlat(plat, 'Nomor Plat Kendaraan'),
                    _buildDropdown(jenis, 'Jenis Kendaraan'),
                    const SizedBox(
                      height: 15,
                    ),
                    _textfieldMerek(merk, 'Merk Kendaraan'),
                    _textfieldBBM(bbm, 'Bahan Bakar Kendaraan'),
                    _textfieldCC(transmisi, 'Transmisi Kendaraan (CC)'),
                    _textfieldBrand(brand, 'Brand Kendaraan'),
                    _textfieldTipe(type, 'Tipe Kendaraan'),
                    _dropdownYear(selectedYearController, 'Tahun Kepemilikan'),
                    const SizedBox(
                      height: 15,
                    ),
                    _textfieldWarna(warna, 'Warna Kendaraan'),
                    _buildNumericTextField(noRangka, 'No. Rangka'),
                    _buildNumericTextField(noMesin, 'No. Mesin'),
                    _buildNumericTextField(noBPKB, 'No. BPKB'),
                    const SizedBox(
                      height: 50,
                    )
                  ],
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

  //======= WIDGET TEXT FIELD ============
  Widget _textfieldPlat(TextEditingController controller, String labelText) {
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
        maxLength: 10,
      ),
    );
  }

  Widget _textfieldMerek(TextEditingController controller, String labelText) {
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
        maxLength: 15,
      ),
    );
  }

  Widget _textfieldBBM(TextEditingController controller, String labelText) {
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
        maxLength: 10,
      ),
    );
  }

  Widget _textfieldCC(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(
            decimal: false, signed: false),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
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
        maxLength: 4,
      ),
    );
  }

  Widget _textfieldBrand(TextEditingController controller, String labelText) {
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
        maxLength: 15,
      ),
    );
  }

  Widget _textfieldTipe(TextEditingController controller, String labelText) {
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
        maxLength: 15,
      ),
    );
  }

  Widget _textfieldWarna(TextEditingController controller, String labelText) {
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
        maxLength: 10,
      ),
    );
  }

  Widget _buildNumericTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(
            decimal: false, signed: false),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
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
        maxLength: 20,
      ),
    );
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

  // Widget _buildYearDropdown() {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: Row(
  //       children: [
  //         const Text(
  //           'Tahun Kepemilikan: ',
  //           style: TextStyle(fontSize: 16),
  //         ),
  //         DropdownButton<int>(
  //           value: selectedYear,
  //           items: availableYears.map((year) {
  //             return DropdownMenuItem<int>(
  //               value: year,
  //               child: Text('$year'),
  //             );
  //           }).toList(),
  //           onChanged: (value) {
  //             setState(() {
  //               selectedYear = value!;
  //             });
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
