import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../flutter_login.dart';

class TextFieldUtils {
  static String getAutofillHints(LoginUserType userType) {
    switch (userType) {
      case LoginUserType.name:
        return AutofillHints.username;
      case LoginUserType.phone:
        return AutofillHints.telephoneNumber;
      case LoginUserType.email:
      default:
        return AutofillHints.email;
    }
  }

  static TextInputType getKeyboardType(LoginUserType userType) {
    switch (userType) {
      case LoginUserType.name:
        return TextInputType.name;
      case LoginUserType.phone:
        return TextInputType.number;
      case LoginUserType.email:
      default:
        return TextInputType.emailAddress;
    }
  }

  static Icon getPrefixIcon(LoginUserType userType) {
    switch (userType) {
      case LoginUserType.name:
        return const Icon(FontAwesomeIcons.circleUser);
      case LoginUserType.phone:
        return const Icon(FontAwesomeIcons.squarePhoneFlip);
      case LoginUserType.email:
      default:
        return const Icon(FontAwesomeIcons.squareEnvelope);
    }
  }

  static String getLabelText(LoginUserType userType) {
    switch (userType) {
      case LoginUserType.name:
        return "Имя";
      case LoginUserType.phone:
        return "Телефон";
      case LoginUserType.email:
      default:
        return "Email";
    }
  }
}
