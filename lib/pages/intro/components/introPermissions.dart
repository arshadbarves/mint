import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mint/ui/animations/showUp.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroPermissions extends StatefulWidget {
  const IntroPermissions({Key? key}) : super(key: key);

  @override
  _IntroPermissionsState createState() => _IntroPermissionsState();
}

class _IntroPermissionsState extends State<IntroPermissions> {
  // Permission Granted
  late bool accessGranted;

  @override
  void initState() {
    super.initState();
    accessGranted = false;
    Permission.storage.status.then((status) {
      if (status != PermissionStatus.granted) {
        setState(() => accessGranted = false);
      } else {
        setState(() => accessGranted = true);
      }
    });
  }

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
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: accessGranted
                            ? const Icon(EvaIcons.unlock,
                                size: 40, color: Colors.red)
                            : const Icon(EvaIcons.lock,
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
                                        .intro_labelGrant +
                                    " "),
                            TextSpan(
                                text: AppLocalizations.of(
                                  context,
                                )!
                                    .intro_labelAccess,
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
                    'assets/images/grantAccess.png',
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
                              fontFamily: 'YTSans',
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color),
                          children: [
                            TextSpan(
                                text: "SongTube ",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.w700)),
                            TextSpan(
                                text: AppLocalizations.of(context)!
                                    .intro_labelExternalAccessJustification
                                    .toLowerCase(),
                                style: TextStyle(
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.8)))
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ShowUpTransition(
            forward: true,
            delay: const Duration(milliseconds: 600),
            duration: const Duration(milliseconds: 600),
            slideSide: SlideFromSlide.BOTTOM,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  if (accessGranted == false) {
                    Permission.storage.request().then((status) {
                      if (status == PermissionStatus.granted) {
                        setState(() => accessGranted = true);
                      }
                    });
                  }
                },
                child: AnimatedContainer(
                  margin: const EdgeInsets.only(bottom: 32),
                  duration: const Duration(milliseconds: 500),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).colorScheme.secondary),
                  child: accessGranted
                      ? Container(
                          margin: const EdgeInsets.only(left: 14, right: 14),
                          child: const Icon(
                            EvaIcons.checkmark,
                            color: Colors.white,
                          ))
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 18, right: 8),
                              child: const Text("Allow Access",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: const Icon(
                                  EvaIcons.lock,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
