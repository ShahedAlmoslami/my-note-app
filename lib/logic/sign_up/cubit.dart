import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteappkimit/logic/sign_up/state.dart';
class SignUpCubit extends Cubit <SignUpState>{
  SignUpCubit():super(SignUpInitialState());
  Future SignUp (String userEmail, String userPass) async{
    emit(SignUpLoadingState());
   try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userEmail,
      password:userPass
    );
   }
    catch(e){
      emit(SignUpErrorState(e.toString()));
   }
  } } 
  
  