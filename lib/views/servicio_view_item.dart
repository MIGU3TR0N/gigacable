import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/detalleserviciodao.dart';

class ServicioViewItem extends StatefulWidget {
  ServicioViewItem({
    super.key,
    required this.detalleserviceDAO
  });
  DetalleServicioDAO detalleserviceDAO;

  @override
  State<ServicioViewItem> createState() => _ServicioViewItemState();
}

class _ServicioViewItemState extends State<ServicioViewItem> {
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
        color: const Color.fromARGB(255, 74, 116, 195)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(widget.detalleserviceDAO.servicio!),
                  subtitle: Text('chavo'),
                ),
              ),
              IconButton(onPressed: (){
                /*gigacableDatabase!.DELETE('cliente', widget.detalleserviceDAO.id!).then((value) {
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
                });*/
                //gigacableDatabase!.INSERT(table, row)
                int? ashanti = widget.detalleserviceDAO.id;
                Navigator.pushNamed(context, '/servicedetails2',arguments: ashanti);

              }, icon: Icon(Icons.add),),
            ],
          )
        ],
      ),
    );
  }
}