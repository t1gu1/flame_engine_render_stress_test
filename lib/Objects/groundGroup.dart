import 'package:flame/components.dart';

class GroundGroup extends PositionComponent with HasGameRef {
  @override
  void update(double dt) {
    super.update(dt);

    if (gameRef.camera.position.x > x + width) {
      removeFromParent();
      // print("Ground remove from the game");
    }
  }
}
