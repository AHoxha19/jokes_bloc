import 'package:flutter/material.dart';

class FavoriteLoading extends StatelessWidget {
  const FavoriteLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
