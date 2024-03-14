import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool Oturn = true; //the 1st player is 0!
  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 25));
  List<String> DisplayExOh = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  int OScore = 0;
  int XScore = 0;
  int filledBox = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Player - O",
                          style: myNewFontWhite,
                        ),
                        Text(
                          OScore.toString(),
                          style: myNewFontWhite,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Player - X",
                          style: myNewFontWhite,
                        ),
                        Text(
                          XScore.toString(),
                          style: myNewFontWhite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: Center(
                        child: Text(DisplayExOh[index], style: myNewFontWhite),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (Oturn && DisplayExOh[index] == '') {
        DisplayExOh[index] = "O";
        filledBox += 1;
      } else if (!Oturn && DisplayExOh[index] == '') {
        DisplayExOh[index] = "X";
        filledBox += 1;
      }
      Oturn = !Oturn;
      checkwinner();
    });
  }

  void checkwinner() {
    //row
    if (DisplayExOh[0] == DisplayExOh[1] &&
        DisplayExOh[0] == DisplayExOh[2] &&
        DisplayExOh[0] != "") {
      showWinDialog(DisplayExOh[0]);
    } else if (DisplayExOh[3] == DisplayExOh[4] &&
        DisplayExOh[3] == DisplayExOh[5] &&
        DisplayExOh[3] != "") {
      showWinDialog(DisplayExOh[3]);
    } else if (DisplayExOh[6] == DisplayExOh[7] &&
        DisplayExOh[6] == DisplayExOh[8] &&
        DisplayExOh[6] != "") {
      showWinDialog(DisplayExOh[6]);
    }
    //diagonal
    else if (DisplayExOh[0] == DisplayExOh[4] &&
        DisplayExOh[0] == DisplayExOh[8] &&
        DisplayExOh[0] != "") {
      showWinDialog(DisplayExOh[0]);
    } else if (DisplayExOh[2] == DisplayExOh[4] &&
        DisplayExOh[2] == DisplayExOh[6] &&
        DisplayExOh[2] != "") {
      showWinDialog(DisplayExOh[2]);
    }
    // column
    else if (DisplayExOh[0] == DisplayExOh[3] &&
        DisplayExOh[0] == DisplayExOh[6] &&
        DisplayExOh[0] != "") {
      showWinDialog(DisplayExOh[0]);
    } else if (DisplayExOh[1] == DisplayExOh[4] &&
        DisplayExOh[1] == DisplayExOh[7] &&
        DisplayExOh[1] != "") {
      showWinDialog(DisplayExOh[1]);
    } else if (DisplayExOh[2] == DisplayExOh[5] &&
        DisplayExOh[2] == DisplayExOh[8] &&
        DisplayExOh[2] != "") {
      showWinDialog(DisplayExOh[2]);
    } else if (filledBox == 9) {
      showDrawDialog();
    }
  }

  void showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Draw!")),
            actions: [
              ElevatedButton(
                child: Text("Play Again"),
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("The Winner is $winner!")),
            actions: [
              ElevatedButton(
                child: Text("Play Again"),
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == "O") {
      OScore += 1;
    } else if (winner == "X") {
      XScore += 1;
    }
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        DisplayExOh[i] = '';
      }
    });
    filledBox = 0;
  }
}
