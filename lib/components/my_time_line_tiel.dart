// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_stage_project/components/envent_card.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String title;
  final String time;

  const MyTimelineTile(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.time,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(color: Colors.deepPurple),
        indicatorStyle: IndicatorStyle(
            width: 30,
            color: Colors.deepPurple,
            iconStyle: IconStyle(iconData: Icons.done, color: Colors.white)),
        endChild: EventCard(
          time: time,
          title: title,
        ),
      ),
    );
  }
}
