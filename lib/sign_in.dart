import 'package:flutter/material.dart';
import 'package:mobi_tax/home_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Masuk"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                autocorrect: true,
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
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
                controller: passwordController,
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
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const MyHomePage(), // menggunakan AboutPage dari about_page.dart
                  ));
                },
                child: const Text("Masuk")),
            Slider(
              value: 0, // Nilai slider
              onChanged: null, // Mengatur onChanged ke null
            ),
            Slider(
              value: 1/4, // Nilai slider
              onChanged: null, // Mengatur onChanged ke null
            ),
            Slider(
              value: 2/4, // Nilai slider
              onChanged: null, // Mengatur onChanged ke null
            ),
            Slider(
              value: 3/4, // Nilai slider
              onChanged: null, // Mengatur onChanged ke null
            ),
            Slider(
              value: 4/4, // Nilai slider
              onChanged: null, // Mengatur onChanged ke null
            ),
          ],
        ),
      ),
    );
  }
}
