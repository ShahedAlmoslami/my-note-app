import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteappkimit/data/note_model.dart';
import 'package:noteappkimit/logic/home/state.dart' as emit;
class HomeState {
  
}
class HomeInitialStat extends HomeState {}
class HomeLoadingStat extends HomeState {}
class HomeSuccessStat extends HomeState {
  List <NoteModel> notes;
  HomeSuccessStat({required this.notes });
}
class HomeErrorStat extends HomeState {
 final String em ;
  HomeErrorStat({ required this.em});

}
class DeleteLoadingStat extends HomeState {}
class DeleteSuccessStat extends HomeState {
  
}
class DeleteErrorStat extends HomeState {
 final String em ;
  DeleteErrorStat({ required this.em});

}
Future deleteNote (String noteId)async{
  try{
 await FirebaseFirestore.instance.collection('notes').doc(noteId).delete();
 emit.DeleteSuccessStat();
  }
   catch(e){
    emit.DeleteErrorStat(em: e.toString());
  }
}
