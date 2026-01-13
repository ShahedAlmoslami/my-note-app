import 'dart:io';
import 'package:flutter/material.dart';
import 'package:noteappkimit/logic/updata/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteappkimit/data/note_model.dart';
import 'package:noteappkimit/presentation/screens/home_screen.dart';
import 'package:noteappkimit/presentation/widgets/container_widget.dart';
import 'package:noteappkimit/presentation/widgets/text_form_field_widget.dart';
import 'package:noteappkimit/core/theme/colors.dart';
import 'package:noteappkimit/logic/create_note/state.dart';
import 'package:noteappkimit/logic/updata/cubit.dart';
class UpdateScreen extends StatefulWidget {
  NoteModel noteDtat;
   UpdateScreen({super.key,required this.noteDtat});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TextEditingController controllerHeadline = TextEditingController();

    final TextEditingController controllerDescription = TextEditingController();

    XFile? selectedMedia;

    final ImagePicker picker = ImagePicker();

    Future selectedFromGallery() async{
      selectedMedia = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        
      });
    }

    Future selectedFromCamera()async{
      selectedMedia = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        
      });
Navigator.of(context).pop();    
    }
    Future<String?> upLoadMedia()async{
      
    }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => UpdateNoteCubit(),
        child: BlocConsumer<UpdateNoteCubit, UpdateNoteState>(
          listener: (context, state) { 
            if(state is UpdateNoteSuccessState){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
            }
          },
          
          
          builder: (context, state) {
            return Scaffold(
            backgroundColor: ColorManager.primaryColor,
            body: Padding(
              padding: const EdgeInsets.all( 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
          
                children: [
                  SizedBox(height: 60,),
                  Text('Update Your Note',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.white,
                    
                  ),
                 
                  
                    
                  ),
                  SizedBox(height: 40,),
                  Text('Head Line',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.white,
                    
                  ),
                    
                  ),
                  SizedBox(height: 10,),
                
                  TextFormFieldWidget(controller: controllerHeadline, hintTxt: widget.noteDtat.headline),
                  SizedBox(height: 20,),
                  Text('Description', 
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.white,
                    
                  ),
                    
                  ),
                  SizedBox(height: 20,),
                  TextFormFieldWidget(controller: controllerDescription, hintTxt: widget.noteDtat.description,heights: 60,),
                 selectedMedia != null ?Image.file(File(selectedMedia!.path),height: 300,width: 300,): Spacer(),
                  Center(
                    child: Column(
                      children: [
                        InkWell(child: ContainerWidget(buttonTxt: 'Select Media', buttonhight: 48, buttonwidth: 318),onTap: (){
                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              content: Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  color: ColorManager.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:Column(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          width: 160,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: ColorManager.primaryColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text("Gallery",style: TextStyle(color: ColorManager.white),),
                                          
                                        
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      InkWell(
                                        child: Container(
                                          width: 160,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: ColorManager.primaryColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text("Camera",style: TextStyle(color: ColorManager.white),),

                                          
                                        
                                        ),
                                        onTap: () {
                                          selectedFromCamera();
                                        },
                                      ),
                                    ],

                                  )
                                
                              
                              ),
                              

                            );
                          });
                        },),
                      
                    
                    SizedBox(height: 5),
                   
                
                    (state is UpdateNoteLoadingState)?CircularProgressIndicator():  InkWell(
                      child: ContainerWidget(buttonTxt: 'Update', buttonhight: 48, buttonwidth: 318),
                    
                      onTap:(){
                        context.read<UpdateNoteCubit>().updateNote(note:NoteModel(
                          headline: controllerHeadline.text,
                         description: controllerDescription.text, 
                         creatAt: DateTime.now(),
                        ),
                          noteId: widget.noteDtat.noteId! 
                         );
                      },
                    ),
                  
 ],
              ),
            ),
           
            
                ],
              ),
            ),
          );
          },
      
    
        ),
      ),
    );
  }}
