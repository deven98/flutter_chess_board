# flutter_chess_board

A Chess Board widget for Flutter. The widget maintains game state and supplies callbacks for things
like a move, checkmate or draw. This widget is still is active development.

![alt text](https://github.com/deven98/flutter_chess_board/blob/master/screen_shot.png)

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

### Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
