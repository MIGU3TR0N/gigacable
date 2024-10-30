import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/clientedao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:gigacable/views/cliente_view.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ClienteViewItem extends StatefulWidget {
  ClienteViewItem({
    super.key,
    required this.clienteDAO
  });
  ClienteDAO clienteDAO;

  @override
  State<ClienteViewItem> createState() => _ClienteViewItemState();
}

class _ClienteViewItemState extends State<ClienteViewItem> {
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
                      child: ClienteView(clienteDAO: widget.clienteDAO, id: widget.clienteDAO.id,)
                    )
                  ]
                );
              }, icon: Icon(Icons.edit),),
              IconButton(onPressed: (){
                gigacableDatabase!.DELETE('cliente', widget.clienteDAO.id!).then((value) {
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
          )
        ],
      ),
    );
  }
}