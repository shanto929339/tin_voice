import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';


class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  DateTime now=DateTime.now();
  getDate(){
     now = DateTime.now();
  }
  //String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
  final Random _random =
      Random(); // Create a Random object for generating random numbers
  int _randomNumber = 0;
  @override
  void initState() {
    setState(() {
      getDate();
      _randomNumber = 1000 + _random.nextInt(9000);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: PdfPreview(
          build: (format) => _generatePdf(),
        ),
      ),
    );
  }

  ///<<<<<<<<<<<<<<<< this part is design pdf >>>>>>>>>>>>>>>>>>

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Invoice",
                            style: pw.TextStyle(
                                fontSize: 24, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height:10),
                    ///<<<<<<<<<<<<<<<<<<<<<<<<<< This is for date section >>>>>>>>>>>>>>>>>>>>>>>>
                        pw.Row(
                         children: [
                           pw.Text(
                               "Date: ",
                             style: pw.TextStyle(
                               fontSize: 14,
                             fontWeight: pw.FontWeight.bold,
                             ),
                           ),

                           pw.Text(
                            DateFormat("yMMMd").format(now)
                           )

                         ]
                        ),
                        pw.SizedBox(height:8),

                        pw.Row(
                          children: [

                            pw.Text(
                              "Invoice",
                              style: pw.TextStyle(
                               fontSize: 14,
                               fontWeight: pw.FontWeight.bold
                              )
                            ),

                            pw.Text(": #${_randomNumber.toString()}",
                                style: const pw.TextStyle(
                                  fontSize: 12,
                                )),
                          ],
                        )
                      ]),
                  pw.Align(
                    alignment: pw.AlignmentDirectional.centerEnd,
                    child: pw.SizedBox(
                        height: 80, width: 80, child:
                        //pw.Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSL3kmkFtmxjnWrKc3LDY289a0UroPToiMdTQ&s"),
                    pw.FlutterLogo()),

                  ),
                ],
              ),
              pw.SizedBox(height: 16),
              pw.Divider(height: 1),

            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
