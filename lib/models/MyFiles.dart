import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constants.dart';

class CloudStorageInfo {
  final String svgSrc, title, cantidadCliente;
  final int totaltarea, percentage;
  final Color color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.cantidadCliente,
    this.totaltarea,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "TAREAS",
    totaltarea: 4,
    svgSrc: "assets/icons/drop_box.svg",
    cantidadCliente: "10 ",
    color: primaryColor,
    percentage: 40,
  ),
  // CloudStorageInfo(
  //   title: "RENDICIONES",
  //   totaltarea: 1328,
  //   svgSrc: "assets/icons/google_drive.svg",
  //   cantidadCliente: "2.9GB",
  //   color: Color(0xFFFFA113),
  //   percentage: 35,
  // ),
  // CloudStorageInfo(
  //   title: "One Drive",
  //   totaltarea: 1328,
  //   svgSrc: "assets/icons/one_drive.svg",
  //   cantidadCliente: "1GB",
  //   color: Color(0xFFA4CDFF),
  //   percentage: 10,
  // ),
  // CloudStorageInfo(
  //   title: "Documents",
  //   totaltarea: 5328,
  //   svgSrc: "assets/icons/drop_box.svg",
  //   cantidadCliente: "7.3GB",
  //   color: Color(0xFF007EE5),
  //   percentage: 78,
  // ),
];
