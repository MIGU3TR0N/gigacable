class HistorialDAO {
  int? id;
  String? fecha;
  int? id_cliente;
  int? id_detalle_servicio;
  int? id_status;
  int? id_empleado;
  int? id_status_cliente;
  String? nombre;
  String? apellido;
  String? direccion;
  String? RFC;
  String? fecha_ingreso;
  String? status_servicio;

  HistorialDAO({this.id, this.fecha, this.id_cliente, 
                this.id_detalle_servicio, this.id_status, this.id_status_cliente,
                this.id_empleado, this.nombre, this.apellido, this.direccion,
                this.RFC, this.fecha_ingreso, this.status_servicio});

  factory HistorialDAO.fromMap(Map<String, dynamic> obj){
    return HistorialDAO(
      id: obj['id'],
      fecha: obj['fecha'],
      id_cliente: obj['id_cliente'],
      id_detalle_servicio: obj['id_detalle_servicio'],
      id_status: obj['id_status'],
      id_status_cliente: obj['id_status_cliente'],
      id_empleado: obj['id_empleado'],
      nombre: obj['nombre'],
      apellido: obj['apellido'],
      direccion: obj['direccion'],
      RFC: obj['RFC'],
      fecha_ingreso: obj['fecha_ingreso'],
      status_servicio: obj['status_servicio'],
    );
  }
}