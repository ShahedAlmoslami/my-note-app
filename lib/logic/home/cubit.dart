import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteappkimit/data/note_model.dart';
import 'package:noteappkimit/logic/home/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit() : super(HomeInitialStat());
  Future getNotes() async{
    emit(HomeLoadingStat());
    try{
      final respones =await FirebaseFirestore.instance.collection("notes").get();
      final finalnotes =respones.docs.map((doc)=> NoteModel.fromJson({...doc.data(),'noteId':doc.id})).toList();

      // Your logic to get notes goes here.
      emit(HomeSuccessStat(notes: finalnotes));
      await getNotes();
    }
    catch(e){
      emit(HomeErrorStat(em: e.toString()));
    }
  }

  
}