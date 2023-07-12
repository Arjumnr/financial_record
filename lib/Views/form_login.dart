import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_record/Views/home.dart';
import 'package:financial_record/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';



class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

CollectionReference dataUser = FirebaseFirestore.instance.collection('users');

class _FormLoginState extends State<FormLogin> {
  String name = '';
  bool isVisible = false;

  Future<void> addUser() {
    dataUser
        .add({
          'name': name,
        })
        .then((value) => print("Data Added"))
        .catchError((error) => print("Failed to add data: $error"));
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('name', name);
    });
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Navigation(),
      ),
    );
  }

  // //cek user di firebase
  // Future<void> cekUser() {
  //   return dataUser
  //       .where('name', isEqualTo: name)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       if (doc['name'] == name) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const Navigation(),
  //           ),
  //         );
  //       } else {
  //         addUser();
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      persistentFooterButtons: [
        Container(
          width: 900,
          child: const Text(
            'Created by: Arjum Nur Ramadhan',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            12.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                ),
                padding: const EdgeInsets.all(
                  16.0,
                ),
                child: Image.asset(
                  "asset/logo-fr.png",
                  width: 64.0,
                  height: 64.0,
                ),
              ),
              //
              const SizedBox(
                height: 20.0,
              ),
              //
              const Text(
                "Masukkan Nama Anda",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              //
              const SizedBox(
                height: 20.0,
              ),
              //
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Nama Anda",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                  maxLength: 12,
                  onChanged: (val) {
                    name = val;
                  },
                ),
              ),
              //
              const SizedBox(
                height: 20.0,
              ),
              //
              SizedBox(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: "OK",
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                          ),
                          backgroundColor: Colors.white,
                          content: const Text(
                            "Masukkan Nama Terlebih Dahulu!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      );
                    } else {
                      addUser();
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mulai",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Icon(
                        Icons.arrow_right_alt,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
