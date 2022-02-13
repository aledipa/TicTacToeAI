/* 
 *  @Author: Alessandro Di Pasquale
 *  @GitHub: https://github.com/aledipa
 */

import 'package:flutter/material.dart';
import 'bots/player_ai.dart';



void main() {
  runApp(const Tris());
}

class Tris extends StatelessWidget {
  const Tris({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac To!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TrisHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TrisHome extends StatefulWidget {
  const TrisHome({Key? key}) : super(key: key);

  @override 
  TrisHomeState createState() => TrisHomeState();
}

class TrisHomeState extends State<TrisHome> {
  //Controller of the grid
  final TextEditingController _gridController = TextEditingController(text: "         ");
  //Controller of the title
  final TextEditingController _titleController = TextEditingController(text: "Now Playing: X");
  //Checks if the AI is active or not
  bool isChecked = false;
  //Counts the played moves
  int moves = 0;
  //Grid matrix of values
  List<String> values = [
                          "", "", "", 
                          "", "", "", 
                          "", "", ""
                        ];

  //Returns whose turn it is
  String getCurrentPlayer() {
    if (moves % 2 == 0) {
      return "X";
    } else {
      return "O";
    }
  }

  //Returns the color of the symbol based on the current player
  Color getCurrentColor(pos) {
    if (values[pos].isEmpty) {
      return Colors.transparent;
    } else if (values[pos] == "X") {
      return Colors.red;
    } else if(values[pos] == "v") {
      if (getCurrentPlayer() == "X") {
        return Colors.red;
      } else {
        return Colors.green;
      }
    } else {
      return Colors.green;
    }
  }

  //Returns the color of the AI's switch
  Color getSwitchColor(isChecked) {
    if (isChecked) {
      return Colors.greenAccent;
    }
    return Colors.white;
  }

  //Returns the border of every cell of the grid
  Border getBorder(pos) {
    switch(pos) {
      case 0:
        return const Border(
                  right: BorderSide(color: Colors.blue, width: 5),
                  bottom: BorderSide(color: Colors.blue, width: 5)
                );
      case 1:
        return const Border(
                  right: BorderSide(color: Colors.blue, width: 5),
                  bottom: BorderSide(color: Colors.blue, width: 5)
                );
      case 2:
        return const Border(
                  bottom: BorderSide(color: Colors.blue, width: 5)
                );
      case 3:
        return const Border(
                  right: BorderSide(color: Colors.blue, width: 5),
                  bottom: BorderSide(color: Colors.blue, width: 5)
                );
      case 4:
        return const Border(
                  right: BorderSide(color: Colors.blue, width: 5),
                  bottom: BorderSide(color: Colors.blue, width: 5)
                );
      case 5:
        return const Border(
                  bottom: BorderSide(color: Colors.blue, width: 5)
                );
      case 6:
        return const Border(
                  right: BorderSide(color: Colors.blue, width: 5),
                );
      case 7:
        return const Border(
                  right: BorderSide(color: Colors.blue, width: 5),
                );
      default:
        return const Border();
    }
  }

  //Tells if the TicTacToe's grid is full or not
  bool isFull() {
    for (int i=0; i<_gridController.text.length; i++) {
      if (_gridController.text[i] == " ") {
        return false;
      }
    }
    return true;
  }

  //Returns the cell color
  Color? getColor(pos) {
    if (values[pos] == "v") {
      if (isChecked && isVictory() && (getCurrentPlayer() == "O")) {
        return Colors.green[100];
      }
      if (getCurrentPlayer() == "X") {
        return Colors.red[100];
      } else {
        return Colors.green[100];
      }
    }
    return Colors.transparent;
  }
  
  //Marks the grid's cells that have to be highlighted due to a player's victory
  void setWinnerCells(a, b, c) {
    values[a] = "v";
    values[b] = "v";
    values[c] = "v";
  }

  //Restarts the game by resetting the current page
  void restart() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TrisHome()),);
  }

