import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_filed.dart';

import 'chat_page.dart';
import 'cubits/register_cubit/register_cubit.dart';

class RegisterPage extends StatelessWidget {
  static String id = 'registerPage';

  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          Navigator.pushNamed(context, ChatPage.id,arguments: email);
          isLoading = false;
        } else if (state is RegisterFailureState) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                        Image.asset('assets/images/scholar.png'),
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
                              'REGISTER',
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
                        //register with firebase and validate
                        CustomButton(
                          title: 'REGISTER',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).registerUser(
                                  email: email!, password: password!);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Already have an account ?',
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(
                                    context,
                                  );
                                },
                                child: const Text(
                                  ' Login',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
