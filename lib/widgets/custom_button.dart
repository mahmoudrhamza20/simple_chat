
import 'package:flutter/material.dart';
import '../constants.dart';

class CustomButton extends StatelessWidget {
   CustomButton({ required this.title,required this.onTap});

   String title ;
   VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap ,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white
        ),
        child:  Center(child: Text(title,style: const TextStyle(color: kPrimaryColor))),
      ),
    );
  }
}
