import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';
import 'package:music_instruments/src/helpers/utils.dart';
import 'package:music_instruments/src/pages/catalog.dart';
import 'package:music_instruments/src/widgets/dialogs_mixin.dart';
import 'package:screensize_utils/screensize_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 40.h,
              left: 20.w,
              child: InkWell(
                onTap: () {
                  changeLangDialog(context);
                },
                child: Container(
                    width: 36.w,
                    height: 36.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.w, color: AppTheme.border),
                        color: AppTheme.background,
                        shape: BoxShape.circle),
                    child: Text(
                      'i',
                      style: AppTheme.body18w4,
                    )),
              ),
            ),
            Align(
              alignment: const Alignment(0.1, -0.4),
              child: Transform.rotate(
                angle: -0.2,
                child: Text('Laerning\n   Curve', style: AppTheme.body50w6),
              ),
            ),
            Positioned(
              bottom: 77.h,
              right: 109.w,
              child: GestureDetector(
                onTap: () => pushTo(const CatalogPage(), context),
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 31.w, vertical: 3.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 2, color: AppTheme.border),
                      color: AppTheme.background,
                    ),
                    child: Text(
                      'PLAY',
                      style: AppTheme.body48w4,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  changeLangDialog(BuildContext context) async {
    Locale myLocale = Localizations.localeOf(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool currentLangIsUzb = prefs.getString('lang') == 'uz';
    return showDialog(
        context: context,
        builder: (_) {
          return StatefulBuilder(
            builder: (context, setState) => Container(
              height: 160.h,
              child: AlertDialog(
                backgroundColor: AppTheme.dialog,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                content: SizedBox(
                  height: 140.h,
                  width: 1.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          changeLocale(context, 'uz');
                          setState(() {});
                          currentLangIsUzb = true;
                          prefs.setString('lang', 'uz');
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'O\'zbekcha',
                                style: currentLangIsUzb
                                    ? AppTheme.body16w6
                                    : AppTheme.body16w4,
                              ),
                              if (currentLangIsUzb)
                                const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          setState(() {});
                          changeLocale(context, 'ru');
                          currentLangIsUzb = false;
                          prefs.setString('lang', 'ru');
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ruscha',
                                style: !currentLangIsUzb
                                    ? AppTheme.body16w6
                                    : AppTheme.body16w4,
                              ),
                              if (!currentLangIsUzb)
                                const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      InkWell(
                        onTap: () {
                          pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: AppTheme.linearGradient,
                              borderRadius: BorderRadius.circular(12.r)),
                          padding: EdgeInsets.symmetric(
                              vertical: 7.h, horizontal: 21.w),
                          child: Text(
                            'Saqlash',
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: AppTheme.fontFamily),
                          ),
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
