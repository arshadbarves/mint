import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:mint/ui/animations/showUp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroReady extends StatelessWidget {
  final Function() onEnd;
  const IntroReady({Key? key, required this.onEnd}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
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
                        child: Icon(EvaIcons.layersOutline,
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
                            TextSpan(
                                text: AppLocalizations.of(context)!
                                    .intro_labelConfigReady)
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
                    'assets/images/appReady.png',
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
                                text: AppLocalizations.of(context)!
                                        .intro_labelIntroductionIsOver +
                                    "\n" +
                                    AppLocalizations.of(context)!
                                        .intro_labelEnjoy
                                        .toLowerCase() +
                                    " "),
                            TextSpan(
                                text: "Mint!",
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
        ],
      ),
      floatingActionButton: ShowUpTransition(
        delay: const Duration(milliseconds: 600),
        duration: const Duration(milliseconds: 600),
        forward: true,
        slideSide: SlideFromSlide.BOTTOM,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: Text(
              AppLocalizations.of(context)!.intro_labelGoHome,
              style: const TextStyle(
                  color: Colors.white, fontFamily: 'YTSans', fontSize: 16),
            ),
            icon: const Icon(EvaIcons.homeOutline, color: Colors.white),
            onPressed: onEnd,
          ),
        ),
      ),
    ));
  }
}
