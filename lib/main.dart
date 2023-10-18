import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/services/firebaseservices.dart';

import 'view/auth/loginscreen.dart';
import 'view/home/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: StreamBuilder(
        stream: FirebaseServices.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return LoginScreen();
          } else {
            FirebaseServices.user = snapshot.data!;
            return const HomePage();
          }
        },
      ),
    );
  }
}
