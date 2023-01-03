import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({ this.onChanged, this.label,this.obscureText = false} );

String? label ;
Function(String)?onChanged ;
bool obscureText ;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      obscureText: obscureText,
      validator: (data) {
        if(data!.isEmpty){
          return '$label is required';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide:BorderSide(color: Colors.white) ),
          enabledBorder:  const OutlineInputBorder(borderSide:BorderSide(color: Colors.white) ),
          label: Text(label!,style: const TextStyle(
            color: Colors.white,),
          )
      ),

    );
  }
}
