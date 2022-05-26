import 'package:flutter/material.dart';

Widget onErrorLoading(BuildContext context) {
  Future.delayed(const Duration(seconds: 7), () {
    const Text("No Notes found! Please add a Note");
  });
  return Container(
      height: 50,
      width: 300,
      child: const Center(
          child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator())));
}
