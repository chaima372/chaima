// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:developer';

import 'dart:ui';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_stage_project/providers/langue_provider.dart';
import 'package:flutter_application_stage_project/providers/theme_provider.dart';

import 'package:flutter_application_stage_project/screens/settings/aPropos_page.dart';
import 'package:flutter_application_stage_project/screens/settings/activties_settings_page.dart';
import 'package:flutter_application_stage_project/screens/settings/affichage_page.dart';
import 'package:flutter_application_stage_project/screens/settings/compte/compte_page.dart';

import 'package:flutter_application_stage_project/screens/settings/indisponibilite_page.dart';

import 'package:flutter_application_stage_project/screens/settings/notifications_page.dart';
import 'package:flutter_application_stage_project/screens/settings/securite_page.dart';
import 'package:flutter_application_stage_project/services/ApiLogout.dart';
import 'package:flutter_application_stage_project/services/login/sharedPreference.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import 'changesLanguges_page.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with WidgetsBindingObserver {
  late ThemeProvider themeProvider;
  late LangueProvider langueProvider;
  late Locale value;

  @override
  void initState() {
    super.initState();
    log("test initstate Activate Settings");
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    langueProvider = Provider.of<LangueProvider>(context, listen: false);
    langueProvider.addListener(_onLocaleChange);
    updateValueSelected(langueProvider.locale);
  }

  @override
  void dispose() {
    langueProvider.removeListener(_onLocaleChange);
    super.dispose();
  }

  void _onLocaleChange() {
    setState(() {
      updateValueSelected(langueProvider.locale);
    });
  }

  void updateValueSelected(Locale locale) {
    setState(() {
      valueSelected = locale.languageCode == 'fr'
          ? "Français"
          : locale.languageCode == "en"
              ? "English"
              : "العربية";
    });
  }

  void removeToken() async {
    await SharedPrefernce.removeData("token");
  }

  String valueSelected = '';
  Future<void>? _launched;
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  bool notification = true;

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch = Uri(
        scheme: 'https',
        host: 'www.comunikcrm.com',
        path: 'confidentialite.html');
    log("la langage de systeme est  $valueSelected");
    log("la valuer dans langueProvider ${langueProvider.locale}");
    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode == true ? Colors.black : Colors.grey[100],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return NotificationsPage();
                },
              ));
            },
            icon: Icon(
              Icons.notifications_none_sharp,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        //padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(15),
                child: Text(AppLocalizations.of(context).account)),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              color: themeProvider.isDarkMode == true
                  ? Colors.black
                  : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ComptePage();
                        },
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context).account,
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      _launched = _launchInBrowser(toLaunch);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lock_person_rounded,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context).confidentiality,
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SecuritePage();
                        },
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_police_rounded,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .securityandpermissions,
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return IndisponibilitePage();
                        },
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.display_settings_outlined,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context).unavailability,
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ActiviteSettingsPage();
                        },
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.timeline,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Timeline",
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Apropos();
                        },
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context).about,
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                AppLocalizations.of(context).contentanddisplay,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              color: themeProvider.isDarkMode == true
                  ? Colors.black
                  : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return NotificationsPage();
                        },
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.notifications_sharp,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context).notifications,
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        CupertinoSwitch(
                          activeColor: Colors.purple,
                          value: notification,
                          onChanged: (value) {
                            setState(() {
                              notification = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ChangeLangugePage();
                        },
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.language_outlined,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context).languages,
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(valueSelected),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.purple,
                              size: 15,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Affichage();
                        },
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.nightlight_sharp,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context).display,
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        CupertinoSwitch(
                          activeColor: Colors.purple,
                          value: themeProvider.isDarkMode,
                          onChanged: (value) {
                            setState(() {
                              themeProvider.toggleTheme();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                AppLocalizations.of(context).connection,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              color: themeProvider.isDarkMode == true
                  ? Colors.black
                  : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        log("logout");
                        final logoutResponse = await ApiLogout.logOut();
                        if (logoutResponse == "Logout successful") {
                          removeToken();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        }
                      } catch (e) {
                        print("problem de logout $e");
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context).disconnect,
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
/*

Widget customSwitch(
  String text,
  bool val,
  onChangeMethod,
  BuildContext context,
) {
  log("la valeur de button switch ==== $val");
  return Padding(
    padding: EdgeInsets.only(top: 0, left: 0, right: 0),
    child: Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Spacer(),
        CupertinoSwitch(
          activeColor: Colors.purple,
          value: val,
          onChanged: onChangeMethod,
        ),
      ],
    ),
  );
}
*/