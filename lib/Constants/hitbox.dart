import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum BoxType {
  MIDDLE,
  SURFACE,
  DIAGONAL,
}

class HitboxType {
  PolygonComponent hitbox;
  double wallSize = 10;

  HitboxType(BoxType type, Vector2 size) {
    switch (type) {
      case BoxType.MIDDLE:
        hitbox = RectangleHitbox()..collisionType = CollisionType.passive;
        break;

      case BoxType.SURFACE:
        hitbox = RectangleHitbox(
            position: Vector2(0, size[1] - wallSize),
            size: Vector2(size[0], wallSize))
          ..collisionType = CollisionType.passive;
        break;

      case BoxType.DIAGONAL:
        hitbox = PolygonHitbox([
          Vector2(0, 0),
          Vector2(size[0], size[1]),
          Vector2(0, size[1]),
        ])
          ..collisionType = CollisionType.passive;
        break;
    }
  }
}
