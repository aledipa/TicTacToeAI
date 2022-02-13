/* 
 *  @Author: Alessandro Di Pasquale
 *  @GitHub: https://github.com/aledipa
 */

import 'dart:math';


//Basic scalable AI designed for playing tic tac toe
class PlAIer {
  //Strategies sources (not used) \/
  //Link 1: https://www.instructables.com/Winning-tic-tac-toe-strategies/
  //Link2: https://www.rd.com/article/how-to-win-tic-tac-toe/

  List<String> values;
  PlAIer({required this.values});

  //Corners
  static const topLeftCorner = 0;
  static const topRightCorner = 2;
  static const bottomLeftCorner = 6;
  static const bottomRightCorner = 8;
  static final corners = [topLeftCorner,    topRightCorner, 
                          bottomLeftCorner, bottomRightCorner];

  //Edges
  static const topLeftEdge = 1;
  static const topRightEdge = 3;
  static const bottomLeftEdge = 5;
  static const bottomRightEdge = 7;
  static final edges = [topLeftEdge,    topRightEdge, 
                        bottomLeftEdge, bottomRightEdge];
  

  //Center
  static const center = 4;

  //Tells if the given pos has a symbol already in it
  _isFree(int pos) {
    return (values[pos] != "O" && values[pos] != "X");
  }

  //Tells if the given pos is a corner or not
  bool _isInCorner(int pos) { 
    if (corners.contains(pos)) {
      return true;
    }
    return false;
  }

  //Tells if the given pos is an edge or not
  bool _isInEdge(int pos) { 
    if (edges.contains(pos)) {
      return true;
    }
    return false;
  }

  //Tells if the given pos is the center or not
  bool _isInCenter(int pos) {
    if (pos == center) {
      return true;
    }
    return false;
  }

  //Writes the "O" symbol in the given position
  bool _writeInPos(int pos) {
    try {
      if (_isFree(pos)) {
        values[pos] = "O";
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  //Tells if there is a row about to win
  int _whereIsItWinningHorizontal() {
    int j=0;
    for (int i=0; i<3; i++) {
      //Left to Right
      int a=j, b=j+1, c=b+1;
      if ((values[a].isNotEmpty) && (values[a] == values[b] && _isFree(c))) {
        return c;
      }
      //Right to Left
      c=j; b=j+1; a=b+1;
      if ((values[a].isNotEmpty) && (values[a] == values[b] && _isFree(c))) {
        return c;
      }
      //Right to Left (center)
      if ((values[a].isNotEmpty) && (values[a] == values[c] && _isFree(b))) {
        return b;
      }
      j += 3;
    }
    return -1;
  }

  //Tells if there is a column about to win
  int _whereIsItWinningVertical() {
    int j=0;
    for (int i=0; i<3; i++) {
      //Bottom to Top
      int a=j, b=j+3, c=b+3;
      if ((values[a].isNotEmpty) && (values[a] == values[b] && _isFree(c))) {
        return c;
      }
      //Top to Bottom
      c=j; b=j+3; a=b+3;
      if ((values[a].isNotEmpty) && (values[a] == values[b] && _isFree(c))) {
        return c;
      }
      //Top to Bottom (center)
      if ((values[a].isNotEmpty) && (values[a] == values[c] && _isFree(b))) {
        return b;
      }
      j++;
    }
    return -1;
  }

  //Tells if there is an oblique line about to win
  int _whereIsItWinningOblique() {
    //Checks from TL to BR
    if ((values[topLeftCorner].isNotEmpty) && (values[topLeftCorner] == values[center] && _isFree(bottomRightCorner))) { //_isFree() bottomRightCorner
      return bottomRightCorner;
    //Checks from TR to BL
    } else if ((values[topRightCorner].isNotEmpty) && (values[topRightCorner] == values[center] && _isFree(bottomLeftCorner))) { //== values[6]
      return bottomLeftCorner;
    //Checks from BR to TL
    } else if ((values[bottomRightCorner].isNotEmpty) && (values[bottomRightCorner] == values[center] && _isFree(topLeftCorner))) { //== values[6]
      return topLeftCorner;
    //Checks from BL to TR
    } else if ((values[bottomLeftCorner].isNotEmpty) && (values[bottomLeftCorner] == values[center] && _isFree(topRightCorner))) { //== values[6]
      return topRightCorner;
    //Checks from TL to BR (center)
    } else if((values[topLeftCorner].isNotEmpty) && (values[topLeftCorner] == values[bottomRightCorner] && _isFree(center))) {
      return center;
    //Checks from BL to TR (center)
    } else if((values[bottomLeftCorner].isNotEmpty) && (values[bottomLeftCorner] == values[topRightCorner] && _isFree(center))) {
      return center;
    } else {
      return -1;
    }
  }

  //Writes the "O" symbol in the given corner
  bool _writeInCorner(String wantedCorner) {
    try {
      switch(wantedCorner.toLowerCase().replaceAll("-", "")) {
        case "topleft":
          _writeInPos(topLeftCorner);
          return true;
        case "topright":
          _writeInPos(topRightCorner);
          return true;
        case "bottomleft":
          _writeInPos(bottomLeftCorner);
          return true;
        case "bottomright":
          _writeInPos(bottomRightCorner);
          return true;
        case "random":
          var randomIndex = Random().nextInt(3);
          var randomPos = corners[randomIndex];
          _writeInPos(randomPos);
          return true;
        default:
          return false;
      }
    } catch(e) {
      return false;
    }
  }

  //Writes the "O" symbol in the given edge
  bool _writeInEdge(String wantedEdge) {
    try {
      switch(wantedEdge.toLowerCase().replaceAll("-", "")) {
        case "topleft":
          _writeInPos(topLeftEdge);
          return true;
        case "topright":
          _writeInPos(topRightEdge);
          return true;
        case "bottomleft":
          _writeInPos(bottomLeftEdge);
          return true;
        case "bottomright":
          _writeInPos(bottomRightEdge);
          return true;
        case "random":
          var randomIndex = Random().nextInt(3);
          var randomPos = edges[randomIndex];
          _writeInPos(randomPos);
          return true;
        default:
          return false;
      }
    } catch(e) {
      return false;
    }
  }

  //Writes the "O" symbol in center
  bool _writeInCenter() {
    try {
      _writeInPos(center);
      return true;
    } catch(e) {
      return false;
    }
  }

  //Decides casually where to write
  _writeDumb() {
    var randomPos = Random().nextInt(8);
    if (_isFree(randomPos))  {
      _writeInPos(randomPos);
    } else {
      _writeDumb();
    }
  }

  //Represents the playing logic and returns the updated grid
  List<String> move(List<String> values) {
    // === EXAMPLE === 

      // if (_isInCenter(2)) {
      //   _writeInCorner("random");
      // } else {
      //   _writeInCenter();
      // }

    // === /EXAMPLE === 

    int pos = _whereIsItWinningOblique();
    if (pos >= 0) {
      _writeInPos(pos);
    } else {
      pos = _whereIsItWinningHorizontal();
      if (pos >= 0) {
        _writeInPos(pos);
      } else {
        pos = _whereIsItWinningVertical();
        if (pos >= 0) {
          _writeInPos(pos);
        } else {
          _writeDumb();
        }
      }
    }

    return values;
  }

}