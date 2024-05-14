import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String time;
  const EventCard({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 206, 186, 243),
          borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          time,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ]),
    );
  }
}
