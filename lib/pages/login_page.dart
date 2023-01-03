import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scolar_chat/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:scolar_chat/pages/cubits/login_cubit/login_cubit.dart';
import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_filed.dart';
import 'chat_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  static String id = 'loginPage';
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          ChatCubit.get(context).getMessage();
          Navigator.pushNamed(context, ChatPage.id,arguments: email);
          isLoading = false;
        } else if (state is LoginFailureState) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Image.asset(kLogo),
                      const Text(
                        'Scholar Chat',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: 'Pacifico'),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: const [
                          Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          label: 'Email', onChanged: (data) => email = data),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        label: 'Password',
                        onChanged: (data) => password = data,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        title: 'LOGIN',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).loginUser(email: email!, password: password!);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Don\'t have an account ?',
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RegisterPage.id,
                                );
                              },
                              child: const Text(
                                ' Register',
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
