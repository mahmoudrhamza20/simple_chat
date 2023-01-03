import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scolar_chat/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:scolar_chat/pages/cubits/login_cubit/login_cubit.dart';
import 'package:scolar_chat/pages/cubits/register_cubit/register_cubit.dart';
import 'package:scolar_chat/pages/login_page.dart';
import 'pages/chat_page.dart';
import 'pages/register_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SholarChat());
}

class SholarChat extends StatelessWidget {
  const SholarChat({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => RegisterCubit(),),
        BlocProvider(create: (context) => ChatCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
