import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  var coolor;
  var textColor;
  var clicked;

  var buttonText;

  MyButtons({this.buttonText, this.coolor, this.textColor, this.clicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onTap: clicked,
          child: Container(
            color: coolor,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                    color: textColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
