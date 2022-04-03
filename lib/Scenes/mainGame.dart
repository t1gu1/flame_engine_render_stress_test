import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:render_stress_test/Constants/overlays.dart';
import 'package:render_stress_test/Generator/groundGenerator.dart';
import 'package:render_stress_test/Objects/player.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MainGame extends FlameGame
    with HasTappables, HasCollisionDetection, KeyboardEvents, FPSCounter {
  bool running = true;
  static Player player;
  static bool pause = true;
  static GroundGenerator groundGenerator;
  final TextPaint fpsTextPaint = TextPaint();

  MainGame() {
    groundGenerator = GroundGenerator(this);
  }

  @override
  Future<void> onLoad() async {
    // Flame.device.setPortrait(); // This cause an error for browser

    await restart();
  }

  @override
  void update(double dt) {
    if (pause) super.pauseEngine();
    super.update(dt);

    groundGenerator.update();

    if (player != null && player.dead) {
      overlays.add(Overlays.PAUSE_MENU);
      pause = true;
      super.pauseEngine();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    fpsTextPaint.render(
      canvas,
      '${fps(120).toStringAsFixed(2)}fps',
      Vector2(0, size.y - 24),
    );
  }

  void onKeyPress() {
    restart();

    pause = false;
    super.resumeEngine();
    overlays.remove(Overlays.PAUSE_MENU);
  }

  @override
  onTapDown(int pointerId, TapDownInfo event) {
    if (!pause) {
      super.onTapDown(pointerId, event);
    }

    onKeyPress();
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      player.y += -60;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      player.y += 60;
    }

    if (isSpace && isKeyDown) {
      onKeyPress();
    }
    return KeyEventResult.ignored;
  }

  Future<void> restart() async {
    this.removeAll(children);
    // debugMode = true;
    groundGenerator.onLoad();

    addAll({
      player = Player()
        ..x = size.x / 2
        ..y = size.y / 2 - 90
        ..image = SpriteSheet(
          image: await images.load('rock.png'),
          srcSize: Vector2.all(32.0),
        ),
    });

    camera.followComponent(player);
  }
}
