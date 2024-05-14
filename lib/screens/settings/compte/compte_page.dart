import 'dart:developer';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_stage_project/screens/settings/compte/image_piker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class ComptePage extends StatefulWidget {
  const ComptePage({Key? key}) : super(key: key);

  @override
  State<ComptePage> createState() => _ComptePageState();
}

class _ComptePageState extends State<ComptePage> {
  Uint8List? _image;
  final TextEditingController myController = TextEditingController();

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
      //log("$_image");
    });
  }

  // Fonction de validation de l'email
  // Fonction de validation de l'email
  String? validateEmail(String? value) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || !regExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.enterValidEmail;
    }
    return null;
  }

  // Fonction de validation pour le champ de texte du nom et prénom
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fieldRequired;
    }
    return null;
  }

  // Fonction de validation pour le champ de texte du téléphone
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fieldRequired;
    }
    return null;
  }

  // Fonction de validation pour le champ de texte du mot de passe
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fieldRequired;
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).myaccount),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 200,
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Center(
                          child: _image != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage('assets/face4.jpg'),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        left: 130,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(
                            Icons.add_a_photo_rounded,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    // Champ de texte pour le nom et prénom avec validation
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Nom et prénom",
                        labelText: "Samer afaoui",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.person,
                        ),
                      ),
                      validator: validateName,
                    ),
                    SizedBox(height: 30),
                    // Champ de texte pour l'email avec validation
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "samerarfaoui2@gmail.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.mail,
                        ),
                      ),
                      validator: validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 30),
                    // Champ de texte pour le téléphone avec validation
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Téléphone",
                        hintText: "29 334 244",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.phone,
                        ),
                      ),
                      validator: validatePhone,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 30),
                    // Champ de texte pour le mot de passe avec validation
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Mot de passe",
                        labelText: "1234569",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                      ),
                      validator: validatePassword,
                      obscureText: true,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // Vérifie si le formulaire est valide avant de soumettre
                        if (_formKey.currentState!.validate()) {
                          log("formulaire validate");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                        backgroundColor: Color.fromARGB(255, 246, 228, 250),
                      ),
                      child: Text(
                        "Enregistrer",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 145, 33, 250),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
