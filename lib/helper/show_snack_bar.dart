import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,String meesage) {
  ScaffoldMessenger.of(context).showSnackBar( SnackBar
    (content: Text(meesage),)
  );
}