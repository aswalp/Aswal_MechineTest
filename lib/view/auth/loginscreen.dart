import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:project/extension/extension.dart';
import 'package:project/services/firebaseservices.dart';
import 'package:project/view/home/homepage.dart';

import '../../widgets/custombutton.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: context.maxWidth(),
              height: context.responsiveHeight(150),
            ),
            SizedBox(
                width: context.maxWidth(),
                height: context.responsiveHeight(250),
                child: Image.asset(
                  "assets/images/firelogo.png",
                  fit: BoxFit.contain,
                )),
            SizedBox(
              height: context.responsiveHeight(80),
            ),
            CustomButton(
                buttoncolor: Colors.blue,
                ontap: () {
                  context.progressbar();
                  FirebaseServices.signInWithGoogle().then((value) {
                    if (value.user != null) {
                      FirebaseServices.user = value.user!;
                      Navigator.pop(context);
                      context.gotoonetime(const HomePage());
                    } else {
                      context.showSnackbar("checkout your internet");
                    }
                  });
                },
                buttonicon: CircleAvatar(
                  radius: context.responsiveWidth(14),
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(context.responsiveWidth(4)),
                    child: Image.asset(
                      "assets/icons/go.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                buttonName: "Google"),
            CustomButton(
                buttoncolor: Colors.green,
                ontap: () {
                  showDialog(
                    context: context,
                    builder: (cvn) => showdialog(context),
                  );
                },
                buttonicon: const Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                buttonName: "Phone"),
          ],
        ),
      ),
    );
  }

  AlertDialog showdialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter your Phone number"),
      content: SizedBox(
        height: context.responsiveHeight(50),
        child: TextField(
          keyboardType: TextInputType.phone,
          controller: controller,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    context.responsiveWidth(40), context.responsiveHeight(40)),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: () {
              FirebaseServices.phoneNumberAuth(controller.text, context);
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => otpshowdialog(context),
              );
            },
            child: Text(
              "Ok",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: context.responsiveWidth(14),
                  fontWeight: FontWeight.w500),
            ))
      ],
    );
  }

  AlertDialog otpshowdialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter your OTP"),
      content: SizedBox(
        height: context.responsiveWidth(100),
        child: Pinput(
          length: 6,
          defaultPinTheme: PinTheme(
            width: context.responsiveWidth(40),
            height: context.responsiveWidth(40),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onCompleted: (value) {},
        ),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    context.responsiveWidth(40), context.responsiveHeight(40)),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: () {},
            child: Text(
              "Done",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: context.responsiveWidth(14),
                  fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}
