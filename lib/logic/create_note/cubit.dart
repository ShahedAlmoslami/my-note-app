import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteappkimit/data/note_model.dart';
import 'package:noteappkimit/logic/create_note/state.dart';
class CreateNoteCubit extends Cubit<CreateNoteState> {
  CreateNoteCubit() : super(CreateNoteInitialState());
  Future createNote(NoteModel note)async{
    emit(CreateNoteLoadingState());
    try{
      await FirebaseFirestore.instance.collection("note").add(note.toJson());
      // Your logic to create a note goes here.
      emit(CreateNoteSuccessState());
    }
    catch(e){
      emit(CreateNoteErrorState(em: e.toString()));
    }
  }


  

}