import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key}) ;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardController){

      List<DashboardBooking> bookingList = dashboardController.bookings;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault+3,
                vertical: Dimensions.paddingSizeDefault),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(Images.dashboardProfile,height: 15,width: 15,),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text(
                      "my_recent_activities".tr,
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bookingList.isEmpty?
          Container(
            padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeSmall),

            child: Center(
              child: Text(
                'your_recent_booking_will_appear_here'.tr,
                style: robotoRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,

                ),
              ),
            ),
          ) :
          Container(
            padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withValues(alpha:Get.isDarkMode?0.5:1),
              boxShadow: Get.find<ThemeController>().darkTheme ? null : shadow,
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return bookingList[index].repeatBookingList !=null && bookingList[index].repeatBookingList!.isNotEmpty ?
                ListView.builder(
                  shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                  itemCount: bookingList[index].repeatBookingList!.length,
                  itemBuilder: (context,secondIndex){
                    return RecentActivityItem(
                      activityData: bookingList[index],
                      repeatBooking : bookingList[index].repeatBookingList![secondIndex],
                    );
                  },
                ): Column(
                  children: [
                    RecentActivityItem(activityData: bookingList[index]),
                  ],
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: bookingList.length,
            ),
          ),
        ],
      );
    });
  }
}
