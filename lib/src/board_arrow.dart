import 'package:flutter/material.dart';
import 'constants.dart';

class BoardArrow {
  final String from;
  final String to;
  final Color color;

  BoardArrow({
    required this.from,
    required this.to,
    Color? color,
  })  : assert(from.length == 2 && to.length == 2),
        assert(squareRegex.hasMatch(from)),
        assert(squareRegex.hasMatch(to)),
        this.color = color ?? Colors.black.withOpacity(0.5);

  @override
  bool operator ==(Object other) {
    return other is BoardArrow && from == other.from && to == other.to;
  }

  @override
  int get hashCode => from.hashCode * to.hashCode;
}
