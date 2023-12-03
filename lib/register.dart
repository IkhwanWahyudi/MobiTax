// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobi_tax/auth.dart';
import 'package:mobi_tax/sign_in.dart';

class Regis extends StatefulWidget {
  const Regis({super.key});

  @override
  State<Regis> createState() => _regisState();
}

class _regisState extends State<Regis> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.value.text;
    final password = _passwordController.value.text;
    final nama = _namaController.value.text;
    final alamat = _alamatController.value.text;
    final kecamatan = _kecamatanController.value.text;
    final kota = _kotaController.value.text;
    setState(() => _loading = true);
    try {
      // Mencoba untuk registrasi
      await Auth().regis(email, password, nama, alamat, kecamatan, kota);

      // Jika registrasi berhasil, navigasikan ke halaman Signin
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SignIn(),
        ),
      );
      setState(() => _loading = false);
    } catch (e) {
      print('Error saat registrasi: $e');
      setState(() => _loading = false);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: TextField(
                  controller: _namaController,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    labelStyle: TextStyle(
                      color: Color(0xFF183D3D), // warna label teks
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(
                            0xFF183D3D), // Warna outline saat dalam keadaan fokus
                        width: 2.0, // Lebar garis
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: TextFormField(
                  autocorrect: true,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email wajib diisi';
                    } else if (!value.contains('@')) {
                      return 'Email tidak valid';
                    }
                    return null; // Return null for no validation errors
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color(0xFF183D3D), // warna label teks
                      fontSize: 14,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(
                            0xFF183D3D), // Warna outline saat dalam keadaan fokus
                        width: 2.0, // Lebar garis
                      ),
                    ), // Teks Rp. yang akan ditampilkan di sebelah kiri inputan
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
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
                    return null; // Return null for no validation errors
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
                    labelStyle: const TextStyle(
                      color: Color(0xFF183D3D), // warna label teks
                      fontSize: 14,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(
                            0xFF183D3D), // Warna outline saat dalam keadaan fokus
                        width: 2.0, // Lebar garis
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: TextField(
                  controller: _alamatController,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    labelStyle: TextStyle(
                      color: Color(0xFF183D3D), // warna label teks
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(
                            0xFF183D3D), // Warna outline saat dalam keadaan fokus
                        width: 2.0, // Lebar garis
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: TextField(
                  controller: _kecamatanController,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Kecamatan',
                    labelStyle: TextStyle(
                      color: Color(0xFF183D3D), // warna label teks
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(
                            0xFF183D3D), // Warna outline saat dalam keadaan fokus
                        width: 2.0, // Lebar garis
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: TextField(
                  controller: _kotaController,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Kota',
                    labelStyle: TextStyle(
                      color: Color(0xFF183D3D), // warna label teks
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(
                            0xFF183D3D), // Warna outline saat dalam keadaan fokus
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
                  backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
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
    );
  }
}
