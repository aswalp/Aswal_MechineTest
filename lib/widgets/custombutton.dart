import 'package:flutter/material.dart';
import 'package:project/extension/extension.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttoncolor,
    required this.ontap,
    required this.buttonicon,
    required this.buttonName,
  });

  final Color buttoncolor;
  final VoidCallback ontap;
  final Widget buttonicon;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveWidth(40),
          vertical: context.responsiveWidth(10)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
              horizontal: context.responsiveWidth(10),
              vertical: context.responsiveWidth(10)),
          backgroundColor: buttoncolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: ontap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buttonicon,
            Expanded(
              child: Text(
                buttonName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: context.responsiveWidth(16),
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
