import 'package:flutter/material.dart';
import 'package:project/extension/extension.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.responsiveWidth(20)),
      child: Column(
        children: [
          SizedBox(
            width: context.maxWidth(),
            height: context.responsiveHeight(30),
          ),
          SizedBox(
              width: context.maxWidth(),
              height: context.responsiveHeight(300),
              child: Image.asset(
                "assets/images/emptycart.png",
                fit: BoxFit.contain,
              )),
          SizedBox(
            height: context.responsiveHeight(10),
          ),
          Text(
            "Empty Menu",
            style: TextStyle(
                fontSize: context.responsiveWidth(24),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: context.responsiveHeight(10),
          ),
          SizedBox(
            width: context.maxWidth() * 0.7,
            child: Text(
              "Look like you haven't made you choice yet",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: context.responsiveWidth(20),
                  color: Colors.black54,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: context.responsiveHeight(15),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[500],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: Size(context.responsiveWidth(150),
                      context.responsiveHeight(50))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Back to Menu",
                style: TextStyle(
                  fontSize: context.responsiveWidth(16),
                  color: Colors.white,
                ),
              )),
          SizedBox(
            height: context.responsiveHeight(10),
          ),
          Text(
            "Check what we've got for you",
            style: TextStyle(
                color: Colors.red[500],
                fontSize: context.responsiveWidth(14),
                fontWeight: FontWeight.w300),
          ),
          Text(
            "and get it swished!",
            style: TextStyle(
                color: Colors.black54,
                fontSize: context.responsiveWidth(14),
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
