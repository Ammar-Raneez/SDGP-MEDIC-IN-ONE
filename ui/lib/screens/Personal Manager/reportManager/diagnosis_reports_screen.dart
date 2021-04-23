import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/report_widgets/ReportListWidget.dart';
import 'package:ui/screens/current_screen.dart';
import 'api/ReportFirebaseApi.dart';
import 'api/ReportProvider.dart';
import 'models/report.dart';

class DiagnosisReports extends StatefulWidget {
  @override
  _DiagnosisReportsState createState() => _DiagnosisReportsState();
}

class _DiagnosisReportsState extends State<DiagnosisReports> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar.arrow(context),
        body: SafeArea(
          child: Expanded(
            child: Container(
              child: Column(
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              bottom: 8,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Diagnosis Reports",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 32,
                                    color: Color(0xFF00404E)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 15),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Here you can view the reports created after a diagnosis",
                                style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 13.0,
                                  color: Color(0xFF3C707B),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        child: StreamBuilder<List<Report>>(
                            stream: ReportFirebaseApi.readDiagnosisReports(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                default:
                                  if (snapshot.hasError) {
                                    return buildText(
                                        'Something went wrong, Try later');
                                  } else {
                                    final reports = snapshot.data;

                                    final provider =
                                        Provider.of<ReportProvider>(context);
                                    provider.setReports(reports);

                                    return ReportListWidget();
                                  }
                              }
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CurrentScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.lightBlueAccent,
                          ),
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          width: 250.0,
                          height: 65.0,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Back To Home Page",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: 'Poppins-Regular',
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
