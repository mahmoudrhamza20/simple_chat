import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

   static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> loginUser({required String email, required String password,}) async {
    emit(LoginLoadingState());
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password,);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailureState(errorMessage: 'No user found for that email.'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailureState(errorMessage: 'Wrong password provided for that user.'));
      }
    }catch (e){
      emit(LoginFailureState(errorMessage: 'something went wrong'));
    }
  }
}
