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
  late GigacableDatabase gigacableDB;
  @override
  void initState() {
    super.initState();
    gigacableDB = GigacableDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalValues.banUpdListHistorial,
        builder: (context, value, widget){
            return FutureBuilder(
                future: gigacableDB.selectHistorial(),
                builder: (context, AsyncSnapshot<List<HistorialDAO>?> snapshot){
                    if (snapshot.hasData){
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                                return HistorialViewItem(historialDAO: snapshot.data![index],);
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
    );
  }
}