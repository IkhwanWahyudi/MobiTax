// import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobi_tax/auth.dart';
import 'package:mobi_tax/sign_in.dart';
import 'package:provider/provider.dart';
import 'themeModeData.dart';

class Regis extends StatefulWidget {
  const Regis({super.key});

  @override
  State<Regis> createState() => _regisState();
}

class _regisState extends State<Regis> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  // handleSubmit() async {
  //   if (!_formKey.currentState!.validate()) return;
  //   final email = _emailController.value.text;
  //   final password = _passwordController.value.text;
  //   final nama = _namaController.value.text;
  //   final nik = _nikController.value.text;
  //   final alamat = _alamatController.value.text;
  //   final kecamatan = _kecamatanController.value.text;
  //   final kota = _kotaController.value.text;
  //   setState(() => _loading = true);
  //   try {
  //     // Mencoba untuk registrasi
  //     await Auth().regis(email, password, nama, nik, alamat, kecamatan, kota);
  //
  //     // Jika registrasi berhasil, navigasikan ke halaman Signin
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => const SignIn(),
  //       ),
  //     );
  //     setState(() => _loading = false);
  //   } catch (e) {
  //     print('Error saat registrasi: $e');
  //     setState(() => _loading = false);
  //   }
  // }
  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.value.text;
    final password = _passwordController.value.text;
    final nama = _namaController.value.text;
    final nik = _nikController.value.text;
    final alamat = _alamatController.value.text;
    final kecamatan = _kecamatanController.value.text;
    final kota = _kotaController.value.text;
    setState(() => _loading = true);
    try {
      // Mencoba untuk registrasi
      await Auth().regis(email, password, nama, nik, alamat, kecamatan, kota);

      // Jika registrasi berhasil, tampilkan dialog sukses
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Registrasi Berhasil'),
            content: Text('Akun Anda telah berhasil terdaftar!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the success dialog
                  // Navigasikan ke halaman SignIn
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
                    ),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error saat registrasi: $e');
      setState(() => _loading = false);

      // Check if the error is due to an existing email address
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        // Show a dialog indicating that the email is already in use
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Registrasi Gagal'),
              content: Text('Email sudah digunakan. Silakan gunakan email lain.'),
              actions: [
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
      }
    }
  }


  bool isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = Provider.of<ThemeModeData>(context).getTheme();
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Daftar",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Text(
                  'REGISTRASI',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: selectedTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: TextFormField(
                    controller: _nikController,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'NIK wajib diisi';
                      } else if (value.length < 16) {
                        return 'NIK setidaknya sebanyak 16 karakter';
                      } else if (value.length > 16) {
                        return 'NIK hanyak sebanyak 16 karakter';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'NIK',
                      labelStyle: TextStyle(
                        color: selectedTheme.primaryColor, // warna label teks
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: selectedTheme.primaryColor, // Warna outline saat dalam keadaan fokus
                          width: 2.0, // Lebar garis
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: TextFormField(
                    controller: _namaController,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama Lengkap wajib diisi';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
                      labelStyle: TextStyle(
                        color: selectedTheme.primaryColor, // warna label teks
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: selectedTheme.primaryColor, // Warna outline saat dalam keadaan fokus
                          width: 2.0, // Lebar garis
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: TextFormField(
                    autocorrect: true,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email wajib diisi';
                      } else if (!value.contains('@')) {
                        return 'Email tidak valid';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: selectedTheme.primaryColor, // warna label teks
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: selectedTheme.primaryColor, // Warna outline saat dalam keadaan fokus
                          width: 2.0, // Lebar garis
                        ),
                      ), // Teks Rp. yang akan ditampilkan di sebelah kiri inputan
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: TextFormField(
                    autocorrect: true,
                    controller: _passwordController,
                    obscureText: !isPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password wajib diisi';
                      } else if (value.length < 6) {
                        return 'Password setidaknya sebanyak 6 karakter';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: _togglePasswordVisibility,
                        child: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: selectedTheme.primaryColor,
                        fontWeight: FontWeight.bold,// warna label teks
                        fontSize: 14,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: selectedTheme.primaryColor, // Warna outline saat dalam keadaan fokus
                          width: 2.0, // Lebar garis
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: TextFormField(
                    controller: _alamatController,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat wajib diisi';
                      }
                      return null; // Return null for no validation errors
                    },
                    decoration: InputDecoration(
                      labelText: 'Alamat',
                      labelStyle: TextStyle(
                        color: selectedTheme.primaryColor, // warna label teks
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: selectedTheme.primaryColor, // Warna outline saat dalam keadaan fokus
                          width: 2.0, // Lebar garis
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: TextFormField(
                    controller: _kecamatanController,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kecamatan wajib diisi';
                      }
                      return null; // Return null for no validation errors
                    },
                    decoration: InputDecoration(
                      labelText: 'Kecamatan',
                      labelStyle: TextStyle(
                        color: selectedTheme.primaryColor, // warna label teks
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: selectedTheme.primaryColor, // Warna outline saat dalam keadaan fokus
                          width: 2.0, // Lebar garis
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: TextFormField(
                    controller: _kotaController,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kota wajib diisi';
                      }
                      return null; // Return null for no validation errors
                    },
                    decoration: InputDecoration(
                      labelText: 'Kota',
                      labelStyle: TextStyle(
                        color: selectedTheme.primaryColor, // warna label teks
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: selectedTheme.primaryColor, // Warna outline saat dalam keadaan fokus
                          width: 2.0, // Lebar garis
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: () => handleSubmit(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTheme.primaryColor,
                    minimumSize:
                        const Size(250, 50), // Atur lebar dan tinggi button
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15.0), // Mengatur radius untuk membuat button rounded
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Daftar',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sudah punya akun?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignIn()),
                        );
                      },
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
