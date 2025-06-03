import 'dart:convert';

import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:http/http.dart' as http;

class BusinessSummerySection extends StatelessWidget {
  const BusinessSummerySection({super.key});

  @override
 Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return GetBuilder<UserController>(builder: (userController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeDefault,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns content on both sides
                  children: [
                    // Booking Summary Text
                    Text(
                      "bookings_summary".tr,
                      style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                    // Status Title and Toggle (ON/OFF)
                    Row(
                      children: [
                        // Status Text
                        Text(
                          "status".tr, // Change this to your desired label, for example: "Status"
                          style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                        const SizedBox(width: 10), // Add some space between the text and the switch
                        // Toggle Switch for "ON/OFF"
                        Switch(
                          value: userController.userInfo.isOnline == 0,
                          onChanged: (bool value) {
                            // Safely update the local status (handling nullable)
                            int status = value ? 0 : 1;

                            // Call the method to update status in the backend
                            userController.updateStatusval(status);
                          },
                          activeColor: Theme.of(context).primaryColor,
                          inactiveThumbColor: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Your container (Booking summary)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeSmall,
                ),
                width: MediaQuery.of(context).size.width,
                height: 260,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode ? 0.5 : 1),
                  boxShadow: Get.find<ThemeController>().darkTheme ? null : shadow,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        BusinessSummaryItem(
                          height: 80,
                          curveColor: const Color(0xff7180ff),
                          cardColor: const Color(0xff6a79ff),
                          amount: controller.cards.pendingBookings ?? 0,
                          title: "total_assigned_booking".tr,
                          iconData: Images.earning,
                        ),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        BusinessSummaryItem(
                          height: 80,
                          cardColor: const Color(0xff3376E0),
                          curveColor: const Color(0xff367ae3),
                          amount: controller.cards.ongoingBookings ?? 0,
                          title: "ongoing_booking".tr,
                          iconData: Images.service,
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    BusinessSummaryItem(
                      cardColor: Theme.of(context).colorScheme.surfaceTint,
                      amount: controller.cards.completedBookings ?? 0,
                      title: "total_completed_booking".tr,
                      iconData: Images.serviceMan,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    BusinessSummaryItem(
                      cardColor: Theme.of(context).colorScheme.tertiary,
                      amount: controller.cards.canceledBookings ?? 0,
                      title: "total_canceled_booking".tr,
                      iconData: Images.booking,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
 
