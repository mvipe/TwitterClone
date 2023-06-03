// import 'package:appwrite/models.dart';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: ((context) => const CreateTweetScreen()));
  const CreateTweetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final tweetTextControl = TextEditingController();
  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    tweetTextControl.dispose();
  }

  void onPickImages() async {
    images = await pickImages();
    setState(() {});
  }

  void shareTweet() {
    ref.read(tweetControllerProvider.notifier).shareTweet(
        images: images, text: tweetTextControl.text, context: context,repliedTo: '');

        Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final isLoading=ref.watch(tweetControllerProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          RoundedSmallButton(
            onTap: shareTweet,
            label: 'Tweet',
            textColor: Pallete.whiteColor,
            backgroundColor: Pallete.blueColor,
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.close, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading || currentUser == null
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(currentUser.profilePic),
                        radius: 30,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: tweetTextControl,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                          decoration: const InputDecoration(
                              hintText: "What's happening?",
                              hintStyle: TextStyle(
                                  color: Pallete.greyColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22),
                              border: InputBorder.none),
                          maxLines: null,
                        ),
                      )
                    ],
                  ),
                  if (images.isNotEmpty)
                    CarouselSlider(
                      items: images.map((file) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.file(file));
                      }).toList(),
                      options: CarouselOptions(
                          height: 400, enableInfiniteScroll: false),
                    ),
                ],
              ),
            )),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(
            color: Pallete.greyColor,
            width: 0.3,
          ),
        )),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(
              left: 15,
              right: 15,
            ),
            child: GestureDetector(
                onTap: onPickImages,
                child: SvgPicture.asset(AssetsConstants.galleryIcon)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(
              left: 15,
              right: 15,
            ),
            child: SvgPicture.asset(AssetsConstants.gifIcon),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(
              left: 15,
              right: 15,
            ),
            child: SvgPicture.asset(AssetsConstants.emojiIcon),
          )
        ]),
      ),
    );
  }
}
