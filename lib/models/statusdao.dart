class StatusDAO {
  int? id;
  String? status;

  StatusDAO({this.id, this.status});

  factory StatusDAO.fromMap(Map<String, dynamic> obj){
    return StatusDAO(
      id: obj['id'],
      status: obj['status']
    );
  }
}