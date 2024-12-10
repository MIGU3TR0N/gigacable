import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/historialdao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:gigacable/views/historial_view_item.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<String> status = ['completado', 'pendiente', 'cancelado'];
  String? selectedStatus;
  late GigacableDatabase gigacableDB;
  @override
  void initState() {
    super.initState();
    selectedStatus = "pendiente";
    gigacableDB = GigacableDatabase();
  }
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        leading: dropMenu,
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.banUpdListHistorial,
        builder: (context, value, widget){
            return FutureBuilder(
                future: gigacableDB.selectHistorialstate(dropMenu.value!),
                builder: (context, AsyncSnapshot<List<HistorialDAO>?> snapshot){
                    if (snapshot.hasData){
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                                return Stack(children: [
                                  
                                  HistorialViewItem(historialDAO: snapshot.data![index],)
                                ],)
                                ;
                            },
                        );
                    }else{
                        if(snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString()),);
                        }else{
                            return Center(child: CircularProgressIndicator(),);
                        }
                    }
                }
            );
        },
    ),
    );
  }
}