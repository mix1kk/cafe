import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';
import 'custom_route.dart';
import 'dashboard_screen.dart';
import 'flutter_login.dart';
import 'main.dart';
import 'users.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'Пользователь не существует';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Неверный пароль';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'Пользователь не существует';
      }
      return null;
    });
  }

  Future<String?> _signupConfirm(String error, LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: Constants.appName,
      logo: const AssetImage('assets/images/ecorp.png'),
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      navigateBackAfterRecovery: true,
      onConfirmRecover: _signupConfirm,
      onConfirmSignup: _signupConfirm,
      loginAfterSignUp: false,
      loginProviders: [
        // LoginProvider(
        //   button: Buttons.linkedIn,
        //   label: 'Sign in with LinkedIn',
        //   callback: () async {
        //     return null;
        //   },
        //   providerNeedsSignUpCallback: () {
        //     // put here your logic to conditionally show the additional fields
        //     return Future.value(true);
        //   },
        // ),
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            return null;
          },
        ),
        // LoginProvider(
        //   icon: FontAwesomeIcons.githubAlt,
        //   callback: () async {
        //     debugPrint('start github sign in');
        //     await Future.delayed(loginTime);
        //     debugPrint('stop github sign in');
        //     return null;
        //   },
        // ),
      ],
      termsOfService: [
        // TermOfService(
        //     id: 'newsletter',
        //     mandatory: false,
        //     text: 'Newsletter subscription'),
        TermOfService(
            id: 'general-term',
            mandatory: true,
            text: 'Условия использования',
            linkUrl: 'https://github.com/NearHuscarl/flutter_login'),
      ],
      additionalSignupFields: [
        const UserFormField(
            keyName: 'Имя и фамилия', icon: Icon(FontAwesomeIcons.userLarge)),
        // const UserFormField(keyName: 'Имя и фамилия'),
        // const UserFormField(keyName: 'Surname'),
        UserFormField(
          defaultValue: '+7',
          keyName: 'phone_number',
          displayName: 'Номер телефона',
          userType: LoginUserType.phone,
          fieldValidator: (value) {
            var phoneRegExp = RegExp(
                '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$');
            if (value != null &&
                value.length < 7 &&
                !phoneRegExp.hasMatch(value)) {
              return "Неверный формат номера телефона";
            }
            return null;
          },
        ),
      ],
      initialAuthMode: AuthMode.login,
      // scrollable: true,
      // hideProvidersTitle: false,
      // loginAfterSignUp: false,
      // hideForgotPasswordButton: true,
      // hideSignUpButton: true,
      // disableCustomPageTransformer: true,
      // messages: LoginMessages(
      //   userHint: 'User',
      //   passwordHint: 'Pass',
      //   confirmPasswordHint: 'Confirm',
      //   loginButton: 'LOG IN',
      //   signupButton: 'REGISTER',
      //   forgotPasswordButton: 'Forgot huh?',
      //   recoverPasswordButton: 'HELP ME',
      //   goBackButton: 'GO BACK',
      //   confirmPasswordError: 'Not match!',
      //   recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
      //   recoverPasswordDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
      //   recoverPasswordSuccess: 'Password rescued successfully',
      //   flushbarTitleError: 'Oh no!',
      //   flushbarTitleSuccess: 'Succes!',
      //   providersTitle: 'login with'
      // ),
      // theme: LoginTheme(
      //   primaryColor: Colors.teal,
      //   accentColor: Colors.yellow,
      //   errorColor: Colors.deepOrange,
      //   pageColorLight: Colors.indigo.shade300,
      //   pageColorDark: Colors.indigo.shade500,
      //   logoWidth: 0.80,
      //   titleStyle: TextStyle(
      //     color: Colors.greenAccent,
      //     fontFamily: 'Quicksand',
      //     letterSpacing: 4,
      //   ),
      //   // beforeHeroFontSize: 50,
      //   // afterHeroFontSize: 20,
      //   bodyStyle: TextStyle(
      //     fontStyle: FontStyle.italic,
      //     decoration: TextDecoration.underline,
      //   ),
      //   textFieldStyle: TextStyle(
      //     color: Colors.orange,
      //     shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
      //   ),
      //   buttonStyle: TextStyle(
      //     fontWeight: FontWeight.w800,
      //     color: Colors.yellow,
      //   ),
      //   cardTheme: CardTheme(
      //     color: Colors.yellow.shade100,
      //     elevation: 5,
      //     margin: EdgeInsets.only(top: 15),
      //     shape: ContinuousRectangleBorder(
      //         borderRadius: BorderRadius.circular(100.0)),
      //   ),
      //   inputTheme: InputDecorationTheme(
      //     filled: true,
      //     fillColor: Colors.purple.withOpacity(.1),
      //     contentPadding: EdgeInsets.zero,
      //     errorStyle: TextStyle(
      //       backgroundColor: Colors.orange,
      //       color: Colors.white,
      //     ),
      //     labelStyle: TextStyle(fontSize: 12),
      //     enabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
      //       borderRadius: inputBorder,
      //     ),
      //     focusedBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
      //       borderRadius: inputBorder,
      //     ),
      //     errorBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red.shade700, width: 7),
      //       borderRadius: inputBorder,
      //     ),
      //     focusedErrorBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red.shade400, width: 8),
      //       borderRadius: inputBorder,
      //     ),
      //     disabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.grey, width: 5),
      //       borderRadius: inputBorder,
      //     ),
      //   ),
      //   buttonTheme: LoginButtonTheme(
      //     splashColor: Colors.purple,
      //     backgroundColor: Colors.pinkAccent,
      //     highlightColor: Colors.lightGreen,
      //     elevation: 9.0,
      //     highlightElevation: 6.0,
      //     shape: BeveledRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //     // shape: CircleBorder(side: BorderSide(color: Colors.green)),
      //     // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
      //   ),
      // ),
      userValidator: (value) {
        if (!value!.contains('@')/* || !value.endsWith('.com')*/) {
          return "Email должен содержать '@'"/* и заканчиваться '.com'*/;
        }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Введите пароль';
        }
        return null;
      },
      onLogin: (loginData) {
        debugPrint('Login info');
        debugPrint('Имя: ${loginData.name}');
        debugPrint('Пароль: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSignup: (signupData) {
        debugPrint('Signup info');
        debugPrint('Имя: ${signupData.name}');
        debugPrint('Пароль: ${signupData.password}');

        signupData.additionalSignupData?.forEach((key, value) {
          debugPrint('$key: $value');
        });
        if (signupData.termsOfService.isNotEmpty) {
          debugPrint('Terms of service: ');
          for (var element in signupData.termsOfService) {
            debugPrint(
                ' - ${element.term.id}: ${element.accepted == true ? 'accepted' : 'rejected'}');
          }
        }
        return _signupUser(signupData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => const HomeScreen()/*DashboardScreen()*/,
        ));
      },
      onRecoverPassword: (name) {
        debugPrint('Recover password info');
        debugPrint('Имя: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      showDebugButtons: true,
    );
  }
}