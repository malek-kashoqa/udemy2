import 'package:flutter/material.dart';

Widget DefaultButton({
  double width = double.infinity,
  Color backgroundColor = Colors.blue,
  required Function function,
  required String text,
  bool isUpperCase = true,
  double radius = 10.0,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

Widget DefaultFormField({
  required TextEditingController controller,
  required String text,
  required String? Function(String?)? validate,
  bool obscureText = false,
  Icon? suffixIcon,
  Icon? prefixIcon,
  TextInputType? keyboardType,
  Function? onFieldSubmitted(value)?,
  Function? onChanged(value)?,
}) =>
    TextFormField(
      validator: validate,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon,
      ),
    );
