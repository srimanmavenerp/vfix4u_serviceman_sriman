import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:get/get.dart';

class ConversationListScreen extends StatefulWidget {
  final String? fromNotification;
  const ConversationListScreen({super.key, this.fromNotification}) ;

  @override
  State<ConversationListScreen> createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();

    Get.find<ConversationController>().clearSearchController(shouldUpdate: false);
    _loadData();
  }

  _loadData() async {
    await Get.find<ConversationController>().getChannelList(1, type: "provider");
    Get.find<ConversationController>().getChannelList(1, type: "customer");
  }


  @override
  Widget build(BuildContext context) {
    return CustomPopScopeWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(title: 'inbox'.tr,
          onBackPressed: (){
            if(widget.fromNotification == "fromNotification"){
              Get.offNamed(RouteHelper.getInitialRoute());
            }else{
              if(Get.find<ConversationController>().isActiveSuffixIcon && Get.find<ConversationController>().isSearchComplete){
                Get.find<ConversationController>().clearSearchController();
              }else{
                Get.back();
              }
            }
          },
        ),
        body: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).cardColor,
          onRefresh: () async=> Get.find<ConversationController>().getChannelList(1, reload: true),

          child: GetBuilder<ConversationController>(
            builder: (conversationController){


              if(conversationController.customerChannelList != null) {
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  const ConversationSearchWidget(),
                  const SizedBox(height: Dimensions.paddingSizeSmall,),

                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start , children: [

                      conversationController.adminConversationModel != null?
                      ChannelItem(
                        channelData: conversationController.adminConversationModel!,
                        isAdmin: true,
                      ): const SizedBox(),

                      const SizedBox(height: Dimensions.paddingSizeSmall,),
                      ConversationListTabview( tabController: conversationController.tabController,),
                      const SizedBox(height: Dimensions.paddingSizeSmall,),

                      Expanded(
                        child: TabBarView( controller: conversationController.tabController, children: [

                          conversationController.searchedChannelList == null && !conversationController.isSearchComplete ?
                          const ConversationSearchShimmer() :
                          ConversationListView(
                            channelList: conversationController.isSearchComplete ?
                            conversationController.searchedCustomerChannelList : conversationController.customerChannelList!,
                            tabIndex: 0,
                          ),

                          conversationController.searchedChannelList == null && !conversationController.isSearchComplete ?
                          const ConversationSearchShimmer() :
                          ConversationListView(
                            channelList : conversationController.isSearchComplete ?
                            conversationController.searchedProviderChannelList : conversationController.providerChannelList??[],
                            tabIndex: 1,
                          ),


                        ]),
                      ),
                    ],),
                  ),

                ],);
              }else{
                return const ConversationListShimmer();
              }
            },
          ),
        ),
      ),
    );
  }
}


