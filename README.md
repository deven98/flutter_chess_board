# chess_board

A Chess Board widget for Flutter.



### Import the package 

To use this package, [add chess_board as a dependency](https://pub.dartlang.org/packages/chess_board#-installing-tab-) in your pubspec.yaml

### Example

        import 'package:flutter/material.dart';
        import 'package:chess_board/chess_board.dart';
        
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
