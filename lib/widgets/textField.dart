import 'package:flutter/material.dart';

class txtField extends StatelessWidget {
  final String txt;
  final TextEditingController con;

  final  Function(String val)? onTap;

  const txtField({
    Key? key,
    required this.txt,
    required this.con,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
                  controller: con,
                   decoration: new InputDecoration(
                    labelText: txt,
                    labelStyle: TextStyle(color: Colors.grey[500]),
                    fillColor: Colors.white,
                    border:  OutlineInputBorder(
                      borderSide:  BorderSide(),),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 255, 163, 64)),
                    
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (value){onTap!(value!);},
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                );
  }
}
