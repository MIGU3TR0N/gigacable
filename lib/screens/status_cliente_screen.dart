import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/statusclientedao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:gigacable/views/status_cliente_view.dart';
import 'package:gigacable/views/status_cliente_view_item.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class StatusClienteScreen extends StatefulWidget {
  const StatusClienteScreen({super.key});

  @override
  State<StatusClienteScreen> createState() => _StatusClienteScreenState();
}

class _StatusClienteScreenState extends State<StatusClienteScreen> {
  late GigacableDatabase gigacableDB;
  @override
  void initState() {
    super.initState();
    gigacableDB = GigacableDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(178, 121, 222, 235),
        leading: IconButton(
          onPressed: (){
            WoltModalSheet.show(
              context: context, 
              pageListBuilder: (context) => [
                WoltModalSheetPage(
                  child: StatusClienteView()
                )
              ]
            );
          }, 
          icon: Icon(Icons.add)
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.banUpdListStatusClientes,
        builder: (context, value, Widget){
          return FutureBuilder(
            future: gigacableDB.selectStatusCliente(), 
            builder: (context, AsyncSnapshot<List<StatusClienteDAO>?> snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return StatusClienteViewItem(statusClienteDAO: snapshot.data![index],);
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