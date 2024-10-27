class TipoServicioDAO {
  int? id;
  String? tipo_servicio;

  TipoServicioDAO({this.id, this.tipo_servicio});

  factory TipoServicioDAO.fromMap(Map<String, dynamic> obj){
    return TipoServicioDAO(
      id: obj['id'],
      tipo_servicio: obj['tipo_servicio']
    );
  }
}