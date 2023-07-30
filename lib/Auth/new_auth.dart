import 'package:cafe/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthPageNew extends StatefulWidget {
  AuthPageNew({required this.title});

  final String title;

  @override
  _AuthPageNewState createState() => _AuthPageNewState();
}

class _AuthPageNewState extends State<AuthPageNew> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  User? _firebaseUser;
  String _status = '';
  late AuthCredential _phoneAuthCredential;
  String _verificationId = '';
  int _code = 0;

  @override
  void initState() {
    super.initState();
    _getFirebaseUser();
  }

  void _handleError(e) {
    print(e.message);
    setState(() {
      _status += e.message + '\n';
    });
  }

  Future<void> _getFirebaseUser() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      _status =
          (_firebaseUser == null) ? 'Not Logged In\n' : 'Already LoggedIn\n';
    });
  }

  /// phoneAuthentication works this way:
  ///     AuthCredential is the only thing that is used to authenticate the user
  ///     OTP is only used to get AuthCrendential after which we need to authenticate with that AuthCredential
  ///
  /// 1. User gives the phoneNumber
  /// 2. Firebase sends OTP if no errors occur
  /// 3. If the phoneNumber is not in the device running the app
  ///       We have to first ask the OTP and get `AuthCredential`(`_phoneAuthCredential`)
  ///       Next we can use that `AuthCredential` to signIn
  ///    Else if user provided SIM phoneNumber is in the device running the app,
  ///       We can signIn without the OTP.
  ///       because the `verificationCompleted` callback gives the `AuthCredential`(`_phoneAuthCredential`) needed to signIn

  Future<void> _login() async {
    /// This method is used to login the user
    /// `AuthCredential`(`_phoneAuthCredential`) is needed for the signIn method
    /// After the signIn method from `AuthResult` we can get `FirebaseUser`(`_firebaseUser`)
    try {
      await FirebaseAuth.instance
          .signInWithCredential(_phoneAuthCredential)
          .then((UserCredential authRes) {
        _firebaseUser = authRes.user;
        print(_firebaseUser.toString());
      }).catchError((e) => _handleError(e));
      setState(() {
        _status += 'Signed In\n';
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _logout() async {
    /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
    try {
      // signout code
      await FirebaseAuth.instance.signOut();
      _firebaseUser = null;
      setState(() {
        _status += 'Signed out\n';
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _submitPhoneNumber() async {
    /// NOTE: Either append your phone number country code or add in the code itself
    /// Since I'm in India we use "+91 " as prefix `phoneNumber`
    String phoneNumber = _phoneNumberController.text.toString().trim();
    print(phoneNumber);

    /// The below functions are the callbacks, separated so as to make code more redable
    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      setState(() {
        _status += 'verificationCompleted\n';
      });
      _phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
    }

    void verificationFailed(FirebaseAuthException error) {
      print('verificationFailed');
      _handleError(error);
    }

    void codeSent(String verificationId, [code]) {
      print('codeSent');
      _verificationId = verificationId;
      print('verificationId = $verificationId' );
      _code = code;
      print(code.toString());
      setState(() {
        _status += 'Code Sent\n';
      });
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      setState(() {
        _status += 'codeAutoRetrievalTimeout\n';
      });
      print(verificationId);
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      /// Make sure to prefix with your country code
      phoneNumber: phoneNumber,

      /// `seconds` didn't work. The underlying implementation code only reads in `millisenconds`
      timeout: const Duration(milliseconds: 10000),

      /// If the SIM (with phoneNumber) is in the current device this function is called.
      /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
      /// When this function is called there is no need to enter the OTP, you can click on Login button to sigin directly as the device is now verified
      verificationCompleted: verificationCompleted,

      /// Called when the verification is failed
      verificationFailed: verificationFailed,

      /// This is called after the OTP is sent. Gives a `verificationId` and `code`
      codeSent: codeSent,

      /// After automatic code retrival `tmeout` this function is called
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
  }

  void _submitOTP() {
    /// get the `smsCode` from the user
    String smsCode = _otpController.text.toString().trim();

    /// when used different phoneNumber other than the current (running) device
    /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
    _phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);

    _login();
  }

  void _reset() {
    _phoneNumberController.clear();
    _phoneNumberController.text = '+7';
    _otpController.clear();
    setState(() {
      _status = "";
    });
  }

  void _displayUser() {
    setState(() {
      _status += _firebaseUser.toString() + '\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    _phoneNumberController.text = '+7';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(widget.title),
        actions: [
          GestureDetector(
            child: Icon(Icons.refresh),
            onTap: _reset,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 24),
          SizedBox(
            height: rowHeight*1.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Имя и фамилия',
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _submitPhoneNumber,
                    child: const Icon(Icons.send),
                    // color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: rowHeight*1.5,
            child: Row(
               crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Номер телефона',
                      prefixIcon: Icon(Icons.phone),
                      //hintText: 'Телефон',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _submitPhoneNumber,
                    child: const Icon(Icons.send),
                    // color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: rowHeight*1.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    controller: _otpController,
                    decoration: const InputDecoration(
                      labelText: 'Ответное СМС(6 цифр)',
                      prefixIcon: Icon(Icons.mail_outline),
                      //hintText: 'Телефон',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _submitOTP,
                    child: const Icon(Icons.send),
                    // color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 48),
          Text('$_status'),
          SizedBox(height: 48),
          ElevatedButton(
            onPressed: _login,
            child: Text('Войти'),
           // color: Theme.of(context).accentColor,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: _logout,
            child: Text('Выйти'),
           // color: Theme.of(context).accentColor,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: _displayUser,
            child: Text('FirebaseUser'),
           // color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
