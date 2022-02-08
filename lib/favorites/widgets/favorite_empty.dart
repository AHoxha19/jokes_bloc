import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteEmpty extends StatelessWidget {
  const FavoriteEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: height * 0.2,
        ),
        Icon(
          Icons.assignment_late,
          size: height * 0.2,
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Text(
          "No favorite jokes yet",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: height * 0.025),
        ),
        SizedBox(
          height: height * 0.2,
        ),
      ],
    );
  }
}
