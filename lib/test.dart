import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'utillities.dart';
class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final _formKey = GlobalKey<FormState>();

  String _Name,_PhoneNumber,_Area;
  String dropdownValue = 'المدينة';
  int counter = 4 ;
  @override


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Utility.c,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:8,bottom: 8,right: 20),
              child: Text("الشراء",style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: "thin"
              ),),
            )
          ],
        ),
        body:Form(
          key: _formKey,
          child: Column(
            children: <Widget>[




              Column(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 18,right: 18,top: 30,bottom: 20),
                    child: Image.asset("assets/images/3.png",fit: BoxFit.cover,)),

      GestureDetector(
        onTap: (){

        },
        child: Utility.contaner(
                      Colors.white, context, Text("طريقة التغليف",style: TextStyle(

                      fontFamily: "black",
                      color: Utility.c,
                      fontSize: 18
                  ),)),
      ),






//                Utility.contaner(
//                    Colors.white, context, Text("طريقة التغليف",style: TextStyle(
//
//                    fontFamily: "black",
//                    color: Utility.c,
//                    fontSize: 18
//                ),)),
//                Container(
//                  height: MediaQuery.of(context).size.height/4.5,
//                  width: MediaQuery.of(context).size.width,
//                  margin: EdgeInsets.only(left: 18,right: 18,top: 12,bottom: 12),
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(20)
//
//                  ),
//                  child: FadeInImage.assetNetwork(
//                      height: MediaQuery.of(context).size.width/3-40,
//                      placeholder: "assets/images/reload2.gif",
//                      image:"https://i2.wp.com/www.caironewss.com/wp-content/uploads/%D8%AE%D8%B1%D9%88%D9%81-%D8%A7%D9%84%D8%B9%D9%8A%D8%AF.png?fit=450%2C328"
//                      ,
//                      fit: BoxFit.fill),
//                ),
//
//                Utility.contaner(Colors.white, context, Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    PopupMenuButton<String>(
//                      icon: Icon(Icons.keyboard_arrow_down),
//                      onSelected: (value)=>
//                          setState(() {
//                            dropdownValue=value;
//                          })
//                      ,
//                      itemBuilder: (BuildContext context) {
//                        return Constants.choices.map((String choice) {
//                          return PopupMenuItem<String>(
//                            value: choice,
//                            child: Text(choice),
//                          );
//                        }).toList();
//                      },
//                    ),
//                    Text(dropdownValue,style: TextStyle(
//                        color: Colors.grey,
//                        fontFamily: "thin",
//                        fontSize: 15
//                    ),
//
//
//                    ),
//
//
//
//
//
//
//
//
//                  ],
//                )),
//                Utility.contaner(Colors.white, context, Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text("ريال سعودي",style: TextStyle(
//                      color: Colors.grey,
//                      fontSize: 15,
//                      fontFamily: "thin"
//                    ),),
//                    Text("110",style: TextStyle(
//                        color: Utility.c,
//                        fontSize: 15,
//                        fontFamily: "thin"
//                    )),
//                    Text(": السعر",style: TextStyle(
//                        color: Colors.grey,
//                        fontSize: 15,
//                        fontFamily: "thin"
//                    ))
//                  ],
//                )),

              ],),


              //Text('Selected: ${_selectedCompany.name}'),



            ],
          ),
        )
    );
  }
}
class Constants {


  static const List<String> choices = <String>[
    'First Item',
    'Second Item',
    'Third Item',
  ];
}
class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool _Check=false;


  @override
  Widget build(BuildContext context) {
    return SimpleDialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
    ),

   backgroundColor: Colors.transparent,

      children: <Widget>[
      Column(
        children: <Widget>[
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
           child: Text("تفاصيل الطلب",style: TextStyle(
             fontSize: 15,fontFamily: "thin",color: Colors.white
           ),),
           decoration: BoxDecoration(
             color: Utility.c,
             borderRadius: BorderRadius.only(

               topLeft: Radius.circular(12),
                 topRight: Radius.circular(12)
             )

           ),

          ),
          Container(

            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(right: 12,top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.only(

                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)
                )

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("بربري مناسب للثلاجةو الصدفات",style: TextStyle(
                  fontFamily: "thin",
                  fontSize: 14,
                  color: Colors.grey

                ),),

                Text("بربري منال نتةن يبنيتبني للثلاجةو الصدفات",textAlign: TextAlign.right,style: TextStyle(
                    fontFamily: "thin",
                    fontSize: 14,
                    color: Colors.grey

                ),),
                Utility.contaner(Colors.white, context, Text("قيمة المنتج :290 ريال سعودي",style: TextStyle(
                    fontFamily: "thin",
                    fontSize: 15,
                    color: Colors.grey

                ),)),
                Utility.contaner(Colors.grey[400], context, Text(
                  "اضافة طلب اخر",
                  style: TextStyle(
                    fontFamily: "thin",
                    fontSize: 15,
                    color: Colors.white
                  ),
                )),
                Utility.contaner(Utility.c, context, Text(
                  "اكمال الطلب",
                  style: TextStyle(
                      fontFamily: "thin",
                      fontSize: 15,
                      color: Colors.white
                  ),
                )),
                SizedBox(
                  height: 20,
                )


              ],
            ),
          )

        ],
      )
      ],
    );
  }
}