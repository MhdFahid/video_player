import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String longVideo =
    "https://drive.google.com/uc?export=download&id=1L0FroVPktUt3uUOU0YwiWw7dXWQaQG7g";

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late VideoPlayerController videoPlayerController2;
  late VideoPlayerController videoPlayerController3;

  CustomVideoPlayerController? customVideoPlayerController;
  CustomVideoPlayerWebController? customVideoPlayerWebController;

  final CustomVideoPlayerSettings customVideoPlayerSettings =
      const CustomVideoPlayerSettings(
          showSeekButtons: true,
          settingsButton: Row(
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              )
            ],
          ));

  @override
  void onInit() {
    super.onInit();

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(longVideo))
          ..initialize().then((_) {
            customVideoPlayerController = CustomVideoPlayerController(
              context: Get.context!,
              videoPlayerController: videoPlayerController,
              customVideoPlayerSettings: customVideoPlayerSettings,
              additionalVideoSources: {
                "720p": videoPlayerController,
              },
            );
            update();
          });
  }

  @override
  void dispose() {
    customVideoPlayerController?.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }
}
