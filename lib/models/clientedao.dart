class ClienteDAO {
  int? id;
  String? nombre;
  String? apellido;
  String? direccion;
  int? id_status_cliente;

  ClienteDAO({this.id, this.nombre, this.apellido, this.direccion, this.id_status_cliente});

  factory ClienteDAO.fromMap(Map<String, dynamic> obj){
    return ClienteDAO(
      id: obj['id'],
      nombre: obj['nombre'],
      apellido: obj['apellido'],
      direccion: obj['direccion'],
      id_status_cliente: obj['id_status_cliente']
    );
  }
}