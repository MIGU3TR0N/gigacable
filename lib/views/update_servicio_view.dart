import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/historialdao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:quickalert/quickalert.dart';

class UpdateServicioView extends StatefulWidget {
  UpdateServicioView({
    super.key,
    this.historialDAO,
  });
  HistorialDAO? historialDAO;

  @override
  State<UpdateServicioView> createState() => _UpdateServicioViewState();
}

class _UpdateServicioViewState extends State<UpdateServicioView> {
  String? selectedStatus;
  final List<String> status = ['completado', 'pendiente', 'cancelado'];
  TextEditingController confecha = TextEditingController();

  GigacableDatabase? gigacableDatabase;
  @override
  void initState() {
    super.initState();
    gigacableDatabase = GigacableDatabase();
    selectedStatus = "pendiente";
    
  }
  @override
  Widget build(BuildContext context) {
    
    
    int? ames = widget.historialDAO!.id_cliente;
    String? emas = widget.historialDAO!.nombre;
    final txtNombre = TextField(
      controller: confecha,
      decoration: const InputDecoration(
        labelText: 'Fecha del servicio ',
        filled: true,
        prefixIcon: Icon(Icons.calendar_today),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue)
        )
      ),
      readOnly: true,
      onTap: (){
        _selectDate();
      },
    );

    final dropMenu = DropdownButton<String>(
      hint: const Text('Seleccione el tipo de usuario',
          style: TextStyle(color: Colors.black)),
      value: selectedStatus,
      onChanged: (String? newValue) {
        setState(() {
          selectedStatus = newValue;
        });
      },
      items: status.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: const TextStyle(color: Colors.black)),
        );
      }).toList(),
    );
    
//////////////////left of

    final btnGuardar = ElevatedButton(
      onPressed: (){
        gigacableDatabase!.UPDATE('servicio', {
            'id': widget.historialDAO!.id,
            'fecha': (confecha.text != '') ? confecha.text : widget.historialDAO!.fecha,
            'id_cliente': ames,
            'id_detalle_servicio': widget.historialDAO!.id_detalle_servicio,//////////conseguir la id de alguna manera...
            'id_status': 1,
            'id_empleado': 1,
            'status_servicio': selectedStatus,
          }).then((value){
            if(value > 0){
              GlobalValues.banUpdListservicios.value = !GlobalValues.banUpdListservicios.value;
              return QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: 'Transaction Completed Successfully!',
                autoCloseDuration: const Duration(seconds: 2),
                showConfirmBtn: false,
              ).then((_){
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home', // Ruta del Home
                  ModalRoute.withName('/login'), // Mantén solo la ruta del Login
                );
              });
            }else{
              return QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: 'Something was wrong! :()',
                autoCloseDuration: const Duration(seconds: 2),
                showConfirmBtn: false,
              );
            }
          });/*else{
          gigacableDatabase!.UPDATE('cliente', {
            'id': widget.id!,
            'nombre': confecha.text,
            'id_status_cliente': 1,
          }).then((value){
            final msj;
            QuickAlertType type = QuickAlertType.success;
            if(value > 0){
              GlobalValues.banUpdListservicios.value = !GlobalValues.banUpdListservicios.value;
              type=QuickAlertType.success;
              msj = 'Transaction Completed Successfully';
            }else{
              type=QuickAlertType.error;
              msj = 'Something was wrong!';
            }
          });
        }*/
      }, 
      child: const Text('Guardar')
    );
    return ListView(
      shrinkWrap: true,
      children: [
        Text('cliente: $emas'),
        txtNombre,
        dropMenu,
        btnGuardar
      ],
    );
  }
  Future <void> _selectDate() async {
    DateTime? _picked = await showDatePicker(context: context, 
  initialDate: DateTime.now(),
  firstDate: DateTime.now(), 
  lastDate: DateTime(2100));
  if (_picked != null){
    setState(() {
      confecha.text = _picked.toString().split(" ")[0];
      print( _picked.toString().split(" ")[0]);
    });
  }
}
}