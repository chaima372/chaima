// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_application_stage_project/screens/home_page.dart';
import 'package:flutter_application_stage_project/providers/theme_provider.dart';

import 'package:flutter_application_stage_project/services/login/loginApi.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/login/sharedPreference.dart';

import 'dragAndDropKanban.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final urlController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late ThemeProvider themeProvider;
  String? savedToken;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    //_loadToken();
    _loadUrl();
  }

  /*
  void _loadToken() async {
    String? storedString = await SharedPrefernce.getToken('token');
    setState(() {
      savedToken = storedString;
    });
  }
  */

  void _loadUrl() async {
    String? storedString = await SharedPrefernce.getToken('url');
    setState(() {
      url = storedString ?? "";
      log("Url---------------------------------------- $url");
    });
  }

  void _saveUrl(String key, String value) async {
    await SharedPrefernce.saveUrl(key, value);
    _loadUrl(); // Reload the string after saving
  }

  void _saveString(String key, String value) async {
    await SharedPrefernce.saveToken(key, value);
    //_loadToken(); // Reload the string after saving
  }

  void signUser() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String url = "";
  final LoginApi loginAPI = LoginApi();
  //final prefs = SharedPreferences.getInstance();
  //late Future<int> token;

  @override
  Widget build(BuildContext context) {
    log("Url build---------------------------------------- $url");
    log('build ${themeProvider.isDarkMode}');
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _header(context),
              Form(key: _formKey, child: _inputField(context)),
              // _forgotPassword(context),
              // _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          AppLocalizations.of(context).headerLogin,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(
          height: 20,
        ),
        Text(AppLocalizations.of(context).textLogin),
        SizedBox(
          height: 50,
        )
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              url,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          height: 2000,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Connexion à un serveur d'accueil",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("Quelle est l'adresse de votre serveur ?"),
                                SizedBox(
                                  height: 15,
                                ),
                                Form(
                                    child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                                      child: TextFormField(
                                        initialValue: url,
                                        onChanged: (value) {
                                          _saveUrl('url', value);
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your Url';
                                          }

                                          return null;
                                        },
                                        keyboardType: TextInputType.url,
                                        decoration: InputDecoration(
                                            hintText:
                                                "URL du serveur d'acceuil",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                borderSide: BorderSide.none),
                                            fillColor:
                                                Colors.purple.withOpacity(0.1),
                                            filled: true,
                                            prefixIcon: const Icon(
                                              Icons.link_rounded,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 16),
                                        backgroundColor:
                                            Color.fromARGB(255, 246, 228, 250),
                                      ),
                                      child: Text(
                                        "Modify",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 145, 33, 250),
                                            fontWeight: FontWeight.w900),
                                      ),
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                backgroundColor: Color.fromARGB(255, 246, 228, 250),
              ),
              child: Text(
                "modify",
                style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 145, 33, 250),
                    fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        /*
        TextFormField(
          initialValue: url,
          onChanged: (value) {
            _saveUrl('url', value);
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your Url';
            }

            return null;
          },
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
              hintText: "URL du serveur d'acceuil",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(
                Icons.link_rounded,
              )),
        ),
        */
        const SizedBox(height: 10),
        TextFormField(
          onChanged: (value) {
            setState(() => email = value);
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your email';
            }
            if (!isValidEmail(value)) {
              return AppLocalizations.of(context)!.enterValidEmail;
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: AppLocalizations.of(context).email,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(
                Icons.email,
              )),
        ),
        const SizedBox(height: 10),
        TextFormField(
          onChanged: (value) {
            setState(() => password = value);
          },
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocalizations.of(context)!.fieldRequired;
            }
          },
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).password,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(
              Icons.password,
            ),
          ),
          obscureText: false,
        ),
        const SizedBox(height: 50),
        Container(
          padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
          width: 50,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                log(password + "," + email);
                /*
                dynamic result = await loginAPI.loginUser(email, password);
                if (result.success) {
                  _saveString('token', result.token.access_token);
                  // Do something with the validated email

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ok"))
                            ],
                            title: Text("Probléme d'authentiification"),
                            contentPadding: EdgeInsets.all(20),
                            content: Text(
                                "Merci de vérifier vos informations ou bien contacter l'adminstrateur"),
                          ));
                }

                //await prefs.setString('token', result.token.access_token);
                */
                try {
                  final loginResponse =
                      await loginAPI.loginUser(email, password, url);
                  // Handle successful login
                  log('Login response ${loginResponse.success}');
                  if (loginResponse.success) {
                    _saveString('token', loginResponse.token.access_token);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ));
                  }
                } on LoginException catch (e) {
                  // Display user-friendly error message (e.message)
                  // ...
                  log("11111");
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ok"))
                            ],
                            title: Text("Probléme d'authentiification"),
                            contentPadding: EdgeInsets.all(20),
                            content: Text(
                                "Merci de vérifier vos informations ou bien contacter l'adminstrateur"),
                          ));
                } catch (e) {
                  // Handle unexpected errors
                  // ...
                  log('222222');
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ok"))
                            ],
                            title: Text("Probléme d'authentiification"),
                            contentPadding: EdgeInsets.all(20),
                            content: Text(
                                "Merci de vérifier vos informations ou bien contacter l'adminstrateur"),
                          ));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              backgroundColor: Color.fromARGB(255, 246, 228, 250),
            ),
            child: Text(
              AppLocalizations.of(context).login,
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 145, 33, 250),
                  fontWeight: FontWeight.w900),
            ),
          ),
        ),
        SizedBox(
          height: 100,
        )
      ],
    );
  }

  /*_forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return DragAndDropKanban();
            //return UrlPage();
            // return ticketList();
          },
        ));
      },
      child: Text(
        AppLocalizations.of(context).forgotPassword,
        style: TextStyle(color: Colors.purple),
      ),
    );
  }
*/
  bool isValidEmail(String email) {
    // Regular expression for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
