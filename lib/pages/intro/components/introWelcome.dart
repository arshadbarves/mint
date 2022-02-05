import 'package:avatar_glow/avatar_glow.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mint/ui/animations/showUp.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroWelcome extends StatelessWidget {
  final Function() onNext;
  const IntroWelcome({Key? key, required this.onNext}) : super(key: key);

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
              slideSide: SlideFromSlide.BOTTOM,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AvatarGlow(
                      repeat: true,
                      endRadius: 120,
                      showTwoGlows: false,
                      glowColor: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1),
                      repeatPauseDuration: const Duration(milliseconds: 400),
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.1)),
                        child: Center(
                          child: SizedBox(
                              height: 140,
                              width: 140,
                              child: Image.asset(DateTime.now().month == 12
                                  ? 'assets/images/logo_christmas.png'
                                  : 'assets/images/logo.png')),
                        ),
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'YTSans',
                              fontWeight: FontWeight.w400,
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color),
                          children: [
                            TextSpan(
                                text: AppLocalizations.of(
                                      context,
                                    )!
                                        .intro_labelAppWelcome
                                        .toLowerCase() +
                                    "\n",
                                style: const TextStyle(
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: "mint",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.0,
                                    fontSize: 32,
                                    fontFamily: 'Product Sans'))
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            ShowUpTransition(
              forward: true,
              slideSide: SlideFromSlide.TOP,
              duration: const Duration(milliseconds: 600),
              child: GestureDetector(
                onTap: () {
                  launch('https://github.com/TeamNewPipe/NewPipeExtractor');
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 15,
                              width: 15,
                              color: Colors.white,
                            ),
                            const Icon(BootstrapIcons.youtube,
                                size: 40, color: Colors.red),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'YTSans',
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color),
                            children: [
                              const TextSpan(
                                  text: "Powered by\n",
                                  style: TextStyle(
                                      fontFamily: 'Product Sans',
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: "Mint",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontFamily: 'Product Sans',
                                      fontWeight: FontWeight.w600))
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ShowUpTransition(
            //   forward: true,
            //   slideSide: SlideFromSlide.TOP,
            //   duration: const Duration(milliseconds: 600),
            //   child: Align(
            //       alignment: Alignment.topRight,
            //       child: _createLanguageDropDown(context)),
            // )
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
                AppLocalizations.of(
                  context,
                )!
                    .intro_labelStart,
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'YTSans', fontSize: 16),
              ),
              icon:
                  const Icon(BootstrapIcons.chevron_right, color: Colors.white),
              onPressed: onNext,
            ),
          ),
        ),
      ),
    );
  }

  // _createLanguageDropDown(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(16),
  //     child: DropdownButton<LanguageData>(
  //       alignment: Alignment.centerRight,
  //       iconSize: 26,
  //       hint: Padding(
  //         padding: const EdgeInsets.only(right: 8.0),
  //         child: Text(
  //           Localizations.localeOf(context).languageCode.toUpperCase(),
  //           style: TextStyle(
  //               fontSize: 14,
  //               fontFamily: 'Product Sans',
  //               fontWeight: FontWeight.w800,
  //               color: Theme.of(context).textTheme.bodyText1.color),
  //         ),
  //       ),
  //       icon: const SizedBox(),
  //       onChanged: (LanguageData language) {
  //         changeLanguage(context, language.languageCode);
  //       },
  //       underline: DropdownButtonHideUnderline(child: Container()),
  //       items: supportedLanguages
  //           .map<DropdownMenuItem<LanguageData>>(
  //             (e) => DropdownMenuItem<LanguageData>(
  //               value: e,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: <Widget>[
  //                   Text(
  //                     e.name,
  //                     style: TextStyle(
  //                         fontSize: 16,
  //                         fontFamily: 'YTSans',
  //                         fontWeight: FontWeight.w400,
  //                         color: Theme.of(context).textTheme.bodyText1?.color),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           )
  //           .toList(),
  //     ),
  //   );
  // }
}
