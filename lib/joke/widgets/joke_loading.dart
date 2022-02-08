import 'package:flutter/material.dart';

class JokeLoading extends StatelessWidget {
  const JokeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
