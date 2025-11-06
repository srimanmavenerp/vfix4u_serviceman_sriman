

import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:get/get.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;

  const LanguageWidget({
    super.key,
    required this.languageModel,
    required this.localizationController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = localizationController.selectedIndex == index;

    return GestureDetector(
      onTap: () {
        localizationController.setSelectIndex(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeLarge,
            horizontal: Dimensions.paddingSizeExtraLarge),
        margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Get.isDarkMode
              ? Colors.grey.withOpacity(0.2)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          boxShadow: Get.find<ThemeController>().darkTheme ? null : shadow,
          border: isSelected
              ? Border.all(color: Theme.of(context).primaryColor, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            languageModel.languageName!,
            textAlign: TextAlign.center,
            style: robotoMedium.copyWith(
              fontSize: 16,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
      ),
    );
  }
}
