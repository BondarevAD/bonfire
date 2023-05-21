import 'package:bonfire/bonfire.dart';
import 'package:example/shared/util/common_sprite_sheet.dart';

///
/// Created by
///
/// ─▄▀─▄▀
/// ──▀──▀
/// █▀▀▀▀▀█▄
/// █░░░░░█─█
/// ▀▄▄▄▄▄▀▀
///
/// Rafaelbarbosatec
/// on 28/01/22
class ZombieEnemy extends RotationEnemy
    with BlockMovementCollision, AutomaticRandomMovement {
  ZombieEnemy(Vector2 position)
      : super(
          position: position,
          size: Vector2(68, 43),
          animIdle: _getAnimation(),
          animRun: _getAnimation(),
        );

  static Future<SpriteAnimation> _getAnimation() {
    return Sprite.load('zombie.png').toAnimation();
  }

  @override
  void update(double dt) {
    super.update(dt);
    seePlayer(
        observed: (p) {
          seeAndMoveToPlayer(
            closePlayer: (player) {
              simpleAttackMelee(
                damage: 10,
                size: Vector2.all(size.y),
                animationRight: CommonSpriteSheet.blackAttackEffectRight,
              );
            },
            radiusVision: 128,
          );
        },
        radiusVision: 128,
        notObserved: () {
          runRandomMovement(
            dt,
            useAngle: true,
            maxDistance: 64,
            minDistance: 32,
          );
        });
  }

  @override
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: CommonSpriteSheet.smokeExplosion,
        position: position,
        size: Vector2.all(64),
      ),
    );
    gameRef.camera.shake(intensity: 4);
    removeFromParent();

    super.die();
  }

  @override
  Future<void> onLoad() {
    // add(
    //   CircleHitbox(
    //     radius: size.y / 2,
    //     position: Vector2(
    //       12.5,
    //       0,
    //     ),
    //   ),
    // );
    return super.onLoad();
  }
}
