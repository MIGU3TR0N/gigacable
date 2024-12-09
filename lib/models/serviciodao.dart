class ServicioDAO {
  int? id;
  String? fecha;
  int? id_cliente;
  int? id_detalle_servicio;
  int? id_status;
  int? id_empleado;
   String? status_servicio;
   String? descripcion;

  ServicioDAO({this.id, this.fecha, this.id_cliente, this.id_detalle_servicio, this.id_status, this.id_empleado, this.status_servicio, this.descripcion});

  factory ServicioDAO.fromMap(Map<String, dynamic> obj){
    return ServicioDAO(
      id: obj['id'],
      fecha: obj['fecha'],
      id_cliente: obj['id_cliente'],
      id_detalle_servicio: obj['id_detalle_servicio'],
      id_status: obj['id_status'],
      id_empleado: obj['id_empleado'],
      status_servicio: obj['status_servicio'],
      descripcion: obj['descripcion']
    );
  }
}