import 'package:flutter/material.dart';
class Bookingseats extends StatefulWidget {
  // const Bookingseats({ Key? key }) : super(key: key);

  @override
  _BookingseatsState createState() => _BookingseatsState();
}

class _BookingseatsState extends State<Bookingseats> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            body: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width*1,
              color: Color.fromRGBO(102, 219, 127, 1),
              child:Column(
                children:[
                  Container(
                    margin: EdgeInsets.only(right:320,top:20),
                    child: Icon(Icons.arrow_back)),
               
                  Text("Chennai - Bangalore",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                  SizedBox(height:10),
                  Text("K.P.N Travels",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)
               ,   SizedBox(height:10),
                  Text("Volvo A/C Multi Axle Semi Sleeper",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)
                ]
              ),
              
              
            ),
          
            Seat(),
            Seat(),
            Seat(),
            Seat(),
            Seat(),

            Seat()
          ],
        ),
      ),
    );
  }
}

class Seat extends StatelessWidget {
  const Seat({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height:20),
        Row(children: [
          
            SizedBox(width:20),
          Image.asset("assets/images/seat.png",color: Colors.grey[600],),
          SizedBox(width:20),
          Image.asset("assets/images/seat.png",color: Colors.grey[600]),
          SizedBox(width:20),
          Image.asset("assets/images/seat.png",color: Colors.grey[600]),
          SizedBox(width:100),
          Image.asset("assets/images/seat.png",color: Colors.grey[600]),
               SizedBox(width:20),
          Image.asset("assets/images/seat.png",color: Colors.grey[600]),
        ],),
      ],
    );
  }
}