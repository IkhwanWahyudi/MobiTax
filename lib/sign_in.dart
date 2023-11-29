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

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.value.text;
    final password = _passwordController.value.text;
    await Auth().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Masuk"),
        backgroundColor: Color.fromRGBO(70, 152, 138, 1),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
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
                margin: const EdgeInsets.all(5),
                child: TextField(
                  autocorrect: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
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
                      suffixIcon: Icon(Icons.visibility_off)),
                  obscureText: true,
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).pushReplacement(
              //       MaterialPageRoute(
              //         builder: (context) => const BottomNavigation(),
              //       ),
              //     );
              //   },
              //   child: const Text("Masuk"),
              // ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                // onPressed: () {
                  // const mySnackBar = SnackBar(
                  //   content: Text("Berhasil Login"),
                  //   duration: Duration(seconds: 3),
                  //   padding: EdgeInsets.all(10),
                  //   backgroundColor: Colors.green,
                  //   behavior: SnackBarBehavior
                  //       .floating, // Mengatur SnackBar untuk muncul di atas
                  // );
                  // ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) => const BottomNavigation(),
                  //   ),
                  // );
                // },
                onPressed: () => handleSubmit(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
                  minimumSize:
                      const Size(150, 50), // Atur lebar dan tinggi button
                  padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16), // Padding di sekitar icon dan teks
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30.0), // Mengatur radius untuk membuat button rounded
                  ),
                ),
                child: const Text('Masuk'),
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
                      Navigator.push(
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
