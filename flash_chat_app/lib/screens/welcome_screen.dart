import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat_app/components/register_login_buttons.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // Add animation controler variable
  // At the _WelcomeScreenState we add with SingleTicker...
  // Create a initState and set controler variable a duration and vsync properties
  late AnimationController controler;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controler = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
      //upperBound: 100, UpperBound cannot be used with Curves cause Curves.value only from 0 to 1
    );
    //animation = CurvedAnimation(parent: controler, curve: Curves.easeInCirc);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controler);
    controler.forward();
    controler.addListener(() {
      setState(() {});
      //print(controler.value);
    });
  }

  // Add this dispose so that we can free up the memory after animation finish.
  @override
  void dispose() {
    controler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  //This is an animation widget
                  tag: 'logo',
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    // Add the animation so that the red color is taken 1 second to completely get the size 100
                    height: 60.0,
                  ),
                ),
                SizedBox(
                  width: 250.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 9, 54, 116),
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Flash Chat',
                            speed: const Duration(milliseconds: 100)),
                      ],
                      onTap: () {},
                    ),
                  ),
                ),
                // const Text(
                //   'Flash Chat',
                //   style: TextStyle(
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //     color: Color.fromARGB(255, 9, 54, 116),
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            // MyRoundedButtons(
            //   thecolor: Colors.lightBlueAccent,
            //   title: 'LogIn',
            //   onPressed: () {
            //     Navigator.pushNamed(context, LoginScreen.id);
            //   },
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Login',
                  ),
                ),
              ),
            ),
            // MyRoundedButtons(
            //     thecolor: Colors.blueAccent,
            //     title: 'Register',
            //     onPressed: () {
            //       Navigator.pushNamed(context, RegistrationScreen.id);
            //     }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
