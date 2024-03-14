import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/home_page.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  static var myNewFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, letterSpacing: 3));

  late Timer _timer;
  bool _isGlowing = false;
  @override
  void initState() {
    super.initState();
    _startGlowAnimation();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  void _startGlowAnimation() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _isGlowing = !_isGlowing; // Toggle the glow state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 120.0),
                child: Container(
                  child: Text(
                    "TIC TAC TOE",
                    style: myNewFontWhite.copyWith(fontSize: 30),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: AvatarGlow(
                  animate: _isGlowing,
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white,
                  //endRadius: 140.0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        style: BorderStyle.none,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[900],
                      child: Container(
                        child: Image.asset(
                          'lib/images/tic.png',
                          color: Colors.white,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      radius: 80.0,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Container(
                  child: Text(
                    "@CREATEDBYRAISA",
                    style: myNewFontWhite.copyWith(fontSize: 12),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 60),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'PLAY GAME',
                        style: myNewFont,
                      ),
                    ),
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
