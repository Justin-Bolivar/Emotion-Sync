import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emotion_sync/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            Container(
              width: 180, 
              height: 165, 
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10), 
                image: const DecorationImage(
                  image: AssetImage('lib/assets/images/ESlogo.png'),
                  fit: BoxFit.cover, 
                ),
              ),
            ),
            const SizedBox(height: 80),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
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
                'Submit',
                style: GoogleFonts.lexend(
                    textStyle: const TextStyle(color: midnightblue)),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // LOGIC
              },
              child: Text(
                'Register',
                style: GoogleFonts.lexend(
                    textStyle: const TextStyle(color: midnightblue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
