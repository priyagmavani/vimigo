import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:vimigo_assessment/routes/routes.dart';
import 'package:vimigo_assessment/screens/homepage.dart';
import 'package:vimigo_assessment/screens/onboarding.dart';
import 'package:vimigo_assessment/services/add_user.dart';

void main() async {
  var animation = GameWidget(game: Animation());
  runApp(
    MyApp(animation),
  );
}

class Animation extends FlameGame {
  double animationScaleFactor = 0.5;
  late SpriteAnimationComponent animation;
  

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    Image animationImage = await images.load('spritesheet.png');
    var vimigoAnimation = SpriteAnimation.fromFrameData(
        animationImage,
        SpriteAnimationData.sequenced(
          amount: 35,
          stepTime: 0.1,
          textureSize: Vector2(170, 170),
          amountPerRow: 12,
        ));

    animation = SpriteAnimationComponent()
      ..animation = vimigoAnimation
      ..size = Vector2(170, 170) * animationScaleFactor
      ..anchor = const Anchor(1, 1)
      ..position = Vector2(380, 730);

    add(animation);
  }
}

class MyApp extends StatelessWidget {
  MyApp(this.animation, {super.key});
  var animation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:
          onboardingRoute,
      routes: {
        homePageRoute: (context) => HomePage(animation),
        addUserRoute: (context) => const AddUser(),
        onboardingRoute: (context) => const OnBoarding(),
      },
    );
  }
}
