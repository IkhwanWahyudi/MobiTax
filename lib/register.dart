import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobi_tax/main.dart';
import 'package:mobi_tax/sign_in.dart';

class regis extends StatefulWidget {
  const regis({super.key});

  @override
  State<regis> createState() => _regisState();
}

class _regisState extends State<regis> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar"),
        backgroundColor: const Color.fromRGBO(70, 152, 138, 1),
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
            Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                autocorrect: true,
                controller: passwordController,
                decoration: const InputDecoration(
                    labelText: 'Confirm Password',
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
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const BottomNavigation(),
                  ),
                  
                );
              },
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
              child: const Text('Daftar'),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignIn()),
                    );
                  },
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
