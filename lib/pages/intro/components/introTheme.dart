import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mint/helpers/config.dart';
import 'package:mint/ui/animations/showUp.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ThemeSelected { System, Light, Dark }

class IntroTheme extends StatefulWidget {
  const IntroTheme({Key? key}) : super(key: key);

  @override
  _IntroThemeState createState() => _IntroThemeState();
}

class _IntroThemeState extends State<IntroTheme> {
  // Currently Selected Theme
  ThemeSelected? theme;
  final MyTheme currentTheme = GetIt.I<MyTheme>();

  @override
  void initState() {
    super.initState();
    theme = ThemeSelected.System;
  }

  @override
  Widget build(BuildContext context) {
    void checkTheme() {
      if (currentTheme.currentTheme() == ThemeMode.system) {
        theme = ThemeSelected.System;
      } else if (currentTheme.currentTheme() == ThemeMode.light) {
        theme = ThemeSelected.Light;
      } else if (currentTheme.currentTheme() == ThemeMode.dark) {
        theme = ThemeSelected.Dark;
      }
    }

    checkTheme();
    return SafeArea(
        child: Stack(
      alignment: Alignment.center,
      children: [
        ShowUpTransition(
          duration: const Duration(milliseconds: 600),
          forward: true,
          slideSide: SlideFromSlide.LEFT,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: Icon(EvaIcons.colorPaletteOutline,
                          size: 40, color: Colors.red),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Product Sans',
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.bodyText1?.color),
                        children: [
                          const TextSpan(text: "App "),
                          TextSpan(
                              text: AppLocalizations.of(context)!
                                  .intro_labelAppCustomization,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600))
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
        ShowUpTransition(
          slideSide: SlideFromSlide.BOTTOM,
          duration: const Duration(milliseconds: 600),
          forward: true,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/appTheme.png',
                  fit: BoxFit.contain,
                  height: 300.0,
                  width: 300.0,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 32),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Product Sans',
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).textTheme.bodyText1?.color),
                        children: [
                          TextSpan(
                              text: AppLocalizations.of(
                                    context,
                                  )!
                                      .intro_labelSelectPreferred +
                                  "\n"),
                          TextSpan(
                              text: AppLocalizations.of(
                                    context,
                                  )!
                                      .intro_labelTheme +
                                  "!",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600))
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(bottom: 32),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 15),
                  child: ShowUpTransition(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 600),
                    forward: true,
                    slideSide: SlideFromSlide.BOTTOM,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentTheme.switchTheme(
                            isDark: false,
                            useSystemTheme: true,
                          );
                        });
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.all(8),
                        duration: const Duration(milliseconds: 150),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: theme == ThemeSelected.System
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).cardColor.withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.08),
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0.01,
                                  blurRadius: 20.0)
                            ]),
                        child: Center(
                          child: Text(
                              AppLocalizations.of(
                                context,
                              )!
                                  .intro_labelSystem,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: theme == ThemeSelected.System
                                      ? Colors.white
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Product Sans')),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: ShowUpTransition(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 700),
                    forward: true,
                    slideSide: SlideFromSlide.BOTTOM,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentTheme.switchTheme(
                            isDark: false,
                            useSystemTheme: false,
                          );
                        });
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.all(8),
                        duration: const Duration(milliseconds: 150),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: theme == ThemeSelected.Light
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).cardColor.withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.08),
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0.01,
                                  blurRadius: 20.0)
                            ]),
                        child: Center(
                          child: Text("Light",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: theme == ThemeSelected.Light
                                      ? Colors.white
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Product Sans')),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 30),
                  child: ShowUpTransition(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 800),
                    forward: true,
                    slideSide: SlideFromSlide.BOTTOM,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentTheme.switchTheme(
                            isDark: true,
                            useSystemTheme: false,
                          );
                        });
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.all(8),
                        duration: const Duration(milliseconds: 150),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: theme == ThemeSelected.Dark
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).cardColor.withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.08),
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0.01,
                                  blurRadius: 20.0)
                            ]),
                        child: Center(
                          child: Text("Dark",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: theme == ThemeSelected.Dark
                                      ? Colors.white
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Product Sans')),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
