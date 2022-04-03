// On the widget declaration
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'Constants/overlays.dart';
import 'Scenes/mainGame.dart';

final game = MainGame();

Widget pauseMenuBuilder(BuildContext buildContext, MainGame game) {
  onTap() {
    game.resumeEngine();
    game.restart();
    game.overlays.remove(Overlays.PAUSE_MENU);
  }

  return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 120),
          child: Center(
            child: Text('You died',
                style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 50,
                    color: Color(0xFFFFFFFF),
                    decoration: TextDecoration.none)),
          ),
        ),
      ));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return GameWidget(
      game: game,
      overlayBuilderMap: {
        Overlays.PAUSE_MENU: pauseMenuBuilder,
      },
    );
  }
}

void main() => runApp(Main());
