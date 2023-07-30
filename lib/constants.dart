import 'dart:ffi';

import 'package:flutter/material.dart';

const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF000000);
const kTextColor = Color(0xFF1D150B);
const kPrimaryColor = Color(0xFFFB475F);
const kSecondaryColor = Color(0xFFF5E1CB);
const kBorderColor = Color(0xFFDDDDDD);
const rowHeight = 40.0;
ButtonStyle categoryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(const EdgeInsets.all(10)));

class Constants {
  static const String appName = '';
  static const String logoTag = 'near.huscarl.loginsample.logo';
  static const String titleTag = 'near.huscarl.loginsample.title';
}