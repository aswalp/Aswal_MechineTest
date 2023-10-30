import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/extension/extension.dart';
import 'package:project/providers/cartprovider.dart';
import 'package:project/services/firebaseservices.dart';
import 'package:project/view/auth/loginscreen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(context.responsiveWidth(20)),
            width: context.maxWidth(),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.green, Colors.lightGreen]),
                borderRadius: BorderRadiusDirectional.vertical(
                    bottom: Radius.circular(30))),
            child: Column(
              children: [
                SizedBox(
                  width: context.maxWidth(),
                  height: context.responsiveWidth(70),
                ),
                CircleAvatar(
                  radius: context.responsiveWidth(60),
                  backgroundImage: NetworkImage(FirebaseServices
                          .user.photoURL ??
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                ),
                SizedBox(
                  height: context.responsiveWidth(10),
                ),
                Text(
                  FirebaseServices.user.displayName ??
                      FirebaseServices.user.phoneNumber!,
                  style: TextStyle(
                      fontSize: context.responsiveWidth(18),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: context.responsiveWidth(10),
                ),
                Text(
                  " ID:${FirebaseServices.user.uid}",
                  style: TextStyle(
                      fontSize: context.responsiveWidth(14),
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Consumer(builder: (__, ref, _) {
            return ListTile(
              onTap: () {
                ref.watch(cartProvider).clearlist();
                ref.read(totalItemProvider.notifier).state = 0;

                FirebaseServices.logout().then((value) {
                  context.gotoonetime(LoginScreen());
                });
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.black54,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.black54),
              ),
            );
          })
        ],
      ),
    );
  }
}
