import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> tiled = [' ',' ',' ',' ',' ',' ',' ',' ',' '];
  List<int> pressed = [0,0,0,0,0,0,0,0,0];
  int player = 0;
  int clicked=0;

  Widget createBoard(int index){
      return Container(
        margin: EdgeInsets.all(2.5),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: 
        TextButton(
        child: Text(
          tiled[index],
          style: TextStyle(
            fontSize: 60,
            fontFamily: 'FredokaOne',
            color: tiled[index] == 'x' ? Color(0XFF3867d6) : Colors.orange[900],
          ),
        ),
        onPressed: () {
          setState(() {
            if(pressed[index]==0){
              pressed[index]++;
              clicked++;
              if(player == 0){
                tiled[index] = 'x';
                player++;
              }
              else{
                tiled[index]='o';
                player--;
              }
              _checkWinner();
            }
          });
        },
        ),
      );
    }
  
    void restart(){ //diubah ke async
      player=0;
      clicked=0;
      for(int i=0;i<9;i++){
        tiled[i]=' ';
        pressed[i] = 0;
      }
    }

    Future openDialog(int index, String status) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                margin: EdgeInsets.only(bottom: 10.0),
                child: Column(
                  children: [
                    Text(
                      status=='win' ? '${tiled[index]}' : ' ',
                      style: TextStyle(
                        fontFamily: 'FredokaOne',
                        color: tiled[index] == 'x' ? Color(0XFF3867d6) : Colors.orange[900],
                        fontSize: 99,
                      ),
                    ),
                    Text(
                      status=='win' ? 'winning' : 'DRAW',
                      style: TextStyle(
                        color: Colors.brown[900],
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                setState(() {
                  restart();
                });
              }, 
              child: Text('play again'))
          ]
      ));

      
    void _checkWinner() {

      // Checking rows
        if (tiled[0] == tiled[1] &&
            tiled[0] == tiled[2] &&
            tiled[0] != ' ') {
            openDialog(0,'win');
        }
        else if (tiled[3] == tiled[4] &&
            tiled[3] == tiled[5] &&
            tiled[3] != ' ') {
            openDialog(3,'win');
        }
        else if (tiled[6] == tiled[7] &&
            tiled[6] == tiled[8] &&
            tiled[6] != ' ') {
            openDialog(6,'win');
        }
    
        // Checking Column
        else if (tiled[0] == tiled[3] &&
            tiled[0] == tiled[6] &&
            tiled[0] != ' ') {
            openDialog(0,'win');
        }
        else if (tiled[1] == tiled[4] &&
            tiled[1] == tiled[7] &&
            tiled[1] != ' ') {
            openDialog(1,'win');
        }
        else if (tiled[2] == tiled[5] &&
            tiled[2] == tiled[8] &&
            tiled[2] != ' ') {
            openDialog(2,'win');
        }
    
        // Checking Diagonal
        else if (tiled[0] == tiled[4] &&
            tiled[0] == tiled[8] &&
            tiled[0] != ' ') {
            openDialog(0,'win');
        }
        else if (tiled[2] == tiled[4] &&
            tiled[2] == tiled[6] &&
            tiled[2] != ' ') {
            openDialog(2,'win');
        } 
        else if (clicked == 9) {
            openDialog(0,'draw');
        }
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    player==0?'X':'O',
                    style: TextStyle(
                      color: player==1?Colors.orange[900]:Color(0XFF3867d6),
                      fontFamily: 'FredokaOne',
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    ' TURN',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'FredokaOne',
                      fontSize: 40,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  createBoard(0),
                  createBoard(1),
                  createBoard(2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  createBoard(3),
                  createBoard(4),
                  createBoard(5),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  createBoard(6),
                  createBoard(7),
                  createBoard(8),
                ],
              ),
              SizedBox(
                height: 75,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                width: 150,
                height: 40,
                child: Row(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: (){
                        setState(() {
                          restart();
                        });
                      }, 
                      child:Text(
                        'Restart Game',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}