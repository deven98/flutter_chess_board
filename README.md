# flutter_chess_board

A Chessboard Widget for Flutter. Full support for PGN, FEN, SAN. Undo move, multiple board colors and arrow support.

v1.0 now has a new architecture where the [ChessBoardController] holds the state of the game.
`scoped_model` is now removed.

Arrows on the board are now supported.

![alt text](https://github.com/deven98/flutter_chess_board/blob/master/screen_shot_4.png)

![alt text](https://github.com/deven98/flutter_chess_board/blob/master/screen_shot.png)

![alt text](https://github.com/deven98/flutter_chess_board/blob/master/screen_shot_2.png)

![alt text](https://github.com/deven98/flutter_chess_board/blob/master/screen_shot_3.png)

### Import the package 

To use this package, [add chess_board as a dependency](https://pub.dartlang.org/packages/flutter_chess_board#-installing-tab-) in your pubspec.yaml

### Example

```
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

### Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
