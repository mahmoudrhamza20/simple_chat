import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scolar_chat/models/message_model.dart';
import 'package:scolar_chat/pages/cubits/chat_cubit/chat_cubit.dart';
import '../constants.dart';
import '../widgets/custom_chat_bubble.dart';


class ChatPage extends StatelessWidget {
  static String id = 'chatPage';

  TextEditingController controller = TextEditingController();
  final ScrollController listViewController = ScrollController();
  List<MessageModel> messagesList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!
        .settings
        .arguments; // receive data from another page
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text('Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccessState) {
                  messagesList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                    reverse: true,
                    controller: listViewController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? customChatBubble(
                              message: messagesList[index],
                            )
                          : customChatBubbleForeFriend(
                              message: messagesList[index],
                            );
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                ChatCubit.get(context).sendMessage(message: data, email: email);
                controller.clear();
                listViewController.animateTo(
                  0,
                  duration: const Duration(microseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.send,
                  color: kPrimaryColor,
                ),
                hintText: 'Send Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
