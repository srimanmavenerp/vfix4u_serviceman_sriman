import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:get/get.dart';

class BottomNavScreen extends StatefulWidget {
  final int pageIndex;
  const BottomNavScreen({super.key, required this.pageIndex});

  @override
  BottomNavScreenState createState() => BottomNavScreenState();
}

class BottomNavScreenState extends State<BottomNavScreen> {

  void _loadData() {
    Get.find<DashboardController>().getDashboardData();
    Get.find<DashboardController>().getMonthlyBookingsDataForChart(DateConverter.stringYear(DateTime.now()),DateTime.now().month.toString());
    Get.find<DashboardController>().getYearlyBookingsDataForChart(DateConverter.stringYear(DateTime.now()));
    Get.find<BookingRequestController>().updateBookingStatusState(BooingListStatus.accepted);
    Get.find<BookingRequestController>().getBookingHistory('all',1);
    Get.find<BookingRequestController>().updateBookingHistorySelectedIndex(0);
    Get.find<LocalizationController>().filterLanguage(shouldUpdate: false);
    Get.find<ConversationController>().getChannelList(1, type: "customer");
    Get.find<ConversationController>().getChannelList(1, type: "provider");
    Get.find<AuthController>().updateToken();
  }


  PageController? _pageController;
  int _pageIndex = 0;
  List<Widget>? _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), (){
      _loadData();
    });

    _pageIndex = widget.pageIndex;
    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      const DashBoardScreen(),
      const BookingListScreen(),
      const BookingHistoryScreen(),
      const Text("More"),
    ];

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });


  }

  @override
  Widget build(BuildContext context) {
    return CustomPopScopeWidget(
      onPopInvoked: (){
        if (_pageIndex != 0) {
          _setPage(0);
        } else {
          if(_canExit) {
            exit(0);
          }else {
            showCustomSnackBar('back_press_again_to_exit'.tr, type : ToasterMessageType.info);
            _canExit = true;
            Timer(const Duration(seconds: 2), () {
              _canExit = false;
            });
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: ResponsiveHelper.isDesktop(context) ? const SizedBox() : SafeArea(
          child: Container(
            height: 30 + MediaQuery.of(context).padding.top, alignment: Alignment.center,
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(
                color: Get.isDarkMode?Theme.of(context).colorScheme.surface:Theme.of(context).primaryColor,
                boxShadow:[
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 10,
                    color: Theme.of(context).primaryColor.withValues(alpha:0.5),
                  )]
            ),
            child: Row(children: [
              _getBottomNavItem(0, Images.dashboard, 'dashboard'.tr),
              _getBottomNavItem(1, Images.requests, 'requests'.tr),
              _getBottomNavItem(2, Images.history, 'history'.tr),
              _getBottomNavItem(3, Images.moree, 'more'.tr),
            ]),
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens![index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    if(pageIndex == 3) {
      Get.bottomSheet(const MenuScreen(), backgroundColor: Colors.transparent, isScrollControlled: true);
    }else {
      setState(() {
        _pageController!.jumpToPage(pageIndex);
        _pageIndex = pageIndex;
      });
    }
  }

  Widget _getBottomNavItem(int index, String icon, String title) {
    return Expanded(child: InkWell(
      onTap: () => _setPage(index),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

        icon.isEmpty ? const SizedBox(width: 20, height: 20) : Image.asset(
          icon, width: 18, height: 18,
            color: _pageIndex == index ? Get.isDarkMode ? Theme.of(context).primaryColor : Colors.white : Colors.grey.shade400
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        Text(title, style: robotoRegular.copyWith(
          fontSize: Dimensions.fontSizeSmall,
            color: _pageIndex == index ? Get.isDarkMode ? Theme.of(context).primaryColor : Colors.white : Colors.grey.shade400
        )),

      ]),
    ));
  }

}
