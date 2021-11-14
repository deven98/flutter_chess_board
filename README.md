# flutter_chess_board

A full-fledged Chessboard widget for Flutter. Includes the Chessboard widget, stores game 
state, and includes a controller to check and manipulate game state. 

Full support for formats like PGN, FEN as well as ASCII. Supports multiple colors and displaying 
arrows on the board. Easy access to making / undoing moves on the board. 

Note: v1.0+ is a major refactor and the earlier architecture which used `scoped_model` internally 
is no longer in use. The `ChessBoardController` now stores the state of the game as well as contains 
options to change and check state. Arrows on the board are now supported.

## Setting Up

Add a `ChessBoard` widget and attach a `ChessBoardController` to it.

Let's also set the board color and specify the board orientation (default is towards white).

```dart
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
        
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ChessBoardController controller = ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Demo'),
      ),
      body: Center(
        child: ChessBoard(
          controller: controller,
          boardColor: BoardColor.orange,
          boardOrientation: PlayerColor.white,
        ),
      ),
    );
  }
}
```

Let's try to display arrows on the board and also display moves of the current game:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
        
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ChessBoardController controller = ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ChessBoard(
                controller: controller,
                boardColor: BoardColor.orange,
                arrows: [
                  BoardArrow(
                    from: 'd2',
                    to: 'd4',
                    color: Colors.red.withOpacity(0.5),
                  ),
                ],
                boardOrientation: PlayerColor.white,
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Chess>(
              valueListenable: controller,
              builder: (context, game, _) {
                return Text(
                  controller.getSan().fold(
                        '',
                        (previousValue, element) =>
                            previousValue + '\n' + (element ?? ''),
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

This gives us:

![alt text](https://github.com/deven98/flutter_chess_board/blob/master/screen_shot_4.png)

### Watch for game changes

You can listen to game state changes (move, half moves, etc) using either a listener or a `ValueListenableBuilder`:

```dart
  ChessBoardController controller = ChessBoardController();
  
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      // Do something here
    });
  }
```

```dart
  ValueListenableBuilder<Chess>(
    valueListenable: controller,
    builder: (context, game, _) {
      // Build on new game state
    },
  ),
```

## Checking Game States

The `ChessBoardController` holds the game itself and you can do various kinds of things using it:

### Load New Game

`controller.loadPgn('demo PGN')`

`controller.loadFen('demo FEN')`

### Make Move:

`controller.makeMove(from: 'd2', to: 'd4')`

### Undo Move:

`controller.undoMove()`

### Check states:

`controller.isCheckMate()`

`controller.isDraw()`

`controller.isStaleMate()`

`controller.isThreefoldRepetition`

...and more...

### Move Count 

`controller.getMoveCount()`

`controller.getHalfMoveCount()`

### Other Board Types

![alt text](https://github.com/deven98/flutter_chess_board/blob/master/screen_shot.png)

![alt text](https://github.com/deven98/flutter_chess_board/blob/master/screen_shot_2.png)

![alt text](https://github.com/deven98/flutter_chess_board/blob/master/screen_shot_3.png)

### Import the package 

To use this package, [add chess_board as a dependency](https://pub.dartlang.org/packages/flutter_chess_board#-installing-tab-) in your pubspec.yaml

