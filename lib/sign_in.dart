// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:mobi_tax/auth.dart';
import 'package:mobi_tax/detail.dart';
import 'package:mobi_tax/home_page.dart';
import 'package:mobi_tax/register.dart';

import 'main.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.value.text;
    final password = _passwordController.value.text;
    setState(() => _loading = true);
    try {
      // Mencoba untuk signin
      await Auth().login(email, password);
      // Jika signin berhasil, navigasikan ke halaman BottomNavigation
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNavigation(),
        ),
      );
      setState(() => _loading = false);
    } catch (e) {
      print('Error saat signin: $e');
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
          "Masuk",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(70, 152, 138, 1),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: TextField(
                  autocorrect: true,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color(0xFF183D3D), // warna label teks
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
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: TextField(
                  autocorrect: true,
                  controller: _passwordController,
                  obscureText: !isPasswordVisible,
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
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () => handleSubmit(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
                  minimumSize:
                      const Size(250, 50), // Atur lebar dan tinggi button
                  padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16), // Padding di sekitar icon dan teks
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
                    : Text(
                        'Masuk',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Belum punya akun?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Regis()),
                      );
                    },
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 233, 22, 7),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
              // Slider(
              //   value: 0, // Nilai slider
              //   onChanged: null, // Mengatur onChanged ke null
              // ),
              // Slider(
              //   value: 1 / 4, // Nilai slider
              //   onChanged: null, // Mengatur onChanged ke null
              // ),
              // Slider(
              //   value: 2 / 4, // Nilai slider
              //   onChanged: null, // Mengatur onChanged ke null
              // ),
              // Slider(
              //   value: 3 / 4, // Nilai slider
              //   onChanged: null, // Mengatur onChanged ke null
              // ),
              // Slider(
              //   value: 4 / 4, // Nilai slider
              //   onChanged: null, // Mengatur onChanged ke null
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
