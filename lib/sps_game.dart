import 'dart:math';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> images = [
    "assets/rock.png",
    "assets/paper.png",
    "assets/scissor.png"
  ];
  int compOpt = 0;
  final Random random = Random();

  int decideWin(int index) {
    compOpt = random.nextInt(3);
    switch (index) {
      case 0:
        if (compOpt == index) {
          return -1;
        } else if (compOpt == 1) {
          return 1;
        } else {
          return 0;
        }
      case 1:
        if (compOpt == index) {
          return -1;
        } else if (compOpt == 0) {
          return 0;
        } else {
          return 1;
        }
      case 2:
        if (compOpt == index) {
          return -1;
        } else if (compOpt == 1) {
          return 0;
        } else {
          return 1;
        }
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xFFA0F7FF),
        title: Text(
          'ROCK PAPER \n \t SCISSOR',
          style: TextStyle(
            fontSize: 27,
            color: Colors.black,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
      ),
      backgroundColor: Color(0xFF8ACCDC),
      body: Column(
        children: [
          SizedBox(
            height: 95,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Game Rules :".toUpperCase(),
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "1. paper win rock".toUpperCase(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "2. rock win scissors ".toUpperCase(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "3. scissors win paper".toUpperCase(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 95,
          ),
          Expanded(
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 3; i++)
                GestureDetector(
                  onTap: () {
                    final winner = decideWin(i);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Result"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Text("You Chose : "),
                                      Image.asset(
                                        images[i],
                                        width: 50,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Text("Comp Chose : "),
                                      Image.asset(
                                        images[compOpt],
                                        width: 50,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    winner == -1
                                        ? "Urge, it's a tie"
                                        : winner == 0
                                        ? "Congratulations You Win !"
                                        : "Sorry! You Lose",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: winner == -1
                                          ? Colors.purple
                                          : winner == 0
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: Text("Play Again"),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 120,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        images[i],
                      ),
                    ),
                  ),
                )
            ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
