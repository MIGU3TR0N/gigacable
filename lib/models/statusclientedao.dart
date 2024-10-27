class StatusClienteDAO {
  int? id;
  String? status_cliente;

  StatusClienteDAO({this.id, this.status_cliente});

  factory StatusClienteDAO.fromMap(Map<String, dynamic> obj){
    return StatusClienteDAO(
      id: obj['id'],
      status_cliente: obj['status_cliente']
    );
  }
}