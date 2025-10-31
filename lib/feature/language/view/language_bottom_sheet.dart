import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:get/get.dart';



class ChooseLanguageBottomSheet extends StatelessWidget {
  const ChooseLanguageBottomSheet({super.key,});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LocalizationController>(
      initState: (_) {
        Get.find<LocalizationController>().filterLanguage(shouldUpdate: false);
      },
      builder: (localizationController){
        return Container(
          width: Dimensions.webMaxWidth,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            color: Theme.of(context).cardColor,
          ),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  Container(
                    height: 5, width: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        color: Theme.of(context).hintColor.withValues(alpha:0.15)
                    ),
                  ),
                  const SizedBox(height:Dimensions.paddingSizeExtraLarge),
                  Text("select_language".tr,style: robotoMedium.copyWith( color: Theme.of(context).primaryColorLight, fontSize: Dimensions.fontSizeDefault)),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  Text("choose_your_language_to_proceed".tr,style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                  const SizedBox(height: Dimensions.paddingSizeDefault),

                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: Get.height * 0.5,
                      minHeight: Get.height * 0.1,
                    ),
                    child: ListView.builder(
                        itemCount: localizationController.localLanguages.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) => InkWell (
                          onTap: () {
                            localizationController.setSelectIndex(index);
                          },
                          child: Container (
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                                border: Border.all(color: localizationController.selectedIndex == index ? Theme.of(context).primaryColor.withValues(alpha:0.15) : Colors.transparent ),
                                color:  localizationController.selectedIndex == index ? Get.isDarkMode? Colors.grey.withValues(alpha:0.2) : Theme.of(context).primaryColor.withValues(alpha:0.03) : Colors.transparent
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(localizationController.localLanguages[index].imageUrl!, width: 36, height: 36),
                                ),
                                const SizedBox(width: Dimensions.paddingSizeSmall),

                                Text(localizationController.localLanguages[index].languageName!, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                              ],
                            ),

                          ),
                        )
                    ),
                  ),

                  GetBuilder<LocalizationController>(builder: (localizationController){
                    return  CustomButton(
                      btnTxt: 'select'.tr,
                      margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      onPressed: () {
                        Get.find<SplashController>().disableIntro();
                        if(localizationController.localLanguages.isNotEmpty && localizationController.selectedIndex != -1) {
                          localizationController.setLanguage(Locale(
                            localizationController.localLanguages[localizationController.selectedIndex].languageCode!,
                            localizationController.localLanguages[localizationController.selectedIndex].countryCode,
                          ));
                          Get.back();
                        }else {
                          showCustomSnackBar('select_a_language'.tr, type: ToasterMessageType.info);
                        }
                      },
                    );
                  })
                ],
              ),


              SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeSmall : 0),
            ]),
          ),
        );
      },
    );
  }
}
