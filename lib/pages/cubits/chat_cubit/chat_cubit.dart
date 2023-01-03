import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../constants.dart';
import '../../../models/message_model.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

   static ChatCubit get(context) => BlocProvider.of(context);

  // Create a CollectionReference called messages that references the firestore collection
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollection);

  void sendMessage({required String message,required var email,}){
    messages.add({kMessage : message, kCreatedAt :DateTime.now(), 'id':email,});
  }

  void getMessage(){
    messages.orderBy(kCreatedAt,descending: true).snapshots().listen((event) {
      List <MessageModel> messagesList = [];
      for (var doc in event.docs) {
        print('doc--${doc}');
        messagesList.add(MessageModel.fromJson(doc));
      }
      print('sucess--------------------------------------------');
      emit(ChatSuccessState(messages: messagesList));
    });
  }
}
