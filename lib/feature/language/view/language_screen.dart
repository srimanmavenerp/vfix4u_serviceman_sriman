import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:get/get.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    Images.newlogo,
                    width: Dimensions.logoWidth,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge * 2),

                  // "Select Language" Title
                  Text(
                    "select_language".tr,
                    textAlign: TextAlign.center,
                    style: robotoMedium.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                  // Language Options
                  GetBuilder<LocalizationController>(
                    initState: (_) => Get.find<LocalizationController>()
                        .filterLanguage(
                            shouldUpdate: false, isChooseLanguage: true),
                    builder: (localizationController) {
                      return Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth:
                                ResponsiveHelper.isDesktop(context) ? 600 : 400,
                          ),
                          child: ListView.builder(
                            itemCount: 1,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.paddingSizeSmall,
                                ),
                                child: Center(
                                  child: LanguageWidget(
                                    languageModel: localizationController
                                        .localLanguages[index],
                                    localizationController:
                                        localizationController,
                                    index: index,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: Dimensions.paddingSizeLarge),

                  // Language Hint
                  Text(
                    "language_hint_text".tr,
                    textAlign: TextAlign.center,
                    style: robotoRegular.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withValues(alpha: 0.5),
                      fontSize: Dimensions.fontSizeSmall,
                    ),
                  ),

                  const SizedBox(height: Dimensions.paddingSizeLarge),

                  // Save Button
                  GetBuilder<LocalizationController>(
                    builder: (localizationController) {
                      return CustomButton(
                        btnTxt: 'save'.tr,
                        margin: EdgeInsets.zero,
                        onPressed: () {
                          Get.find<SplashController>().disableIntro();
                          if (localizationController
                                  .localLanguages.isNotEmpty &&
                              localizationController.selectedIndex != -1) {
                            localizationController.setLanguage(
                              Locale(
                                localizationController
                                    .localLanguages[
                                        localizationController.selectedIndex]
                                    .languageCode!,
                                localizationController
                                    .localLanguages[
                                        localizationController.selectedIndex]
                                    .countryCode,
                              ),
                              isInitial: true,
                            );
                            Get.offNamed(RouteHelper.signIn);
                          } else {
                            showCustomSnackBar(
                              'select_a_language'.tr,
                              type: ToasterMessageType.info,
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
