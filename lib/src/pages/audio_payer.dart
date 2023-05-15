import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';
import 'package:music_instruments/src/pages/widgets/notifiers/play_button_notifier.dart';
import 'package:music_instruments/src/pages/widgets/page_managet.dart';
import 'package:music_instruments/src/widgets/custom_cached_image.dart';
import 'package:screensize_utils/screensize_util.dart';

import 'widgets/notifiers/progress_notifier.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage(
      {Key? key, required this.filePath, required this.imageUrl})
      : super(key: key);
  final String filePath, imageUrl;

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

late PageManager _pageManager;

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  @override
  void initState() {
    super.initState();
    _pageManager = PageManager(url: widget.filePath);
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.5, sigmaY: 12.5),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      width: 293.w,
                      height: 198.h,
                      margin: EdgeInsets.only(top: 20.h),
                      decoration: BoxDecoration(
                          gradient: AppTheme.linearGradient,
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppTheme.border),
                      child: CustomCachedImage(imageUrl: widget.imageUrl),
                    ),
                  ),
                  const AudioProgressBar(),
                  const AudioControlButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: _pageManager.onPreviousSongButtonPressed,
            child:
                SvgPicture.asset('assets/icons/rewind.svg', fit: BoxFit.none),
          ),
          const PlayButton(),
          InkWell(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: _pageManager.onNextSongButtonPressed,
            child:
                SvgPicture.asset('assets/icons/foward.svg', fit: BoxFit.none),
          ),
          // NextSongButton(),
        ],
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              width: 70.h,
              height: 70.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.linearGradient,
              ),
              child:
                  const CircularProgressIndicator(color: AppTheme.primaryColor),
            );
          case ButtonState.paused:
            return InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: _pageManager.play,
              child: Container(
                width: 70.h,
                height: 70.h,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppTheme.linearGradient,
                ),
                child:
                    SvgPicture.asset('assets/icons/play.svg', fit: BoxFit.none),
              ),
            );
          case ButtonState.playing:
            return InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: _pageManager.pause,
              child: Container(
                width: 70.h,
                height: 70.h,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppTheme.linearGradient,
                ),
                child: SvgPicture.asset('assets/icons/pause.svg',
                    fit: BoxFit.none),
              ),
            );
        }
      },
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _pageManager.progressNotifier,
      builder: (_, value, __) {
        return Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: ProgressBar(
            progress: value.current,
            buffered: value.buffered,
            total: value.total,
            timeLabelTextStyle:
                AppTheme.body18w7.copyWith(fontFamily: AppTheme.greatVibes),
            baseBarColor: AppTheme.border,
            thumbColor: AppTheme.primaryColor,
            progressBarColor: AppTheme.primaryColor,
            bufferedBarColor: AppTheme.primaryColor.withOpacity(0.3),
            onSeek: _pageManager.seek,
          ),
        );
      },
    );
  }
}
