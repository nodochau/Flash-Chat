import 'package:flash_chat_app/constants.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_app/components/register_login_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpiner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpiner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 160.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 28.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blueGrey),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFiledDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
                //  const InputDecoration(
                //   hintText: 'Enter your email',
                //   hintStyle: TextStyle(color: Colors.blueGrey),
                //   contentPadding:
                //       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                //   enabledBorder: OutlineInputBorder(
                //     borderSide:
                //         BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                //   focusedBorder: OutlineInputBorder(
                //     borderSide:
                //         BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                // ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.blueGrey),
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFiledDecoration.copyWith(
                    hintText: 'Enter your password',
                  )),
              const SizedBox(
                height: 24.0,
              ),

              // MyRoundedButtons(
              //     thecolor: Colors.lightBlueAccent,
              //     title: 'Log In',
              //     onPressed: () {}),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        showSpiner = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        //password is 1234567
                        Navigator.pushNamed(context, ChatScreen.id);
                        setState(() {
                          showSpiner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'Log In',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
