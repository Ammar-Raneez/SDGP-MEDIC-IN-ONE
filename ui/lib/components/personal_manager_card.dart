import 'package:flutter/material.dart';

class PersonalCard extends StatelessWidget {

  final String cardTitle;
  final String cardColor1;
  final String cardColor2;
  final String textColor;

  PersonalCard({@required this.cardTitle, @required this.cardColor1, @required this.cardColor2, @required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 7,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Container(
                height: 130.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 18,
                      left:21,),

                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child:Text(
                      cardTitle,
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Color(int.parse(textColor)),
                        fontFamily: 'Poppins-SemiBold',
                      ),
                    ),
                  ),
                ),
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(22.0),
                    gradient: LinearGradient(
                      colors: [
                        Color(int.parse(cardColor2)),
                        Color(int.parse(cardColor1)),
                      ],
                      begin: Alignment(1.2,1),
                      end: Alignment(0.8,-2),
                    ),
                  )
              ),
              // color: Color(int.parse(cardColor)),
            ),
          ),
    );
  }
}
