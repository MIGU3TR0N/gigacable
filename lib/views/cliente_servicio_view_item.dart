import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/clientedao.dart';
import 'package:gigacable/views/cliente_servicio_view.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ClienteServicioViewItem extends StatefulWidget {
  ClienteServicioViewItem({
    super.key,
    required this.clienteDAO,
    required this.idser
  });
  ClienteDAO clienteDAO;
  int? idser;

  @override
  State<ClienteServicioViewItem> createState() => _ClienteServicioViewItemState();
}

class _ClienteServicioViewItemState extends State<ClienteServicioViewItem> {
  GigacableDatabase? gigacableDatabase;
  @override
  void initState() {
    super.initState();
    gigacableDatabase = GigacableDatabase();
    //int as = idser;
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.lightGreen
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(widget.clienteDAO.nombre! + ' ' + widget.clienteDAO.apellido!),
                  subtitle: Text(widget.clienteDAO.direccion!),
                ),
              ),
              IconButton(onPressed: (){
                WoltModalSheet.show(
                  context: context, 
                  pageListBuilder: (context) => [
                    WoltModalSheetPage(
                      child: ClienteServicioView(clienteDAO: widget.clienteDAO, id: widget.clienteDAO.id,id2: widget.idser,)
                    )
                  ]
                );
              }, icon: Icon(Icons.add),),
              
            ],
          )
        ],
      ),
    );
  }
}