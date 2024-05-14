// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_application_stage_project/screens/home_page.dart';
import 'package:flutter_application_stage_project/screens/login_page.dart';
import 'package:flutter_application_stage_project/providers/theme_provider.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

class VerfierPassword extends StatefulWidget {
  const VerfierPassword({super.key});

  @override
  State<VerfierPassword> createState() => _VerfierPasswordState();
}

class _VerfierPasswordState extends State<VerfierPassword> {
  late ThemeProvider themeProvider;
  void initState() {
    // TODO: implement initState
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  }

  void confirmUser() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "le code de vérification",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "nous avons envoyé la vérification du code à votre email",
            ),
            SizedBox(
              height: 40,
            ),
            OtpTextField(
              keyboardType: TextInputType.number,
              mainAxisAlignment: MainAxisAlignment.center,
              numberOfFields: 6,
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              onSubmit: (value) {
                print("OTP CODE EST : $value");
              },
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: Size(150, 50),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 130, vertical: 16),
                      backgroundColor: Color.fromARGB(255, 246, 228, 250),
                    ),
                    child: const Text(
                      "Confirmer",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 145, 33, 250),
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
