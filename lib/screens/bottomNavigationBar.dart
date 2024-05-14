import 'package:flutter/material.dart';
import 'package:flutter_application_stage_project/screens/disscussions_page.dart';
import 'package:flutter_application_stage_project/screens/family/dataScreen.dart';
import 'package:flutter_application_stage_project/screens/home_page.dart';
import 'package:flutter_application_stage_project/screens/settings/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Profile.dart';
import 'chat_page.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int index;
  const BottomNavigationBarWidget({Key? key, required this.index})
      : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarWidget> {
  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ProfilePage();
      },
    ));
  }

  void goToHomePage() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return HomePage();
      },
    ));
  }

  void goToSettingsPage() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Settings();
      },
    ));
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

  void goTocha() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ChatPage();
      },
    ));
  }

  void goToDisc() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return DisscussionsPage();
      },
    ));
  }

  int selectedIndex = 0; // Initialize selectedIndex here

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      iconSize: 20,
      onTap: (int index) {
        setState(() {
          selectedIndex = index;
          switch (index) {
            case 0:
              goToHomePage();
              break;
            case 1:
              goToTicketPage();
              break;
            case 2:
              goToKanaban();
              break;
            case 3:
              goToProjet();
              break;
            case 4:
              goToDisc();
              break;
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart_outline_rounded),
          activeIcon: Icon(Icons.pie_chart),
          label: "Vue D'ensemble",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.airplane_ticket_outlined),
          activeIcon: Icon(Icons.airplane_ticket_rounded),
          label: AppLocalizations.of(context).tickets,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.handshake_outlined),
          activeIcon: Icon(Icons.handshake_rounded),
          label: AppLocalizations.of(context).deals,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder),
          activeIcon: Icon(Icons.folder_copy_outlined),
          label: "Projects", // Changed label to "Projet"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_outlined),
          activeIcon: Icon(Icons.chat_bubble_rounded),
          label: "Discussions",
        ),
      ],
    );
  }
}
