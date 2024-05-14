// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_stage_project/screens/login_page.dart';
import 'package:flutter_application_stage_project/screens/onboarding_screen.dart';
import 'package:flutter_application_stage_project/providers/langue_provider.dart';
import 'package:flutter_application_stage_project/providers/theme_provider.dart';
import 'package:flutter_application_stage_project/core/constants/design/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:language_code/language_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String onboardingCompletedKey = 'onboardingCompleted';

Future<bool> isFirstTimeLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  final onboardingCompleted = prefs.getBool(onboardingCompletedKey) ?? false;
  return !onboardingCompleted;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final showOnboarding = await isFirstTimeLaunch();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                ThemeProvider()), // Assuming ThemeProvider manages theme
        ChangeNotifierProvider(
            create: (_) =>
                LangueProvider()), // Assuming LangueProvider manages language
      ],
      child: MyApp(showOnboarding: showOnboarding),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool showOnboarding;

  const MyApp({Key? key, required this.showOnboarding}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ... other state variables and methods for MyApp (if needed)

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ThemeProvider>(context); // Access ThemeProvider
    final providerLangue =
        Provider.of<LangueProvider>(context); // Access LangueProvider

    // ... other logic for MyApp.build() (if needed)

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) =>
            widget.showOnboarding ? OnBoardingScreen() : LoginPage(),
        '/login': (context) => LoginPage(), // Assuming LoginPage exists
      },
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: providerLangue.locale, // Set locale based on LangueProvider
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('ar'),
      ],
      debugShowCheckedModeBanner: false,
      theme: provider.isDarkMode
          ? MyThemes.darkTheme
          : MyThemes.lightTheme, // Apply theme based on ThemeProvider
      themeMode: provider.themeMode,
    );
  }
}
