import 'package:flutter/material.dart';
import 'package:responsi_124220025/HomePage.dart';
import 'package:responsi_124220025/main.dart';
import 'package:responsi_124220025/service/Shared_Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   final username_controller = TextEditingController();
   final password_controller = TextEditingController();
   late SharedPreferences logindata;
   late bool newuser;
   @override
  void initState() {
    super.initState();
    //TODO: implement initState
    super.initState();
    check_if_already_login();
  }
  Future<void> check_if_already_login() async {
     logindata = await SharedPreferences.getInstance();
     newuser = (logindata.getBool('login')?? true);
     print(newuser);
     if(newuser == false){
       Navigator.pushReplacement(
           context, new MaterialPageRoute(builder: (context)=> MyHomePage(title: 'Home Page',)));
     }
  }

  //inisiasi state
  String username = '';
  String? nickname;
  String password = '';
  bool isVisible = false;
  bool isClicked = false;
  bool loginSuccess = false;


  //function redirect
  _navigateToHome() async {
    //fungsinya ga beraturan
    await Future.delayed(Duration(seconds: 3));

    var push = Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomePage(username: username, nickname: nickname)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Login Page"),
        ),
        body: Column(
          children: [
            _usernameField(),
            _passwordField(),
            _loginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        onChanged: (value) {
          username = value;
        },
        decoration: InputDecoration(
            hintText: 'Username',
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.blue))),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        enabled: true,
        obscureText: isVisible,
        onChanged: (value) {
          password = value;
        },
        decoration: InputDecoration(
            suffix: IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              icon: Icon(Icons.visibility),
            ),
            hintText: 'Password',
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.blue))),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () async {
          Future<bool> loginSuccess = authServices.Login(username, password);
          if ( await loginSuccess) {
            _navigateToHome();
            //tampilkan pesan sukses
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login Berhasil'),
              ),
            );
            //ubah warna tombol
            setState(() {
              isClicked = !isClicked;
              print(isClicked);
            });
          } else {
            //tampilkan pesan gagal
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login gagal'),
              ),
            );
            setState(() {
              isClicked = !isClicked;
              print(!isClicked);
            });
          }
        },
        child: Text("Login"),
      ),
    );
  }
}