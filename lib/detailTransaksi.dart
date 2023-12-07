import 'package:flutter/material.dart';

class detailTransaksi extends StatefulWidget {
  const detailTransaksi({super.key});

  @override
  State<detailTransaksi> createState() => _detailTransaksiState();
}

class _detailTransaksiState extends State<detailTransaksi> {
  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'), // Judul AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Tombol kembali
          onPressed: () {
            Navigator.pop(
                context); // Fungsi untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: lebar * 0.976,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey, // warna bayangan
                    blurRadius: 5, // radius blur bayangan
                    offset: Offset(
                        0, 0), // pergeseran bayangan (horizontal, vertical)
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Container(
                    child: const Column(
                      children: [
                        Spacer(),
                        Text(
                          "PLAT",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Icon(
                          Icons.pedal_bike,
                          color: Colors.black,
                          size: 60,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20), // Jarak antara ikon dan teks
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Atas Nama",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 5), // Jarak antara teks
                      Text(
                        "ABC 1234",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Jumlah yang dibayar",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 5), // Jarak antara teks
                      Text(
                        " 1234",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
