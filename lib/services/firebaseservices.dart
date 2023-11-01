import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pinput/pinput.dart';
import 'package:project/extension/extension.dart';
import 'package:project/view/home/homepage.dart';

class FirebaseServices {
  static late User user;
  static final auth = FirebaseAuth.instance;
  static late String smsCode;
  static Stream<User?> authStateChanges() => auth.authStateChanges();

  static Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await auth.signInWithCredential(credential);
    } on PlatformException catch (e) {
      return null;
    }
  }

  static Future<void> phoneNumberAuth(
      String number, BuildContext context) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+91$number',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
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
                onCompleted: (value) {
                  smsCode = value;
                },
              ),
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(context.responsiveWidth(40),
                          context.responsiveHeight(40)),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () async {
                    context.progressbar();
                    await auth
                        .signInWithCredential(
                      PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: smsCode,
                      ),
                    )
                        .then((value) {
                      Navigator.pop(context);

                      if (value.user != null) {
                        FirebaseServices.user = value.user!;

                        context.gotoonetime(const HomePage());
                      } else {
                        context.showSnackbar("checkout your internet");
                      }
                    });
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: context.responsiveWidth(14),
                        fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static Future<void> logout() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }
}
