import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/statusclientedao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:quickalert/quickalert.dart';

class StatusClienteView extends StatefulWidget {
  StatusClienteView({
    super.key,
    this.statusClienteDAO
  });
  StatusClienteDAO? statusClienteDAO;

  @override
  State<StatusClienteView> createState() => _StatusClienteViewState();
}

class _StatusClienteViewState extends State<StatusClienteView> {
  TextEditingController conStatusCliente = TextEditingController();
  GigacableDatabase? gigacableDatabase;
  @override
  void initState() {
    super.initState();
    gigacableDatabase = GigacableDatabase();
    if (widget.statusClienteDAO != null){
      conStatusCliente.text = widget.statusClienteDAO!.status_cliente!;
    }
  }
  @override
  Widget build(BuildContext context) {
    final txtStatusCliente = TextFormField(
      controller: conStatusCliente,
      decoration: const InputDecoration(
        hintText: 'Nombre del estatus del cliente'
      ),
    );
    final btnGuardar = ElevatedButton(
      onPressed: (){
        if (widget.statusClienteDAO == null){
          gigacableDatabase!.INSERT('status_cliente', {
            'status_cliente': conStatusCliente.text,
          }).then((value){
            if(value > 0){
              GlobalValues.banUpdListStatusClientes.value = !GlobalValues.banUpdListStatusClientes.value;
              return QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: 'Transaction Completed Successfully!',
                autoCloseDuration: const Duration(seconds: 2),
                showConfirmBtn: false,
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
        }else{
          gigacableDatabase!.UPDATE('cliente', {
            'id': widget.statusClienteDAO!.id,
            'status_cliente': conStatusCliente.text,
          }).then((value){
            final msj;
            QuickAlertType type = QuickAlertType.success;
            if(value > 0){
              GlobalValues.banUpdListStatusClientes.value = !GlobalValues.banUpdListClientes.value;
              type=QuickAlertType.success;
              msj = 'Transaction Completed Successfully';
            }else{
              type=QuickAlertType.error;
              msj = 'Something was wrong!';
            }
          });
        }
        Navigator.pop(context);
      }, 
      child: const Text('Guardar')
    );
    return ListView(
      shrinkWrap: true,
      children: [
        txtStatusCliente,
        btnGuardar,
      ],
    );
  }
}