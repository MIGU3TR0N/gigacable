import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/clientedao.dart';
import 'package:gigacable/models/historialdao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:gigacable/views/update_servicio_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class HistorialViewItem extends StatefulWidget {
  HistorialViewItem({
    super.key,
    required this.historialDAO,
  });
  HistorialDAO historialDAO;

  @override
  State<HistorialViewItem> createState() => _HistorialViewItemState();
}

class _HistorialViewItemState extends State<HistorialViewItem> {
  
  GigacableDatabase? gigacableDatabase;
  @override
  void initState() {
    super.initState();
    
    gigacableDatabase = GigacableDatabase();
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: (widget.historialDAO.status_servicio == 'completado') ? 
                GlobalValues().colorTerminado : 
                (widget.historialDAO.status_servicio == 'cancelado') ?
                GlobalValues().colorCancelado : GlobalValues().colorPendiente,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(widget.historialDAO.fecha!),
                  subtitle: Text(widget.historialDAO.nombre! + ' ' + widget.historialDAO.apellido!+' '+widget.historialDAO.status_servicio!),
                ),
              ),
              IconButton(onPressed: (){
                final aux = ClienteDAO(
                  id: widget.historialDAO.id_cliente,
                  nombre: widget.historialDAO.nombre,
                  apellido: widget.historialDAO.apellido,
                  direccion: widget.historialDAO.direccion,
                 // id_status_cliente: widget.historialDAO.id_status_cliente,
                );
                WoltModalSheet.show(
                  context: context, 
                  pageListBuilder: (context) => [
                    WoltModalSheetPage(
                      child: UpdateServicioView(historialDAO: widget.historialDAO,)
                    )
                  ]
                );
              }, icon: Icon(Icons.edit),),
              IconButton(onPressed: (){
                gigacableDatabase!.DELETE('servicio', widget.historialDAO.id!).then((value) {
                  if( value > 0 ){
                    GlobalValues.banUpdListClientes.value = !GlobalValues.banUpdListClientes.value;
                    return QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      text: 'Transaction Completed Successfully!',
                      autoCloseDuration: const Duration(seconds: 2),
                      showConfirmBtn: true,
                    );
                  }else{
                    return QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      text: 'Something was wrong! :()',
                      autoCloseDuration: const Duration(seconds: 2),
                      showConfirmBtn: false,
                    );
                  }
                });
              }, icon: Icon(Icons.delete),),
            ],
          ),
        ],
      ),
    );
  }
}