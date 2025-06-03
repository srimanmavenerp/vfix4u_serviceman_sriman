import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:get/get.dart';

class ConversationListTabview extends StatelessWidget {
  final TabController? tabController;
  const ConversationListTabview({super.key, this.tabController}) ;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConversationController>(builder: (conversationController){
      return Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: Row(
          children: [
            TabBar(
              controller: tabController,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor:  Theme.of(context).primaryColor,
              labelStyle: robotoMedium,
              indicatorWeight: 1,
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.only(
                right: conversationController.isActiveSuffixIcon && conversationController.isSearchComplete
                    && conversationController.searchedCustomerChannelList.isNotEmpty ? 10 : 25,
              ),
              indicatorPadding: const EdgeInsets.only(right: 20 ),
              tabs:  [
                SizedBox(
                  height: 35,
                  child:Center(
                    child: Row(
                      children: [
                        Text("customer".tr),
                        conversationController.isActiveSuffixIcon && conversationController.isSearchComplete  && conversationController.searchedCustomerChannelList.isNotEmpty?
                        Container(height: 15 , width: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Theme.of(context).primaryColor,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(2),
                          child: FittedBox(child: Text(
                            conversationController.searchedCustomerChannelList.length.toString(),
                            style: robotoRegular.copyWith(color: Colors.white),
                          ),
                          ),
                        ) : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                  child:  Center(
                    child: Row(
                      children: [
                        Text("provider".tr),
                        conversationController.isActiveSuffixIcon && conversationController.isSearchComplete  && conversationController.searchedProviderChannelList.isNotEmpty?
                        Container(height: 15 , width: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Theme.of(context).primaryColor,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(2),
                          child: FittedBox(child: Text(
                            conversationController.searchedProviderChannelList.length.toString(),
                            style: robotoRegular.copyWith(color: Colors.white),
                          ),
                          ),
                        ) : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
              onTap: (index){
                if( conversationController.isActiveSuffixIcon && conversationController.isSearchComplete){

                }else{
                  conversationController.getChannelList(1,type: index == 0 ? "customer": "provider");
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
