import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emotion_sync/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: beige,
      appBar: AppBar(
        title: Text('Welcome to Emotion-sync',
            style: GoogleFonts.frederickaTheGreat()),
        centerTitle: true,
        //backgroundColor: beige,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: GoogleFonts.frederickaTheGreat(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: GoogleFonts.frederickaTheGreat(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: GoogleFonts.frederickaTheGreat(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _password2Controller,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                hintStyle: GoogleFonts.frederickaTheGreat(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // LOGIC
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              child: Text(
                'Register',
                style: GoogleFonts.lexend(
                    textStyle: const TextStyle(color: midnightblue)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
