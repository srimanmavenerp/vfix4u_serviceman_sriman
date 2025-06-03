import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:get/get.dart';

class ConversationSendMessageWidget extends StatelessWidget {
  final String channelId;
  const ConversationSendMessageWidget({super.key, required this.channelId}) ;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConversationController>(builder: (conversationController){
      return Container(
        color: conversationController.isLoading == false && ( conversationController.pickedImageFile!=null && conversationController.pickedImageFile!.isNotEmpty
            || (conversationController.objFile!=null && conversationController.objFile!.isNotEmpty)) ?
        Theme.of(context).primaryColor.withValues(alpha:0.1) : null,
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
        margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),

        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          conversationController.pickedImageFile != null && conversationController.pickedImageFile!.isNotEmpty && conversationController.isLoading == false ?

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70, child: ListView.builder(
                clipBehavior: Clip.none,
                shrinkWrap: true, scrollDirection: Axis.horizontal,
                itemCount: conversationController.pickedImageFile!.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                    child: Stack( clipBehavior: Clip.none, children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                        child: SizedBox(height: 65, width: 65,
                          child: Image.file(
                            File(conversationController.pickedImageFile![index].path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Positioned(top: -5, right: -5,
                        child: InkWell(
                          child: Image(image: AssetImage(Images.cancelIcon),
                            height: Dimensions.paddingSizeLarge,
                            width: Dimensions.paddingSizeLarge,
                          ),
                          onTap: () => conversationController.pickMultipleImage(true,index: index),
                        ),
                      ),

                    ]),
                  );
                },
              )),

              if(conversationController.pickedFIleCrossMaxLimit || conversationController.pickedFIleCrossMaxLength || conversationController.singleFIleCrossMaxLimit)
                Text( "${conversationController.pickedFIleCrossMaxLength ? "• ${"can_not_select_more_than".tr} ${AppConstants.maxLimitOfTotalFileSent.floor()} ${'files'.tr}" :""} "
                    "${conversationController.pickedFIleCrossMaxLimit ? "• ${'total_images_size_can_not_be_more_than'.tr} ${AppConstants.maxLimitOfFileSentINConversation.floor()} MB" : ""} "
                    "${conversationController.singleFIleCrossMaxLimit ? "• ${'single_file_size_can_not_be_more_than'.tr} ${AppConstants.maxSizeOfASingleFile.floor()} MB" : ""} ",
                  style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.error.withValues(alpha:0.7),
                  ),
                ),
            ],
          ) : conversationController.objFile != null && conversationController.objFile!.isNotEmpty && conversationController.isLoading == false ?

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70,
                child: ListView.separated(
                  shrinkWrap: true, scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(bottom: 5),
                  separatorBuilder: (context, index) => const SizedBox(width: Dimensions.paddingSizeDefault),
                  itemCount: conversationController.objFile!.length,
                  itemBuilder: (context, index){
                    String fileSize =  ImageSize.getFileSizeFromPlatformFileToString(conversationController.objFile![index]);
                    return Container(width: 180,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center,children: [

                        Image.asset(Images.file,height: 30, width: 30,),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center, children: [

                          Text(conversationController.objFile![index].name,
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                          ),

                          Text(fileSize, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).hintColor,
                          )),
                        ])),


                        InkWell(
                          onTap: () {
                            conversationController.pickOtherFile(true, index: index);
                          },
                          child: Padding(padding: const EdgeInsets.only(top: 5),
                            child: Align(alignment: Alignment.topRight,
                              child: Icon(Icons.close,
                                size: Dimensions.paddingSizeLarge,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                        )

                      ]),
                    );
                  },
                ),
              ),

              if(conversationController.pickedFIleCrossMaxLimit || conversationController.pickedFIleCrossMaxLength || conversationController.singleFIleCrossMaxLimit)
                Text( "${conversationController.pickedFIleCrossMaxLength ? "• ${"can_not_select_more_than".tr} ${AppConstants.maxLimitOfTotalFileSent.floor()} ${'files'.tr}" :""} "
                    "${conversationController.pickedFIleCrossMaxLimit ? "• ${'total_images_size_can_not_be_more_than'.tr} ${AppConstants.maxLimitOfFileSentINConversation.floor()} MB" : ""} "
                    "${conversationController.singleFIleCrossMaxLimit ? "• ${'single_file_size_can_not_be_more_than'.tr} ${AppConstants.maxSizeOfASingleFile.floor()} MB" : ""} ",
                  style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.error.withValues(alpha:0.7),
                  ),
                ),
            ],
          ) : const SizedBox(),


          conversationController.isLoading ? conversationController.pickedImageFile != null && conversationController.pickedImageFile!.isNotEmpty ?

          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
            child: Align(alignment: Alignment.bottomRight,
              child: Text("${'uploading'.tr} ${conversationController.pickedImageFile!.length} ${conversationController.pickedImageFile!.length >1 ? "files".tr : "file"}",
                style: robotoLight.copyWith(color: Theme.of(context).hintColor),
              ),
            ),
          ): conversationController.objFile != null && conversationController.objFile!.isNotEmpty ?

          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
            child: Align(alignment: Alignment.bottomRight,
              child: Text("${'uploading'.tr} ${conversationController.objFile!.length} ${conversationController.objFile!.length >1 ? "files".tr : "file"}",
                style: robotoLight.copyWith(color: Theme.of(context).hintColor),
              ),
            ),
          ): const SizedBox() : const SizedBox(),


          const SizedBox(height: Dimensions.paddingSizeExtraSmall),

          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [

            Expanded(flex: 6, child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                color: conversationController.isLoading ? Theme.of(context).hintColor.withValues(alpha:0.1):
                Theme.of(context).cardColor,
                border: Border.all(
                  color: conversationController.isLoading ? Colors.transparent:
                  Theme.of(context).primaryColor.withValues(alpha:0.4),
                ),
              ),
              padding:  const EdgeInsets.symmetric( horizontal: Dimensions.paddingSizeSmall,),

              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [

                Expanded(child: TextField(
                  enabled: conversationController.isLoading ? false : true,
                  controller: conversationController.conversationController,
                  textCapitalization: TextCapitalization.sentences,
                  style: robotoMedium.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color:Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha:0.8),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3, minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "type_a_message".tr,
                    hintStyle: robotoRegular.copyWith(
                      color: Theme.of(context).hintColor.withValues(alpha:0.4),
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.only(left: 5),
                  ),
                )),
                const SizedBox(width: Dimensions.paddingSizeDefault),

                Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault,),
                  child: Row(children: [


                    InkWell(onTap: conversationController.isLoading ? null : () async {
                      await conversationController.pickMultipleImage(false);

                    },
                      child: Image.asset(Images.image,height: 18, width: 18),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall,),

                    InkWell(onTap: conversationController.isLoading ? null : () async {
                      await conversationController.pickOtherFile(false);


                    },
                      child: Image.asset(
                          Images.file,height: 18, width: 18,
                        //color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall,),

                  ]),
                )],


              ),
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),

            Expanded(child: InkWell(
              onTap: (){
                if(conversationController.conversationController.text.isEmpty
                    && conversationController.pickedImageFile!.isEmpty
                    && conversationController.objFile==null){
                  showCustomSnackBar("write_something".tr, type: ToasterMessageType.info);
                }else{
                  conversationController.sendMessage(channelId);
                  conversationController.conversationController.clear();
                }
              },
              child: Container(
                height: Dimensions.paddingSizeExtraLarge * 2,
                width: Dimensions.paddingSizeExtraLarge * 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  color: Theme.of(context).cardColor,
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withValues(alpha:0.4),
                  ),
                ),
                child:  Center(child: conversationController.isLoading ? SizedBox(
                  height: Dimensions.paddingSizeExtraLarge,
                  width: Dimensions.paddingSizeExtraLarge,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor.withValues(alpha:0.5),
                    backgroundColor: Theme.of(context).primaryColor.withValues(alpha:0.1),
                  ),
                ): Image(image: AssetImage(Images.sendIcon),
                  height: Dimensions.paddingSizeLarge + Dimensions.paddingSizeSmall,
                  width: Dimensions.paddingSizeLarge + Dimensions.paddingSizeSmall,
                ),
                ),
              ),
            ),),
          ],),
        ]),
      );
    });
  }
}
