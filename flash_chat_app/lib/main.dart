import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_app/screens/welcome_screen.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/screens/registration_screen.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';

//void main() => runApp(const FlashChat());
void main() async {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  //
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // theme: ThemeData.light(),
        theme: ThemeData.dark().copyWith(
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.black54),
            //bodyText1: TextStyle(color: Colors.white30),
          ),
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          RegistrationScreen.id: (context) => const RegistrationScreen(),
          ChatScreen.id: (context) => ChatScreen()
        });
  }
}
