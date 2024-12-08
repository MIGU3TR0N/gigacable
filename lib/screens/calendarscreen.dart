import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/serviciodao.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendarscreen extends StatefulWidget {
  const Calendarscreen({super.key});

  @override
  State<Calendarscreen> createState() => _CalendarscreenState();
}

class _CalendarscreenState extends State<Calendarscreen> {
  late GigacableDatabase gigacableDB;
  DateTime today = DateTime.now();
  List<DateTime> serviceDates = [];

  Future<Map<String, dynamic>?> getServiceInfoByDate(DateTime date) async {
    // Convertir la fecha al formato de la base de datos
    String formattedDate = date.toIso8601String().split('T')[0]; // "YYYY-MM-DD"

    var con = await gigacableDB.database;

    // Consulta SQL para obtener la información del cliente y servicio
    var result = await con.rawQuery('''
      SELECT c.nombre AS clienteNombre, c.apellido AS clienteApellido, c.direccion
      FROM servicio s
      INNER JOIN cliente c ON s.id_cliente = c.id
      WHERE s.fecha = ?
    ''', [formattedDate]);

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
  bool isDateHighlighted(DateTime date) {
    return serviceDates.any((highlightedDate) => isSameDay(date, highlightedDate));
  }
  Future<void> _ondayselected (DateTime day, DateTime focusedDay) async {
    setState(() {
                today = day;
              });
    if (isDateHighlighted(day)) {
      final serviceInfo = await getServiceInfoByDate(day);
      // print('Fecha resaltada seleccionada: $day');
      // Realiza una acción específica para fechas resaltadas
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Sevicio pendiente el dia ${day.toLocal().toString().split(' ')[0]}"),
          content: Text("Usted tiene un servicio con el cliente ${serviceInfo?['clienteNombre']} ${serviceInfo?['clienteApellido']} "
            "en la calle ${serviceInfo?['direccion']}."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cerrar"),
            ),
          ],
        ),
      );
    } else {
      print('Fecha seleccionada no resaltada: $day');
    }
  }
  @override
  void initState() {
    super.initState();
    gigacableDB = GigacableDatabase();
    fetchServiceDates();
  }

  Future<void> fetchServiceDates() async {
    List<ServicioDAO>? services = await gigacableDB.selectServicio();
    if (services != null) {
      setState(() {
        serviceDates = services
            .where((service) => service.fecha != null)
            .map((service) {
              try {
                return DateTime.parse(service.fecha!);
              } catch (e) {
                print('Error al parsear la fecha: ${service.fecha}');
                return null;
              }
            })
            .whereType<DateTime>()
            .toList();
      });
    }
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
          Text("Día seleccionado: ${today.toString().split(" ")[0]}"),
          Container(
            child: TableCalendar(
              focusedDay: today,
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              selectedDayPredicate: (day) => isSameDay(day, today),
              onDaySelected: _ondayselected,
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  // Verificar si el día actual está en la lista de fechas de servicios
                  bool isServiceDay = serviceDates.contains(
                    DateTime(day.year, day.month, day.day),
                  );

                  if (isServiceDay) {
                    // Si es un día con servicio, resaltar
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }

                  // Devolver el diseño por defecto
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}