import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> regis(String email, String password, String nama, String alamat,
      String kecamatan, String kota) async {
    final regisUser = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = regisUser.user;
    final uidPengguna = user?.uid;

    await FirebaseFirestore.instance
        .collection('pengguna')
        .doc(uidPengguna)
        .collection('data_diri')
        .add({
      'nama': nama,
      'alamat': alamat,
      'kecamatan': kecamatan,
      'kota': kota,
    });
  }

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
