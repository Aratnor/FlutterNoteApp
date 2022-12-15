class Note {
  final int id;
  final String title;
  final String desc;
  final String titleDesc;

  const Note(this.id,this.title,this.desc,this.titleDesc);

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'desc' : desc,
      'titleDesc' : titleDesc
    };
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, desc: $desc, titleDesc: $titleDesc}';
  }
}