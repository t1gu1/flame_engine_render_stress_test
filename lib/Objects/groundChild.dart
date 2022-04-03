import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:render_stress_test/Constants/hitbox.dart';
import 'package:flutter/material.dart';

enum GroundType { SURFACE, MIDDLE, DIAGONAL }

class GroundChild extends SpriteComponent
    with GestureHitboxes, CollisionCallbacks {
  BoxType boxType;
  GroundType type;
  var hitbox;
  int texture = 0;

  @override
  void onMount() {
    anchor = Anchor.center;
    texture = Random().nextInt(2);

    // sprite.getSprite(getSpriteType(type), texture);
    // this.
    if (boxType != BoxType.MIDDLE) {
      add(hitbox = HitboxType(boxType, size).hitbox);
    }
  }

  getSpriteType(GroundType groundType) {
    switch (groundType) {
      case GroundType.DIAGONAL:
        return 0;
        break;
      case GroundType.MIDDLE:
        return 1;
        break;
      case GroundType.SURFACE:
        return 2;
        break;
    }
  }
}
