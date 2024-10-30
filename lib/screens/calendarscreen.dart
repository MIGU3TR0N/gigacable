import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/detalleserviciodao.dart';
import 'package:gigacable/models/serviciodao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:gigacable/views/servicio_item_ver.dart';
import 'package:gigacable/views/servicio_view_item.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendarscreen extends StatefulWidget {
  const Calendarscreen({super.key});

  @override
  State<Calendarscreen> createState() => _CalendarscreenState();
}

class _CalendarscreenState extends State<Calendarscreen> {
  late GigacableDatabase gigacableDB;
  DateTime today = DateTime.now();
  void _ondayselected (DateTime day, DateTime focusedDay){
    setState(() {
                today = day;
              });
  }
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
        title: Text('Calendario servicios'),

      ),
      
      /*ValueListenableBuilder(
        builder: (context) {
          return FutureBuilder(
            future: gigacableDB.selectServicio(),
          
            builder: (context, AsyncSnapshot<List<ServicioDAO>?> snapshot) {
          
              return ;
            },
          );
        }
      ), *****/
      body: Column(
        children: [
          Text("dia: "+today.toString().split(" ")[0]),
          Container(
            child: TableCalendar(
              focusedDay: today, firstDay: DateTime.now(), lastDay: DateTime(2100),
              selectedDayPredicate: (day) => isSameDay(day, today),
              onDaySelected: _ondayselected,
              ),
          )
        ],
      )
    );
  }
}