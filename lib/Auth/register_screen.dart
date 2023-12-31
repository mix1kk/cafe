// ignore_for_file: unnecessary_string_interpolations

import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cafe/models/database.dart';
import 'package:cafe/Auth/login_page.dart';
import 'package:cafe/shared/loading.dart';

import '../main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  var rememberValue = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Регистрация',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: firstNameController,
                            validator: (firstname) {
                              return firstname!.isEmpty
                                  ? 'Введите имя и фамилию'
                                  : null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Имя и фамилия',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                              hintText: 'Фамилия',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: phoneNumberController,
                      validator: (phoneNumber) {
                        return phoneNumber!.isEmpty
                            ? 'Введите телефон'
                            : null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Телефон',
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Введите email",
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите пароль';
                        }
                        return null;
                      },
                      maxLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Введите пароль (6+ символов длиной)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          signUp();
                          sendToFirebase();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Уже зарегистрированы?',
                          style: TextStyle(
                              color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.toggleView();
                          },
                          child: const Text(
                            'Вход',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: Loading()));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final user = FirebaseAuth.instance.currentUser!;
      await DatabaseService(uid: user.uid).updateUserData(
        '${firstNameController.text}',
        '${lastNameController.text}',
        '${phoneNumberController.text}',
      );
    } on FirebaseAuthException {
      loading = false;
      return ('Could not register with those credentials');
    }
    //The code below calls of dialog box after user signs in
   // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void sendToFirebase() {
    FirebaseFirestore.instance.collection('users_accounts').add({
      'first_name': '${firstNameController.text}',
      'last_name': '${lastNameController.text}',
      'phone_number': '${phoneNumberController.text}',
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
    });
  }
}