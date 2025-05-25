import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Game extends StatefulWidget {
  const Game({super.key, required this.player1, required this.player2}); // Added const and key

  final String player1;
  final String player2;

  @override
  State<Game> createState() => _GameState(); // Added <Game>

}

class _GameState extends State<Game> { // Added <Game>

  final String player1val = "X";
  final String player2val = "O";

  String? currentPlayer;
  String? currentPlayerval;
  bool? gameOver;
  List<String>? board; // Added <String>

  int player1Score = 0;
  int player2Score = 0;


  LinearGradient linear = const LinearGradient( // Added const
      colors: [Color(0xFF95F3FD), Color(0xFF00BBB6)],
      stops: [0.0, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void changeTurn() {
    if (currentPlayerval == player1val) {
      currentPlayerval = player2val;
      currentPlayer = '${widget.player2}(O)';
    } else {
      currentPlayerval = player1val;
      currentPlayer = '${widget.player1}(X)';
    }
  }

  void winningCheck() {
    List<List<int>> winningPattern = [ // Added <List<int>>
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winningPatternPosition in winningPattern) {
      String winningPatternPosition0 = board![winningPatternPosition[0]];
      String winningPatternPosition1 = board![winningPatternPosition[1]];
      String winningPatternPosition2 = board![winningPatternPosition[2]];

      if (winningPatternPosition1.isNotEmpty) {
        if (winningPatternPosition0 == winningPatternPosition1 &&
            winningPatternPosition1 == winningPatternPosition2) {
          //  all equals
          if (winningPatternPosition1 == "X") {
            player1Score++;
            _gameOverMessage("${widget.player1} Wins"); // Changed to _gameOverMessage
            gameOver = true;
            return;
          } else {
            player2Score++;
            _gameOverMessage("${widget.player2} Wins"); // Changed to _gameOverMessage
            gameOver = true;
            return;
          }
        }
      }
    }
  }

  void checkForDraw() {
    if (gameOver!) {
      return;
    }

    bool check = true;
    for (var boardFilled in board!) {
      if (boardFilled.isEmpty) {
        check = false;
      }
    }

    if (check) {
      _gameOverMessage("Draw"); // Changed to _gameOverMessage
      gameOver = true;
    }
  }

  void _gameOverMessage(String message) { // Changed to _gameOverMessage and made it private

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              backgroundColor: const Color(0xFFFFDE9B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Set border radius here
              ),
              actions: [
                const Center(
                  child: Text(
                    "Game Over",
                    style: TextStyle(
                        fontSize: 40,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    message,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height:20),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        "Scoreboard:",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${widget.player1}: $player1Score",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${widget.player2}: $player2Score",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 200.0,
                    height: 55.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          initializeGame();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: const Color(0xFF014B78),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.restart_alt,
                            size: 40.0,
                            color: Colors.black,
                          ),
                          Text(
                            'Restart',
                            style: TextStyle(
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          );
        });
  }

  void initializeGame() {
    currentPlayer = '${widget.player1}(X)';
    currentPlayerval = player1val;
    gameOver = false;
    board = ["", "", "", "", "", "", "", "", ""];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: linear),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 95,
                ),
                Column(children: [
                  Text('Turn:',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: Color(0xFFB89D45),
                          fontWeight: FontWeight.w900,

                          fontSize: 60,
                        ),
                      )),
                  Text(currentPlayer!,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 45,
                        ),
                      )),
                ]),
                const SizedBox(
                  height: 30,
                ),
                SizedBox( // Changed to SizedBox
                  width: MediaQuery.of(context).size.height / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: board!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (gameOver! || board![index].isNotEmpty) {
                            return;
                          }

                          setState(() {
                            board![index] = currentPlayerval!;
                            changeTurn();
                            winningCheck();
                            checkForDraw();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFFAE59C),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              board![index],
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    color: Color(0xFF006C69),
                                    fontSize: 65,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
