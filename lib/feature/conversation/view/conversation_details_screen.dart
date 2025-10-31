import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:demandium_serviceman/feature/conversation/widgets/conversation_details_appbar.dart';
import 'package:demandium_serviceman/feature/conversation/widgets/conversation_details_shimmer.dart';
import 'package:demandium_serviceman/feature/conversation/widgets/conversation_send_message_widget.dart';
import 'package:get/get.dart';

class ConversationDetailsScreen extends StatefulWidget {
  final String channelID;
  final String name;
  final String image;
  final String phone;
  final String userType;
  final String formNotification;

  const ConversationDetailsScreen({super.key,
    required this.name,
    required this.image,
    required this.channelID,
    required this.phone,
    required this.userType,
    this.formNotification = ""
  });

  @override
  State<ConversationDetailsScreen> createState() => _ConversationDetailsScreenState();
}

class _ConversationDetailsScreenState extends State<ConversationDetailsScreen> {

  String phone ='';
  String? providerId = Get.find<UserController>().userInfo.id;

  @override
  void initState() {
    super.initState();
    Get.find<ConversationController>().setChannelId(widget.channelID);
    Get.find<ConversationController>().getConversation(widget.channelID, 1);
    Get.find<ConversationController>().resetControllerValue(shouldUpdate: false);

    if(widget.phone != ""){
      phone = "+${widget.phone}";
    }

  }

  @override
  Widget build(BuildContext context) {
    return CustomPopScopeWidget(
      child: Scaffold(

        appBar: ConversationDetailsAppBar(
          fromNotification: widget.formNotification,
          name: widget.name, phone: phone, image: widget.image,
        ),

        body: GetBuilder<ConversationController>( builder: (conversationController) {

          return !conversationController.isFirst ? Column(children: [

            conversationController.conversationList !=null && conversationController.conversationList!.isNotEmpty ?
            Expanded(child: ListView.builder(
              controller: conversationController.messageScrollController,
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              itemCount: conversationController.conversationList!.length,
              reverse: true,
              itemBuilder: (context, index) {

                bool isRightMessage = conversationController.conversationList!.elementAt(index).userId == providerId;
                return ConversationBubbleWidget(
                  conversationData:conversationController.conversationList!.elementAt(index),
                  isRightMessage: isRightMessage,
                  nextConversationData: index == (conversationController.conversationList!.length - 1)  ?
                  null : conversationController.conversationList?.elementAt(index+1),
                  previousConversationData:  index == 0  ?
                  null : conversationController.conversationList?.elementAt(index-1),
                  image: widget.image,
                  name: widget.name,
                );

              },
            )) : Expanded(child: Center(child: Text('no_conversation_found'.tr),)),


            ConversationSendMessageWidget(channelId: widget.channelID,),


          ]) : const ConversationDetailsShimmer();
        }),
      ),
    );
  }
}
