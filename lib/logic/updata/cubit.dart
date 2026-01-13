import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteappkimit/data/note_model.dart';
import 'package:noteappkimit/logic/updata/state.dart';
class UpdateNoteCubit extends Cubit<UpdateNoteState> {
  UpdateNoteCubit() : super(UpdateNoteInitialState());
  Future updateNote({required NoteModel note,required String noteId})async{
    emit(UpdateNoteLoadingState());
    try{
      await FirebaseFirestore.instance.collection("note").doc(noteId).update(note.toJson());
      // Your logic to Update a note goes here.
      emit(UpdateNoteSuccessState());
    }
    catch(e){
      emit(UpdateNoteErrorState(em: e.toString()));
    }
  }


  

}