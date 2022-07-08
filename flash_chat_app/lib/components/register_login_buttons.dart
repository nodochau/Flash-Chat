import 'package:flutter/material.dart';

// ignore: camel_case_types
class MyRoundedButtons extends StatelessWidget {
  final Color thecolor;
  final String title;
  final Function onPressed;
  const MyRoundedButtons({
    Key? key,
    required this.thecolor,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: thecolor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            //Go to login screen.
            //Navigator.pushNamed(context, navigatorPage);
            onPressed;
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
