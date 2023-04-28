import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: ((context) => const CreateTweetScreen()));
  const CreateTweetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final tweetTextControl=TextEditingController();

  @override
  void dispose() {
    
    super.dispose();
    tweetTextControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser=ref.watch(currentUserDetailsProvider).value;
    return Scaffold(
      appBar: AppBar(actions: [
        RoundedSmallButton(onTap: (){}, label: 'Tweet',textColor: Pallete.whiteColor,backgroundColor: Pallete.blueColor,),
       
      ],
        leading: IconButton(
        icon: Icon(Icons.close,size:30),
        onPressed: () {
        Navigator.pop(context);
      },),),

      body:currentUser==null?const Loader(): SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(currentUser.profilePic),radius: 30,
                  
                ),
                const SizedBox(width: 15,),
                Expanded(
                  child: TextField(controller:tweetTextControl ,style: const TextStyle(
                    fontSize: 22,
                
                  ),
                  decoration: const InputDecoration(
                    hintText: "What's happening?"
                    ,hintStyle: TextStyle(color: Pallete.greyColor,fontWeight: FontWeight.w600,fontSize: 22),
                    border: InputBorder.none
                  ),
                  maxLines: null,
                  ),
                )
              ],
            )
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
            
          )
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(left: 15,right: 15,),
            child: SvgPicture.asset(AssetsConstants.galleryIcon),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(left: 15,right: 15,),
            child: SvgPicture.asset(AssetsConstants.gifIcon),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(left: 15,right: 15,),
            child: SvgPicture.asset(AssetsConstants.emojiIcon),
          )
        ]),
      ),
    );
  }
}