import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:render_stress_test/Constants/hitbox.dart';
import 'package:render_stress_test/Objects/groundChild.dart';
import 'package:render_stress_test/Objects/groundGroup.dart';
import 'package:render_stress_test/Scenes/mainGame.dart';
import 'package:flame/input.dart';

class GroundGenerator {
  double lastGroundAdding = 0;
  MainGame ctx;
  Sprite sprite;
  double distanceBeforeGenerateBlock = 0;
  double blockSize = 66;
  int upOrDown = 0;
  int nbOfBlocToGenerateUnderTheGround = 15;
  int heightLevel = 0;
  double heightModifier = 0;
  final int tunnelSize = 400;

  GroundGenerator(MainGame ctx) : ctx = ctx;

  void onLoad() async {
    heightLevel = 0;
    heightModifier = 0;

    sprite = await Sprite.load('rock.png',
        srcSize: Vector2.all(32.0), srcPosition: Vector2(0, 32));
  }

  void update() {
    if (ctx.camera.position.x % blockSize <= 1) {
      distanceBeforeGenerateBlock = blockSize;
      generateGround();
    }
  }

  void generateGround() {
    upOrDown = Random().nextInt(3) - 1;
    heightLevel += upOrDown;

    setHeightModifier();
    generateTopGround();
    generateBottomGround();
  }

  void generateTopGround() {
    double yPosition =
        ctx.size.y - ctx.size.y / 2 - tunnelSize / 2 + heightModifier;

    GroundChild baseGround() => GroundChild()
      ..size = Vector2(blockSize, blockSize)
      ..sprite = sprite
      ..texture
      ..flipVertically();

    GroundGroup groundGroup = GroundGroup()
      ..y = yPosition
      ..x = ctx.camera.position.x + ctx.size.x + 40;

    // Top (Bottom of the cavern)
    if (upOrDown == 1)
      groundGroup.add(baseGround()
        // ..angle = pi / 2 * 1
        ..type = GroundType.DIAGONAL
        ..boxType = BoxType.DIAGONAL
        ..flipHorizontally());

    // Top (Bottom of the cavern)
    if (upOrDown == 0)
      groundGroup.add(baseGround()
        // ..angle = pi / 2 * 1
        ..type = GroundType.SURFACE
        ..boxType = BoxType.SURFACE);

    // Top (Bottom of the cavern)
    if (upOrDown == -1)
      groundGroup.add(baseGround()
        // ..angle = pi / 2 * 1
        ..type = GroundType.DIAGONAL
        ..boxType = BoxType.DIAGONAL);

    // The rest (Under the surface)
    for (int i = 1; i < nbOfBlocToGenerateUnderTheGround; i++) {
      groundGroup
        ..x = ctx.camera.position.x + ctx.size.x + 40
        ..y = yPosition
        ..add(baseGround()
          ..type = GroundType.MIDDLE
          ..boxType = BoxType.MIDDLE
          ..y = -blockSize * i);
    }

    ctx.add(groundGroup);
  }

  void setHeightModifier() {
    heightModifier = heightLevel * blockSize;
  }

  void generateBottomGround() {
    double yPosition =
        ctx.size.y - ctx.size.y / 2 + tunnelSize / 2 + heightModifier;

    GroundChild baseGround() => GroundChild()
      ..size = Vector2(blockSize, blockSize)
      ..sprite = sprite;

    GroundGroup groundGroup = GroundGroup()
      ..y = yPosition
      ..x = ctx.camera.position.x + ctx.size.x + 40;

    // Top (Bottom of the cavern)
    if (upOrDown == 1)
      groundGroup.add(baseGround()
        ..type = GroundType.DIAGONAL
        ..boxType = BoxType.DIAGONAL
        ..flipHorizontally());

    // Top (Bottom of the cavern)
    if (upOrDown == 0)
      groundGroup.add(baseGround()
        // ..angle = pi / 2 * 1
        ..type = GroundType.SURFACE
        ..boxType = BoxType.SURFACE);

    // Top (Bottom of the cavern)
    if (upOrDown == -1)
      groundGroup.add(baseGround()
        // ..angle = pi / 2 * 1
        ..type = GroundType.DIAGONAL
        ..boxType = BoxType.DIAGONAL);

    // The rest (Under the surface)
    for (int i = 1; i < nbOfBlocToGenerateUnderTheGround; i++) {
      groundGroup
        ..x = ctx.camera.position.x + ctx.size.x + 40
        ..y = yPosition
        ..add(baseGround()
          ..type = GroundType.MIDDLE
          ..boxType = BoxType.MIDDLE
          ..y = blockSize * i);
    }

    ctx.add(groundGroup);
  }
}
