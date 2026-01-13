import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:noteappkimit/data/note_model.dart';

import 'package:noteappkimit/logic/home/state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialStat());

  Future<void> getNotes() async {
    emit(HomeLoadingStat());

    try {
      final response = await FirebaseFirestore.instance
          .collection("note")
          .get();

      final notes = response.docs.map((doc) {
        final data = doc.data();

        return NoteModel.fromJson({...data, 'noteId': doc.id});
      }).toList();

      emit(HomeSuccessStat(notes: notes));
    } catch (e) {
      emit(HomeErrorStat(em: e.toString()));
    }
  }
  Future deleteNote (String noteId)async{
  try{
 await FirebaseFirestore.instance.collection('note').doc(noteId).delete();
 emit(DeleteSuccessStat());
 await getNotes();
  }
   catch(e){
    emit(DeleteErrorStat(em: e.toString()));
  }
}}