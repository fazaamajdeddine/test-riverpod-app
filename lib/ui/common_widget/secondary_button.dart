import 'package:flutter/material.dart';
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.press,
    required this.height,
    required this.width,
    required this.color,
    required this.icon,
  }) : super(key: key);
  final Icon icon;
  final double height;
  final double width;
  final VoidCallback press;
  final color;
  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        color: color,
        onPressed: press,
        child: icon,
      ),
    );

  }
}