class EmpleadoDAO {
  int? id;
  String? nombre;
  String? apellido;
  String? RFC;
  String? fecha_ingreso;

  EmpleadoDAO({this.id, this.nombre, this.apellido, this.RFC, this.fecha_ingreso});

  factory EmpleadoDAO.fromMap(Map<String, dynamic> obj){
    return EmpleadoDAO(
      id: obj['id'],
      nombre: obj['nombre'],
      apellido: obj['apellido'],
      RFC: obj['RFC'],
      fecha_ingreso: obj['fecha_ingreso']
    );
  }
}