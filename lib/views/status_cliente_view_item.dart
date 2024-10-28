import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/statusclientedao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:gigacable/views/status_cliente_view.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class StatusClienteViewItem extends StatefulWidget {
  StatusClienteViewItem({
    super.key,
    required this.statusClienteDAO
  });
  StatusClienteDAO statusClienteDAO;

  @override
  State<StatusClienteViewItem> createState() => _StatusClienteViewItemState();
}

class _StatusClienteViewItemState extends State<StatusClienteViewItem> {
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
                  title: Text(widget.statusClienteDAO.status_cliente!),
                ),
              ),
              IconButton(onPressed: (){
                WoltModalSheet.show(
                  context: context, 
                  pageListBuilder: (context) => [
                    WoltModalSheetPage(
                      child: StatusClienteView(statusClienteDAO: widget.statusClienteDAO,)
                    )
                  ]
                );
              }, icon: Icon(Icons.edit),),
              IconButton(onPressed: (){
                gigacableDatabase!.DELETE('cliente', widget.statusClienteDAO.id!).then((value) {
                  if( value > 0 ){
                    GlobalValues.banUpdListStatusClientes.value = !GlobalValues.banUpdListStatusClientes.value;
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