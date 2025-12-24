import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteappkimit/logic/login/state.dart';

class LoginCubit extends Cubit <LoginState>{
  LoginCubit():super(LoginInitialState());
  Future logIn (String userEmail, String userPass) async{
    emit(LoginLoadingState());
    try{
     await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail, password: userPass);
     emit(LoginSuccessState());

    }
    catch(e){
      emit(LoginErrorState(em:e.toString()));
    }    
  }
 }

