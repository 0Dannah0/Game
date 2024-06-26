import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mario_game/game/car_race.dart';

class MainMenuOverlay extends StatefulWidget {
  const MainMenuOverlay(this.game, {super.key});

  final Game game;

  @override
  State<MainMenuOverlay> createState() => _MainMenuOverlayState();
}

class _MainMenuOverlayState extends State<MainMenuOverlay> {
  Character character = Character.ate;

  @override
  Widget build(BuildContext context) {
    CarRace game = widget.game as CarRace;

    return LayoutBuilder(builder: (context, constraints) {
      final characterWidth = constraints.maxWidth / 5;

      final TextStyle titleStyle = (constraints.maxWidth > 830)
          ? Theme.of(context).textTheme.displayLarge!
          : Theme.of(context).textTheme.displaySmall!;

      return Material(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'The Runaways',
                    style: titleStyle.copyWith(
                      height: .8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Run from Mom, Run for your Life!',
                        style: Theme.of(context).textTheme.titleMedium!),
                  ),
                  const WhiteSpace(),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Select your Character:',
                        style: Theme.of(context).textTheme.headlineSmall!),
                  ),
                  const WhiteSpace(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CharacterButton(
                        character: Character.ate,
                        selected: character == Character.ate,
                        onSelectChar: () {
                          setState(() {
                            character = Character.ate;
                          });
                        },
                        characterWidth: characterWidth,
                      ),
                      CharacterButton(
                        character: Character.kuya,
                        selected: character == Character.kuya,
                        onSelectChar: () {
                          setState(() {
                            character = Character.kuya;
                          });
                        },
                        characterWidth: characterWidth,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CharacterButton(
                        character: Character.bunso,
                        selected: character == Character.bunso,
                        onSelectChar: () {
                          setState(() {
                            character = Character.bunso;
                          });
                        },
                        characterWidth: characterWidth,
                      ),
                    ],
                  ),
                  const WhiteSpace(height: 50),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        game.gameManager.selectCharacter(character);
                        game.startGame();
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size(100, 50),
                        ),
                        textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.titleLarge),
                      ),
                      child: const Text('Start'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CharacterButton extends StatelessWidget {
  const CharacterButton(
      {super.key,
      required this.character,
      this.selected = false,
      required this.onSelectChar,
      required this.characterWidth});

  final Character character;
  final bool selected;
  final void Function() onSelectChar;
  final double characterWidth;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: (selected)
          ? ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(31, 64, 195, 255)))
          : null,
      onPressed: onSelectChar,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/game/${character.name}.png',
              height: characterWidth,
              width: characterWidth,
            ),
            const WhiteSpace(height: 18),
            Text(
              character.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class WhiteSpace extends StatelessWidget {
  const WhiteSpace({super.key, this.height = 100});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
