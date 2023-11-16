// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(''),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ID Pengguna",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Nama Pengguna",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  color: const Color.fromRGBO(70, 152, 138, 1),
                  child: Column(
                    children: [
                      Container(child: const Text("Data Diri")),
                      ElevatedButton(
                        onPressed: () {},
                        child: Container(
                          child: const Row(
                            children: [
                              Icon(Icons.list_alt_sharp),
                              Text("Ubah Data Diri")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: const Text("Bantuan"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Container(
                          child: const Row(
                            children: [
                              Icon(Icons.info_outline),
                              Text("Panduan")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
