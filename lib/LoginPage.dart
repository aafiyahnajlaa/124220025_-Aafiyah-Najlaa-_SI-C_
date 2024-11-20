import 'package:flutter/material.dart';
import 'package:responsi_124220025/HomePage.dart';
import 'package:responsi_124220025/ListRestaurant.dart';
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
   late SharedPreferences _logindata;
   late bool _newuser;
   @override
  void initState() {
    super.initState();
    //TODO: implement initState
    super.initState();
    check_if_already_login();
  }
  Future<void> check_if_already_login() async {
     _logindata = await SharedPreferences.getInstance();
     _newuser = (_logindata.getBool('login')?? true);
     print(_newuser);
     if(_newuser == false){
       Navigator.pushReplacement(
           context, new MaterialPageRoute(builder: (context)=> RestaurantListPage(username: _username)));
     }
  }

  //inisiasi state
  String _username = '';
  String password = '';
  bool isVisible = false;
  bool isClicked = false;
  bool loginSuccess = false;


  //function redirect
   Future<void> _navigateToHome() async {
     // Simpan informasi login di SharedPreferences
     await _logindata.setBool('login', true);
     await _logindata.setString('username', _username);

     // Navigasi ke halaman list restaurant
     Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => RestaurantListPage(username: _username)),
     );
   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text("Login Page"),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Image.asset('images.jpeg'),
            SizedBox(height: 20),
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
          _username = value;
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
          Future<bool> loginSuccess = authServices.Login(_username, password);
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
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.blueGrey),
          foregroundColor: WidgetStateProperty.all(Colors.white),
        ),
        child: Text("Login"),
      ),
    );
  }
}
