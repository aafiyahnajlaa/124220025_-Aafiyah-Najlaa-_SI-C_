import 'package:flutter/material.dart';
import 'package:responsi_124220025/LoginPage.dart';
import 'package:responsi_124220025/service/Shared_Preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // State variables
  String username = "";
  String password = "";
  String confirmPassword = "";
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text("Register Page"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.asset('images.jpeg'),
              _usernameField(),
              SizedBox(height: 16),
              _passwordField(),
              SizedBox(height: 16),
              _confirmPasswordField(),
              SizedBox(height: 16),
              _registerButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          username = value;
        });
      },
      decoration: InputDecoration(
        labelText: "Username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: IconButton(
          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _confirmPasswordField() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          confirmPassword = value;
        });
      },
      obscureText: !isConfirmPasswordVisible,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        suffixIcon: IconButton(
          icon: Icon(isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isConfirmPasswordVisible = !isConfirmPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (password == confirmPassword) {
          // Save account to local storage
          authServices.simpanAkun(username, password);
          // Navigate to Login Page after successful registration
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          // Show error message if passwords do not match
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match')),
          );
        }
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.blueGrey),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
      child: const Text("Register"),
    );
  }
}
