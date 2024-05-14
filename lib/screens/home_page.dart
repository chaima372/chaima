// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_stage_project/screens/Profile.dart';
import 'package:flutter_application_stage_project/screens/family/dataScreen.dart';

import 'package:provider/provider.dart';
import 'package:flutter_application_stage_project/screens/settings/settings.dart';
import 'package:flutter_application_stage_project/screens/login_page.dart';

import 'package:flutter_application_stage_project/screens/chat_page.dart';

import 'package:flutter_application_stage_project/providers/theme_provider.dart';

import '../services/login/sharedPreference.dart';

import 'bottomNavigationBar.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late ThemeProvider themeProvider;
  late TabController _tabController;
  int selectedIndex = 0;
  final Map<int, String> bottomTitle = {
    0: 'Jan',
    10: 'Feb',
    20: 'Mar',
    30: 'Apr',
    40: 'May',
    50: 'Jun',
    60: 'Jul',
    70: 'Aug',
    80: 'Sep',
    90: 'Oct',
    100: 'Nov',
    110: 'Dec',
  };
  final Map<int, String> leftTitle = {
    0: '0',
    20: '2K',
    40: '4K',
    60: '6K',
    80: '8K',
    100: '10K'
  };
  final List<FlSpot> _data = [
    FlSpot(1, 3),
    FlSpot(3, 5),
    FlSpot(5, 4),
    FlSpot(7, 6),
    FlSpot(9, 8),
  ];
  String? storedToken;
  @override
  void initState() {
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _tabController = TabController(length: 3, vsync: this);
    log("Init state activated: isDarkMode = ${themeProvider.isDarkMode}");
    _loadString();
  }

  void _loadString() async {
    String? retrievedString = await SharedPrefernce.getToken('token');
    setState(() {
      storedToken = retrievedString;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void signOut() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
  }

  void goToSettingsPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => Settings()));
  }

  void goToTicketPage() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return DataScreen(
          idFamily: '6',
          idBotton: 1,
        );
      },
    ));
  }

  void goToKanaban() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return DataScreen(
          idFamily: '3',
          idBotton: 2,
        );
      },
    ));
  }

  void goToProjet() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return DataScreen(
          idFamily: '7',
          idBotton: 3,
        );
      },
    ));
  }

  void goToChat() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: goToSettingsPage,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/face4.jpg'),
              radius: 20,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text('Sphere'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Activity'),
            Tab(text: 'Ticket'),
            Tab(text: 'Deal'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_sharp, size: 30),
            onPressed: goToSettingsPage,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(index: selectedIndex),
    );
  }
}

class SalesData {
  final String year;
  final int sales;

  SalesData(this.year, this.sales);
}
