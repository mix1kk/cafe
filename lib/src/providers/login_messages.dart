import 'package:flutter/material.dart';

class LoginMessages with ChangeNotifier {
  LoginMessages({
    this.userHint,
    this.passwordHint = defaultPasswordHint,
    this.confirmPasswordHint = defaultConfirmPasswordHint,
    this.forgotPasswordButton = defaultForgotPasswordButton,
    this.loginButton = defaultLoginButton,
    this.signupButton = defaultSignupButton,
    this.recoverPasswordButton = defaultRecoverPasswordButton,
    this.recoverPasswordIntro = defaultRecoverPasswordIntro,
    this.recoverPasswordDescription = defaultRecoverPasswordDescription,
    this.goBackButton = defaultGoBackButton,
    this.confirmPasswordError = defaultConfirmPasswordError,
    this.recoverPasswordSuccess = defaultRecoverPasswordSuccess,
    this.flushbarTitleError = defaultflushbarTitleError,
    this.flushbarTitleSuccess = defaultflushbarTitleSuccess,
    this.signUpSuccess = defaultSignUpSuccess,
    this.providersTitleFirst = defaultProvidersTitleFirst,
    this.providersTitleSecond = defaultProvidersTitleSecond,
    this.additionalSignUpSubmitButton = defaultAdditionalSignUpSubmitButton,
    this.additionalSignUpFormDescription =
        defaultAdditionalSignUpFormDescription,
    this.confirmSignupIntro = defaultConfirmSignupIntro,
    this.confirmationCodeHint = defaultConfirmationCodeHint,
    this.confirmationCodeValidationError =
        defaultConfirmationCodeValidationError,
    this.resendCodeButton = defaultResendCodeButton,
    this.resendCodeSuccess = defaultResendCodeSuccess,
    this.confirmSignupButton = defaultConfirmSignupButton,
    this.confirmSignupSuccess = defaultConfirmSignupSuccess,
    this.confirmRecoverIntro = defaultConfirmRecoverIntro,
    this.recoveryCodeHint = defaultRecoveryCodeHint,
    this.recoveryCodeValidationError = defaultRecoveryCodeValidationError,
    this.setPasswordButton = defaultSetPasswordButton,
    this.confirmRecoverSuccess = defaultConfirmRecoverSuccess,
    this.recoverCodePasswordDescription = defaultRecoverCodePasswordDescription,
  });

  static const defaultPasswordHint = 'Пароль';
  static const defaultConfirmPasswordHint = 'Подтвердите пароль';
  static const defaultForgotPasswordButton = 'Забыли пароль?';
  static const defaultLoginButton = 'Войти';
  static const defaultSignupButton = 'Зарегистрироваться';
  static const defaultRecoverPasswordButton = 'Восстановить';
  static const defaultRecoverPasswordIntro = 'Сбросьте свой пароль здесь';
  static const defaultRecoverPasswordDescription =
      'Мы отправим вам новый пароль на email';
  static const defaultRecoverCodePasswordDescription =
      'Мы отправим код для восстановления пароля на  email.';
  static const defaultGoBackButton = 'Назад';
  static const defaultConfirmPasswordError = 'Пароль не подходит!';
  static const defaultRecoverPasswordSuccess = 'Письмо было отправлено';
  static const defaultflushbarTitleSuccess = 'Удачно';
  static const defaultflushbarTitleError = 'Ошибка';
  static const defaultSignUpSuccess = 'Ссылка для активации была отправлена';
  static const defaultProvidersTitleFirst = 'Или войти через';
  static const defaultProvidersTitleSecond = 'или';
  static const defaultAdditionalSignUpSubmitButton = 'Отправить';
  static const defaultAdditionalSignUpFormDescription =
      'Пожалуйста, заполните для завершения регистрации';

  static const defaultConfirmRecoverIntro =
      'Код для восстановления пароля отправлен на email.';
  static const defaultRecoveryCodeHint = 'Код восстановления';
  static const defaultRecoveryCodeValidationError = 'Код восстановления пуст';
  static const defaultSetPasswordButton = 'Установите пароль';
  static const defaultConfirmRecoverSuccess = 'Пароль восстановлен';
  static const defaultConfirmSignupIntro =
      'Код подтверждения отправлен на email '
      'Пожалуйста, введите код для подтверждения аккаунта';
  static const defaultConfirmationCodeHint = 'Код подтверждения';
  static const defaultConfirmationCodeValidationError =
      'Код подтверждения пустой';
  static const defaultResendCodeButton = 'Отправить код еще раз';
  static const defaultResendCodeSuccess = 'Новое письмо было отправлено';
  static const defaultConfirmSignupButton = 'Подтвердить';
  static const defaultConfirmSignupSuccess = 'Аккаунт подтвержден';

  /// Hint text of the userHint [TextField]
  /// Default will be selected based on userType
  final String? userHint;

  /// Additional signup form button's label
  final String additionalSignUpSubmitButton;

  /// Description in the additional signup form
  final String additionalSignUpFormDescription;

  /// Hint text of the password [TextField]
  final String passwordHint;

  /// Hint text of the confirm password [TextField]
  final String confirmPasswordHint;

  /// Forgot password button's label
  final String forgotPasswordButton;

  /// Login button's label
  final String loginButton;

  /// Signup button's label
  final String signupButton;

  /// Recover password button's label
  final String recoverPasswordButton;

  /// Intro in password recovery form
  final String recoverPasswordIntro;

  /// Description in password recovery form, shown when the onConfirmRecover
  /// callback is not provided
  final String recoverPasswordDescription;

  /// Go back button's label. Go back button is used to go back to to
  /// login/signup form from the recover password form
  final String goBackButton;

  /// The error message to show when the confirm password not match with the
  /// original password
  final String confirmPasswordError;

  /// The success message to show after submitting recover password
  final String recoverPasswordSuccess;

  /// Title on top of Flushbar on errors
  final String flushbarTitleError;

  /// Title on top of Flushbar on successes
  final String flushbarTitleSuccess;

  /// The success message to show after signing up
  final String signUpSuccess;

  /// The string shown above the Providers buttons
  final String providersTitleFirst;

  /// The string shown above the Providers icons
  final String providersTitleSecond;

  /// The intro text for the confirm recover password card
  final String confirmRecoverIntro;

  /// Hint text of the password recovery code [TextField]
  final String recoveryCodeHint;

  /// The validation error message  to show for an empty recovery code
  final String recoveryCodeValidationError;

  /// Set password button's label for password recovery confirmation
  final String setPasswordButton;

  /// The success message to show after confirming recovered password
  final String confirmRecoverSuccess;

  /// The intro text for the confirm signup card
  final String confirmSignupIntro;

  /// Hint text of the confirmation code for confirming signup
  final String confirmationCodeHint;

  /// The validation error message to show for an empty confirmation code
  final String confirmationCodeValidationError;

  /// Resend code button's label
  final String resendCodeButton;

  /// The success message to show after resending confirmation code
  final String resendCodeSuccess;

  /// Confirm signup button's label
  final String confirmSignupButton;

  /// The success message to show after confirming signup
  final String confirmSignupSuccess;

  /// Description in password recovery form, shown when the onConfirmRecover
  /// callback is provided
  final String recoverCodePasswordDescription;
}
