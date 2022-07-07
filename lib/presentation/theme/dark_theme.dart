import 'package:flutter/material.dart';
import 'package:gift_manager/resources/app_colors.dart';

final _base = ThemeData.dark();

final darkTheme = _base.copyWith(
  backgroundColor: AppColors.darkBlack100,
  textTheme: _base.textTheme.copyWith(
    headline1: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColors.darkWhite100,
    ),
    headline2: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.darkWhite100,
    ),
    headline3: const TextStyle(
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.w500,
      color: AppColors.darkWhite100,
    ),
    headline4: const TextStyle(
      fontSize: 14,
      height: 1.15,
      fontWeight: FontWeight.w500,
      color: AppColors.darkWhite100,
    ),
    headline5: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.darkWhite100,
    ),
    headline6: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.darkWhite100,
    ),
    button: const TextStyle(
      fontSize: 14,
      height: 1.15,
      fontWeight: FontWeight.w700,
      color: AppColors.darkWhite100,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
      elevation: MaterialStateProperty.all(0),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: MaterialStateProperty.resolveWith(
        (states) {
          return states.contains(MaterialState.disabled)
              ? const TextStyle(
                  color: AppColors.darkWhite60,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                )
              : const TextStyle(
                  color: AppColors.darkWhite100,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                );
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.darkDarkBlue70;
        }
        return AppColors.darkDarkBlue100;
      }),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
      ),
      shape: MaterialStateProperty.resolveWith((state) {
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        );
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        return states.contains(MaterialState.disabled)
            ? AppColors.darkDarkBlue100.withOpacity(0.5)
            : AppColors.darkDarkBlue100;
      }),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => Colors.transparent,
      ),
      overlayColor: MaterialStateProperty.all(
        AppColors.lightLightBlue100,
      ),
    ),
  ),

);
