import 'package:floating_dots/floating_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mint/pages/intro/components/introPermissions.dart';
import 'package:mint/pages/intro/components/introReady.dart';
import 'package:mint/pages/intro/components/introTheme.dart';
import 'package:mint/pages/intro/components/introWelcome.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;

  // IntroWelcome Widget
  late Widget introWelcome;

  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      IntroWelcome(
          onNext: () => setState(() {
                _selectedIndex += 1;
                _controller.index = _selectedIndex;
              })),
      const IntroPermissions(),
      const IntroTheme(),
      IntroReady(
        onEnd: () {
          Navigator.pushReplacementNamed(context, '/rootApp');
        },
      )
    ];
    // Create TabController for getting the index of current tab
    _controller = TabController(length: screens.length, vsync: this);
    _controller.animation?.addListener(() {
      int value = _controller.animation!.value.round();
      if (value != _selectedIndex) setState(() => _selectedIndex = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      Brightness _systemBrightness = Theme.of(context).brightness;
      Brightness _statusBarBrightness = _systemBrightness == Brightness.light
          ? Brightness.dark
          : Brightness.light;
      Brightness _themeBrightness = _systemBrightness == Brightness.light
          ? Brightness.dark
          : Brightness.light;
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: _statusBarBrightness,
            statusBarIconBrightness: _statusBarBrightness,
            systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
            systemNavigationBarIconBrightness: _themeBrightness),
      );
    });
    // Background color with some transparency
    final backgroundColor =
        Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7);
    // Introduction body
    Widget _body() {
      return Column(
        children: [
          // Main Body
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: screens,
            ),
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Skip Introduction
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _selectedIndex == 3
                          ? const SizedBox()
                          : TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              child: Text(
                                AppLocalizations.of(
                                  context,
                                )!
                                    .intro_labelSkip,
                                style: TextStyle(
                                  fontFamily: 'Product Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.color
                                      ?.withOpacity(0.7),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/rootApp');
                              },
                            ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: screens.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: _selectedIndex == index
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context)
                                    .iconTheme
                                    .color
                                    ?.withOpacity(0.08)),
                      ),
                    );
                  },
                ),
                // Go to next Page
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: _selectedIndex == 1 || _selectedIndex == 2
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .intro_labelNext,
                                    style: TextStyle(
                                      fontFamily: 'Product Sans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color
                                          ?.withOpacity(0.7),
                                    ),
                                  ),
                                  onPressed: _selectedIndex <
                                          _controller.length - 1
                                      ? () => setState(() {
                                            _selectedIndex += 1;
                                            _controller.index = _selectedIndex;
                                          })
                                      : null),
                            ),
                          )
                        : Container())
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      );
    }

    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: FloatingDotGroup(
            number: 10,
            direction: Direction.random,
            size: DotSize.large,
            colors: [Theme.of(context).colorScheme.secondary],
            speed: DotSpeed.fast,
            trajectory: Trajectory.random,
          ),
        ),
        Container(color: backgroundColor, child: _body())
      ],
    ));
  }
}
