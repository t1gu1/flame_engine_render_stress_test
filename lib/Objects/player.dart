import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class Player extends PositionComponent
    with GestureHitboxes, CollisionCallbacks {
  static const _GRAVITY = 400.0;
  static const _squareSize = 60.0;

  static Paint white = BasicPalette.white.paint();
  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();

  double speedX = 2;
  SpriteSheet image;
  bool dead = false;

  @override
  void onMount() {
    super.onMount();
    size.setValues(_squareSize, _squareSize);
    anchor = Anchor.center;
    add(RectangleHitbox.relative(Vector2(1, 1),
        parentSize: Vector2(_squareSize / 2.2, _squareSize / 2.2),
        position: Vector2(_squareSize / 2, _squareSize / 2),
        anchor: Anchor.center));
  }

  @override
  void render(Canvas c) {
    super.render(c);

    // Body
    image.getSprite(0, 0).render(c,
        position: Vector2(0, 0), size: Vector2(_squareSize, _squareSize));
  }

  int velocityFrame(speed) {
    double minSpeed = 250.00;

    double speedSegment = minSpeed / 3;

    int frame = (speed / speedSegment).toInt();

    if (speed >= 0) frame = 0;

    return frame.abs();
  }

  @override
  void update(double dt) {
    super.update(dt);
    x += speedX;
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    dead = true;
    // Get.off(Menu());
  }
}
