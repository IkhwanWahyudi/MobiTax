// ignore_for_file: prefer_const_constructors, unused_import, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobi_tax/auth.dart';
import 'package:mobi_tax/detail.dart';
import 'package:mobi_tax/home_page.dart';
import 'package:mobi_tax/register.dart';
import 'package:provider/provider.dart';
import 'themeModeData.dart';

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
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Login Error'),
            content: const Text(
                'Email atau Password tidak valid. Silakan coba lagi.'),
            actions: [
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
      print('Error Saat Sign In: $e');
    }
    setState(() {
      _loading = false;
    });
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
      //     "Masuk",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Color.fromRGBO(70, 152, 138, 1),
      // ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 270,
                height: 270,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png',),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: TextFormField(
                  autocorrect: true,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email masih kosong';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: selectedTheme.primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,// warna label teks
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: selectedTheme.primaryColor,
                        width: 2.0, // Lebar garis
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: TextFormField(
                  autocorrect: true,
                  controller: _passwordController,
                  obscureText: !isPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password masih kosong';
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
                      fontSize: 15,
                      fontWeight: FontWeight.bold,// warna label teks
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: selectedTheme.primaryColor,
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
                  backgroundColor: selectedTheme.primaryColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
