class RecentFile {
  //final String icon, title, date, size;
  final String date, customer, invoice, status, import;

  RecentFile(
      {this.date, this.customer, this.invoice, this.status, this.import});
}

List demoListRouters = [
  RecentFile(
    date: "01-03-2021",
    customer: "GREDESA S.A.S",
    invoice: "27870",
    status: "PENDIENTE A COBRAR",
    import: "124,830.05",
  ),
  RecentFile(
    date: "01-03-2021",
    customer: "VIGLIONE CARLOS ALBERTO",
    invoice: "27934",
    status: "PENDIENTE A COBRAR",
    import: "144,330.05",
  ),
  RecentFile(
    date: "01-03-2021",
    customer: "GREDESA S.A.S",
    invoice: "27870",
    status: "PENDIENTE A COBRAR",
    import: "124,830.05",
  ),
  RecentFile(
    date: "01-03-2021",
    customer: "SUCESION DE WENDELER JUAN PEDRO",
    invoice: "27872",
    status: "PENDIENTE A COBRAR",
    import: "14,430.05",
  ),
  RecentFile(
    date: "01-03-2021",
    customer: "MORCILLO OSVALDO HORACIO",
    invoice: "27878",
    status: "PENDIENTE A COBRAR",
    import: "24,830.05",
  ),
  // RecentFile(
  //   icon: "assets/icons/xd_file.svg",
  //   title: "XD File",
  //   date: "01-03-2021",
  //   size: "3.5mb",
  // ),
  // RecentFile(
  //   icon: "assets/icons/Figma_file.svg",
  //   title: "Figma File",
  //   date: "27-02-2021",
  //   size: "19.0mb",
  // ),
  // RecentFile(
  //   icon: "assets/icons/doc_file.svg",
  //   title: "Document",
  //   date: "23-02-2021",
  //   size: "32.5mb",
  // ),
  // RecentFile(
  //   icon: "assets/icons/sound_file.svg",
  //   title: "Sound File",
  //   date: "21-02-2021",
  //   size: "3.5mb",
  // ),
  // RecentFile(
  //   icon: "assets/icons/media_file.svg",
  //   title: "Media File",
  //   date: "23-02-2021",
  //   size: "2.5gb",
  // ),
  // RecentFile(
  //   icon: "assets/icons/pdf_file.svg",
  //   title: "Sales PDF",
  //   date: "25-02-2021",
  //   size: "3.5mb",
  // ),
  // RecentFile(
  //   icon: "assets/icons/excle_file.svg",
  //   title: "Excel File",
  //   date: "25-02-2021",
  //   size: "34.5mb",
  // ),
];
