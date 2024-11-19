class DetalleServicioDAO {
  int? id;
  String? servicio;
  int? id_detalle_servicio;

  DetalleServicioDAO({this.id, this.servicio, this.id_detalle_servicio});

  factory DetalleServicioDAO.fromMap(Map<String, dynamic> obj){
    return DetalleServicioDAO(
      id: obj['id'],
      servicio: obj['servicio'],
      id_detalle_servicio: obj['id_detalle_servicio']
    );
  }
}