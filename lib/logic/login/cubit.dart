import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteappkimit/logic/login/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginCubit extends Cubit <LoginState>{
  LoginCubit():super(LoginInitialState());
  Future logIn (String userEmail, String userPass) async{
    emit(LoginLoadingState());
    try{
     await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail, password: userPass);
     emit(LoginSuccessState());
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setBool('isLoggedIn', true);

    }
    catch(e){
      emit(LoginErrorState(em:e.toString()));
    }    
  }
 }

