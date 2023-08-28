import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static String id = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  bool isLoading= false;

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key:formKey ,
            child: ListView(

              children: [
                SizedBox(
                  height: 75.0,
                ),
                Image.asset('assets/images/scholar.png',
                  height: 100,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontSize: 32, color: Colors.white, fontFamily: 'Pacifico'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 75.0,
                ),
                Row(
                  children: [
                    Text(
                      'Sign up  ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomButton(
                  title: 'Register',
                  onTap: () async {
                 if(formKey.currentState!.validate())
                   {
                     isLoading= true;
                     setState(() {

                     });
                     try {
                       await registerUser();
                     Navigator.pushNamed(context, ChatScreen.id);
                     } on FirebaseAuthException catch (ex) {
                       if (ex.code == 'weak-password') {
                         showSnackBar(context,'The password provided is too weak.');
                       } else if (ex.code == 'email-already-in-use') {
                         showSnackBar(context, 'The account already exists for that email.');
                       }
                     } catch (ex) {
                       showSnackBar(context, 'there was an error');
                     }
                     isLoading = false;
                         setState(() {

                         });
                   }
                 else{}
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '  Login',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context,String message) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> registerUser() async {
       UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email!, password: password!);
  }
}
