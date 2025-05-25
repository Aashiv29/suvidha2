import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'game.dart';


  class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  ScreenState createState() => ScreenState();
}

class ScreenState extends State {

  String? player1;
  String? player2;

  LinearGradient linear=LinearGradient(
      colors: [Color(0xFF95F3FD),Color(0xFF00BBB6)],
      stops: [0.0,1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient:linear
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child:Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Player Name',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    HeadingText(name: 'Player 1 : X'),
                    SizedBox(height: 3,),

                    SizedBox(height: 20,),
                    TextField(
                      onChanged: (value){
                        setState(() {
                          player1=value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter',
                        filled: true,
                        fillColor: Colors.white ,
                        focusColor: Color(0xFFFBEF03),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFBEF03),    // Border color when focused/tapped
                            width: 4.0,                  // Border width
                          ),
                        ),
                        hintStyle: TextStyle(
                            color: Colors.black45
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    SizedBox(height: 30,),
                    HeadingText(name: 'Player 2 : O'),
                    SizedBox(height: 30,),
                    TextField(
                      onChanged: (value){
                        setState(() {
                          player2=value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter',
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Color(0xFFFBEF03),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFBEF03),    // Border color when focused/tapped
                            width: 4.0,                  // Border width
                          ),
                        ),
                        hintStyle: TextStyle(
                            color: Colors.black45
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 45,),
                    SizedBox(
                      width: double.infinity,
                      height: 65,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context)=>Game(
                            player1:player1! ,
                            player2: player2!,
                          )));
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(borderRadius:
                            BorderRadius.circular(50)),
                            backgroundColor: Color(0xFFFBEF03),
                            foregroundColor:Color(0xFF000000)
                        ),
                        child: Text(
                            'Start Game',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900
                                )
                            )
                        ),
                      ),
                    )
                  ]
              ),
            ),
          ) ,
        ),
      ),
    );
  }
}



class HeadingText extends StatelessWidget {
  const HeadingText({super.key, required this.name});


  final String name;
  @override
  Widget build(BuildContext context) {
    return  Text(
        name,
        style:GoogleFonts.openSans(
            textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 25
            )
        )
    );
  }
}