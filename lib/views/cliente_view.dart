import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/clientedao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:quickalert/quickalert.dart';

class ClienteView extends StatefulWidget {
  ClienteView({
    super.key,
    this.clienteDAO,
    this.id
  });
  ClienteDAO? clienteDAO;
  int? id;

  @override
  State<ClienteView> createState() => _ClienteViewState();
}

class _ClienteViewState extends State<ClienteView> {
  TextEditingController conNombre = TextEditingController();
  TextEditingController conApellido = TextEditingController();
  TextEditingController conDireccion = TextEditingController();
  GigacableDatabase? gigacableDatabase;
  @override
  void initState() {
    super.initState();
    gigacableDatabase = GigacableDatabase();
    if (widget.clienteDAO != null){
      conNombre.text = widget.clienteDAO!.nombre!;
      conApellido.text = widget.clienteDAO!.apellido!;
      conDireccion.text = widget.clienteDAO!.direccion!;
    }
  }
  @override
  Widget build(BuildContext context) {
    final txtNombre = TextFormField(
      controller: conNombre,
      decoration: const InputDecoration(
        hintText: 'Nombre del cliente'
      ),
    );
    final txtApellido = TextFormField(
      controller: conApellido,
      decoration: const InputDecoration(
        hintText: 'Apellido del cliente'
      ),
    );
    final txtDireccion = TextFormField(
      controller: conDireccion,
      decoration: const InputDecoration(
        hintText: 'Direccion del cliente'
      ),
    );
    final btnGuardar = ElevatedButton(
      onPressed: (){
        if (widget.clienteDAO == null){
          gigacableDatabase!.INSERT('cliente', {
            'nombre': conNombre.text,
            'apellido': conApellido.text,
            'direccion': conDireccion.text,
            'id_status_cliente': 1,
          }).then((value){
            if(value > 0){
              GlobalValues.banUpdListClientes.value = !GlobalValues.banUpdListClientes.value;
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
            'id': widget.id!,
            'nombre': conNombre.text,
            'apellido': conApellido.text,
            'direccion': conDireccion.text,
            'id_status_cliente': 1,
          }).then((value){
            final msj;
            QuickAlertType type = QuickAlertType.success;
            if(value > 0){
              GlobalValues.banUpdListClientes.value = !GlobalValues.banUpdListClientes.value;
              type=QuickAlertType.success;
              msj = 'Transaction Completed Successfully';
            }else{
              type=QuickAlertType.error;
              msj = 'Something was wrong!';
            }
          });
        }
      }, 
      child: const Text('Guardar')
    );
    return ListView(
      shrinkWrap: true,
      children: [
        txtNombre,
        txtApellido,
        txtDireccion,
        btnGuardar
      ],
    );
  }
}