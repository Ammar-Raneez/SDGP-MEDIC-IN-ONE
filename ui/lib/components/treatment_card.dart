import 'package:flutter/material.dart';

class TreatmentCard extends StatelessWidget {
  final String cardTitle;

  const TreatmentCard({@required this.cardTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC6E7EE), Color(0xFF637477)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
        ),
        padding: EdgeInsets.only(top: 120.0, left: 20.0),
        width: 322.0,
        height: 164.0,
        child: Text(
          cardTitle,
          style: TextStyle(
            fontSize: 23.0,
            color: Color(0xFF63888F),
            fontFamily: 'Poppins-SemiBold',
          ),
        ),
      ),
    );
  }
}