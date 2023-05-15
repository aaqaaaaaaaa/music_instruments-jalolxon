import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';
import 'package:music_instruments/src/helpers/data/models.dart';
import 'package:music_instruments/src/pages/audio_payer.dart';
import 'package:music_instruments/src/widgets/background.dart';
import 'package:screensize_utils/screensize_util.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.data});

  final SubCategoryItem data;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundApp(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 293.w,
                      height: 198.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(widget.data.image),
                            fit: BoxFit.scaleDown),
                        borderRadius: BorderRadius.circular(12.r),
                        gradient: AppTheme.linearGradient,
                      ),
                    ),
                    if (widget.data.filePath != '')
                      Positioned(
                        bottom: -30.h,
                        right: 10.w,
                        child: InkWell(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AudioPlayerPage(
                                    filePath: widget.data.filePath ?? '',
                                    imageUrl: widget.data.image ?? '',
                                  ),
                                ));
                          },
                          child: Container(
                            width: 70.h,
                            height: 70.h,
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppTheme.linearGradient,
                            ),
                            child: SvgPicture.asset('assets/icons/play.svg',
                                fit: BoxFit.none),
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 36.h),
                  child: Text(
                    widget.data.desc,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        // letterSpacing: 0.8,

                        fontFamily: "Inter"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
