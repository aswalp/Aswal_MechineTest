import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double responsiveHeight(double h) {
    return MediaQuery.sizeOf(this).height * (h / 780);
  }

  double responsiveWidth(double w) {
    return MediaQuery.sizeOf(this).width * (w / 360);
  }

  double maxHeight() {
    return MediaQuery.sizeOf(this).height;
  }

  double maxWidth() {
    return MediaQuery.sizeOf(this).width;
  }

  dynamic goto(Widget wid) {
    Navigator.push(
        this,
        MaterialPageRoute(
          builder: (_) => wid,
        ));
  }

  dynamic gotoonetime(Widget wid) {
    Navigator.pushReplacement(
        this,
        MaterialPageRoute(
          builder: (_) => wid,
        ));
  }

  showSnackbar(String msg) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void progressbar() {
    showDialog(
        context: this,
        builder: (_) => const Center(
              child: CircularProgressIndicator(
                color: Color(0xff98c1d9),
              ),
            ));
  }
}
