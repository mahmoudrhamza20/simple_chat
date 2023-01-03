part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitialState extends ChatState {}
class ChatSuccessState extends ChatState {
final  List <MessageModel> messages;
  ChatSuccessState({required this.messages});
}