  //Shows up a victory message
  void showVictoryMessage() {
    _titleController.text = "Player ${getCurrentPlayer()} won!";
  }
  //Shows up a message which tells whose turn it is
  void showTurnMessage() {
    _titleController.text = "Now Playing: ${getCurrentPlayer()}";
  }
  //Shows up a draw message
  void showDrawMessage() {
    _titleController.text = "It's a Draw!";
  }

  //Tells if there is a winning row
  bool isHorizontalCompleted() {
    int j=0;
    for (int i=0; i<3; i++) {
      int a=j, b=j+1, c=b+1;
      if ((values[a].isNotEmpty) && (values[a] == values[b] && values[a] == values[c])) {
        setWinnerCells(a, b, c);
        return true;
      }
      j += 3;
    }
    return false;
  }

  //Tells if there is a winning column
  bool isVerticalCompleted() {
    int j=0;
    for (int i=0; i<3; i++) {
      int a=j, b=j+3, c=b+3;
      if ((values[a].isNotEmpty) && (values[a] == values[b] && values[a] == values[c])) {
        setWinnerCells(a, b, c);
        return true;
      }
      j++;
    }
    return false;
  }

  //Tells if there is a winning oblique line
  bool isObliqueCompleted() {
    if ((values[0].isNotEmpty) && (values[0] == values[4] && values[0] == values[8])) {
      setWinnerCells(0, 4, 8);
      return true;
    } else if ((values[2].isNotEmpty) && (values[2] == values[4] && values[2] == values[6])) {
      setWinnerCells(2, 4, 6);
      return true;
    } else {
      return false;
    }
  }

  //Tells if someone won
  bool isVictory() {
    if (isHorizontalCompleted() || isVerticalCompleted() || isObliqueCompleted()) {
      return true;
    }
    return false;
  }

  //Starts the Artificial "Intelligence"
  void triggerAI(PlAIer aiPlayer) {
    if(isChecked) {
      var newValues = aiPlayer.move(values);
      var newController = "";
      for (int i=0; i<_gridController.text.length; i++) {
        values[i] = newValues[i];
        if (newValues[i].isNotEmpty) {
          newController += newValues[i];
        } else {
          newController += " ";
        }
      }
      if (isChecked && (getCurrentPlayer() == "O") && isVictory()) {
        moves++;
      }
      setState(() {
        _gridController.text = newController;
      });
    }
  }

  @override 
  Widget build(BuildContext context) {
    PlAIer aiPlayer = PlAIer(values: values);
    if (isVictory()) {
      showVictoryMessage();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac To!"),
        centerTitle: true,
        leading: IconButton(onPressed: restart, icon: const Icon(Icons.replay_outlined)),
        
        actions: [
          Center(child: Text("AI", textAlign: TextAlign.center, style: TextStyle(color: getSwitchColor(isChecked)),)),
          Switch(
            activeColor: Colors.greenAccent,
            value: isChecked, 
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            }
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          height: 900,
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              Text(
                _titleController.text,
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.blueAccent),
              ),
              GridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
                crossAxisCount: 3,
                children: List.generate(9, (index) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: getBorder(index),
                        color: getColor(index),
                      ),
                      child: Text(_gridController.text[index], textAlign: TextAlign.center, style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: getCurrentColor(index), height: 2.1), ), //height: 2.7
                    ),
                    onTap: () {setState(() {
                      if(values[index].isEmpty && !isVictory()) {
                        //Updates the grid & matrix
                        _gridController.text = _gridController.text.substring(0, index) + getCurrentPlayer() + _gridController.text.substring(index+1);
                        values[index] = getCurrentPlayer();
                        if (isVictory()) {
                          showVictoryMessage();
                        } else if (isFull()) {
                          showDrawMessage();
                        } else {
                          if (getCurrentPlayer() == "X" && isChecked) {
                            moves++;
                            showTurnMessage();
                            triggerAI(aiPlayer);
                          }
                          moves++;
                          showTurnMessage();
                        }
                        print(values); //Shows in the Debug Console the grid's values in real time
                      }
                    });},
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}