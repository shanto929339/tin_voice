import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {

  final Random _random =
  Random(); // Create a Random object for generating random numbers
  int _randomNumber = 0;
  @override
  void initState() {
    setState(() {
      _randomNumber =
          1000 + _random.nextInt(9000);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height:double.maxFinite,
        width: double.maxFinite,
        child: PdfPreview(
          build: (format) => _generatePdf( "Test "),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf( String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            children: [
                pw.Row(
                  mainAxisAlignment:pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment:pw.CrossAxisAlignment.start,
                    children:[
                    pw.Text(
                     "Invoice",
                      style: pw.TextStyle(
                       fontSize: 24,
                        fontWeight: pw.FontWeight.bold
                      )
                    ),
                    pw.Text(
                    "#${_randomNumber.toString()}",
                     style: const pw.TextStyle(
                      fontSize:12,
                     )
                    )
                    ]
                    ),
                    pw.Align(
                     alignment:pw.AlignmentDirectional.centerEnd,
                      child:pw.SizedBox(
                        height: 80,
                        width: 80,
                        child: pw.FlutterLogo()),
                    ),
                  ],
                ),
              pw.SizedBox(
                height: 10
              ),
             pw.Divider(
               height: 1
             ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}

