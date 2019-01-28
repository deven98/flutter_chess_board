# flutter_chess_board

A Chessboard Widget for Flutter. The widget maintains game state and gives callbacks for game events 
like moves, checkmate and draws. Under final testing before 1.0.

![alt text](https://github.com/deven98/flutter_chess_board/blob/master/screen_shot.png)

![alt text](https://github.com/deven98/flutter_chess_board/blob/master/screen_shot_2.png)

![alt text](https://github.com/deven98/flutter_chess_board/blob/master/screen_shot_3.png)

### Import the package 

To use this package, [add chess_board as a dependency](https://pub.dartlang.org/packages/flutter_chess_board#-installing-tab-) in your pubspec.yaml

### Example

        import 'package:flutter/material.dart';
        import 'package:flutter_chess_board/flutter_chess_board.dart';
        
        void main() {
          runApp(
            new MaterialApp(
              home: new Scaffold(
                body: new Center(
                  child: ChessBoard(
                    size: 200.0,
                    onMove: (move) {
                      print(move);
                    },
                    onCheckMate: (color) {
                      print(color);
                    },
                    onDraw: () {
                      print("DRAW!");
                    },
                  ),
                ),
              ),
            ),
          );
        }

## Board parameters:

### size: 

Gives length and width of chess board

### boardType:

Type of board to display (Brown, Green, etc.)

### onMove:

Callback for when a move is made. Returns a move as a string. E.g.: "Nf4"

### onDraw:

Callback for when game becomes a draw.

### onCheckMate: 

Callback for when a player checkmates the other. Returns the color of the winner.

### whiteSideTowardsUser:

Defines if white or black side faces user. The player is white by default(true). If 
set to false, black faces the user.

### controller

Defines the ChessBoardController for the widget for changing the board programmatically.

### enableUserMoves

Disables user moves when set to false.

### Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
