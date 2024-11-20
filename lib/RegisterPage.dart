import 'package:flutter/material.dart';
import 'package:responsi_124220025/LoginPage.dart';
import 'package:responsi_124220025/service/Shared_Preferences.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//inisiasi state
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Register Page"),
      ),
      body: SafeArea(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                decoration: InputDecoration(label: Text("Username"),),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: InputDecoration(label: Text("Password")),
              ),
              ElevatedButton(
                  onPressed: () {
                    //menyimpan data ke local
                    authServices.simpanAkun(username, password);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context)=> LoginPage())
                    );
                  },
                  child: Text("Register"))
            ],
          )),
    );
  }
}