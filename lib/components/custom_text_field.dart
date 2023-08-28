import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key? key,this.hintText,this.onChanged,this.isObsecure=false}) : super(key: key);
final String? hintText;
final Function(String)? onChanged;
final bool isObsecure ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:isObsecure ,
      validator: (data){
        if(data!.isEmpty){
          return "value must not be empty" ;
        }
      },
      onChanged:onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
      ),
    );
  }
}
