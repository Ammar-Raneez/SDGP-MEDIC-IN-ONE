import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/constants.dart';

class CancerPrognosis extends StatefulWidget {

  String cancerType;
  var cancerPrognosisAttributes;

  CancerPrognosis(String cancerType)
  {
    this.cancerType = cancerType;

    if (cancerType == "Breast Cancer")
      cancerPrognosisAttributes = BREAST_CANCER_PROGNOSIS_QUESTIONS;
    else if (cancerType == "Lung Cancer")
      cancerPrognosisAttributes = LUNG_CANCER_PROGNOSIS_QUESTIONS;
    else if (cancerType == "Skin Cancer")
      cancerPrognosisAttributes = SKIN_CANCER_PROGNOSIS_QUESTIONS;
  }

  @override
  _CancerPrognosisState createState() => _CancerPrognosisState(cancerType, cancerPrognosisAttributes);
}

class _CancerPrognosisState extends State<CancerPrognosis> {

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];
  String cancerType;
  var cancerPrognosisAttributes;

  _CancerPrognosisState(String cancerType, var cancerPrognosisAttributes)
  {
    this.cancerType = cancerType;
    this.cancerPrognosisAttributes = cancerPrognosisAttributes;
  }

  void getPostsData() {
    List<dynamic> responseList = cancerPrognosisAttributes;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(
          Container(
              height: 190,
              // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18)
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Container(
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        margin: EdgeInsets.only(top: 0, bottom: 50),
                        width: double.infinity,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Color(0xFFABD8E2),
                        ),
                        child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child:Text(
                                    post,
                                    style:TextStyle(
                                      fontFamily: 'Poppins-SemiBold',
                                      color: Colors.blueGrey,
                                      fontSize: 20,
                                    ),
                                  )
                              ),
                              TextField(

                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white),
                                      borderRadius: new BorderRadius.circular(16),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white),
                                      borderRadius: new BorderRadius.circular(16),
                                    ),
                                    hintText: 'Enter the Value for the Input'
                                ),
                              ),
                            ]
                        )
                    ),
                  )
              )
          )
      );
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 150;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar("arrow", context),
        body:  Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  cancerType,
                  style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 27,
                    color: Color(0xFF93ACB1),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Prognosis",
                  style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 27.0,
                    color: Color(0xFF565D5E),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        if (topContainer > 0.5) {
                          scale = index + 0.5 - topContainer;
                          if (scale < 0) {
                            scale = 0;
                          } else if (scale > 1) {
                            scale = 1;
                          }
                        }
                        return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform: Matrix4.identity()..scale(scale, scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                      })
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                width: double.infinity,

                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 50, right: 50),
                child: RawMaterialButton(
                  fillColor: Colors.black54,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        SizedBox(
                          width: 10.0,
                          height: 30.0,
                        ),
                        Text(
                          "Predict",
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-Regular',
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                  shape: const StadiumBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
