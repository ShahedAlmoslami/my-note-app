class NoteModel {
  final String headline;
  final String description;
  final DateTime creatAt;
  String ? noteId;

  NoteModel({
    required this.headline,
    required this.description,
    required this.creatAt,
     this.noteId,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      headline: json['headline'] as String,
      description: json['description'] as String,
      creatAt: DateTime.parse(json['creatAt'] as String) ,   
      noteId: json['noteId'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'headline': headline,
      'description': description,
      'creatAt': creatAt.toIso8601String(),
    };
  }
}
