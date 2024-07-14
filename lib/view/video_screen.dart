import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/video_controller.dart';
import '../widgets/arrow_button.dart';
import '../widgets/download_buttom.dart';
import '../widgets/drawer_main.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final VideoController videoController = Get.put(VideoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerMain(),
      body: SafeArea(
        child: GetBuilder<VideoController>(
          builder: (controller) {
            if (videoController.customVideoPlayerController == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Stack(
                  children: [
                    CustomVideoPlayer(
                      customVideoPlayerController:
                          videoController.customVideoPlayerController!,
                    ),
                    InkWell(
                      onTap: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(height: 20, 'icons/menu.png'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    ArrowButton(
                      icon: Icons.arrow_back_ios_new,
                      onTap: () {},
                    ),
                    const Spacer(),
                    DownloadButton(
                      onTap: () {
                        // videoController.downloadVideo();
                      },
                    ),
                    const Spacer(),
                    ArrowButton(
                      icon: Icons.arrow_forward_ios,
                      onTap: () {},
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
