import 'package:flutter/material.dart';

class GlobalValues {
  static ValueNotifier banUpdListClientes = ValueNotifier(false);
  static ValueNotifier banUpdListStatusClientes = ValueNotifier(false);
  static ValueNotifier banUpdListservicios = ValueNotifier(false);
  static ValueNotifier banUpdListHistorial = ValueNotifier(false);
  final colorTerminado = Colors.lightGreen;
  final colorCancelado = Colors.redAccent;
  final colorPendiente = const Color.fromARGB(255, 125, 162, 180);
}