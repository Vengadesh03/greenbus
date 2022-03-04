import 'package:bloodbank/Screens/seat.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  // const DashBoard({ Key? key }) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(top:15),
          child: Icon(Icons.arrow_back, color: Colors.black)),
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          "Chennai - Bangalore",
          style: TextStyle(color: Colors.black),
        )),
        elevation: 0.0,
        bottom: PreferredSize(
          
          preferredSize: null,
          child: BottomAppBar(
              elevation: 0.0, child: Container(
                margin: EdgeInsets.only(bottom:5),
                child: Center(child: Text("20-SEP-2022")))),
              
        ),
        
        actions: [Padding(
          padding: EdgeInsets.all(10),
          child: Icon(Icons.messenger_rounded,color: Colors.black,)
          )
          ],
        
      ),
      
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Bookingseats()));
                      },
                                          child: Container(
                        height: 100,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromRGBO(252, 252, 252, 1),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              // backgroundColor: Colors.amber,
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey[50],
                                  radius: 30,
                                  // child: Image.asset("assets/images/nophotoMale.png")
                                  backgroundImage:
                                      AssetImage("assets/images/bus.png")),
                            ),

                            //  CircleAvatar(

                            //    radius: 35,
                            //    child: Padding(padding: EdgeInsets.all(88),),
                            //    backgroundColor: Colors.white,
                            //    backgroundImage:
                            //    AssetImage("assets/images/bus.png",

                            //    ),

                            //  ),
                            SizedBox(width: 20),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Parveen Travels",
                                    style: TextStyle(color: Color(0xff575757)),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    "Non A/C Semi Sleeper (2+2)",
                                    style: TextStyle(color: Color(0xffAEAEAE)),
                                  ),
                                  SizedBox(height: 7),

                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Text('20:11',
                                          style: TextStyle(
                                              color: Color(0xffBABABA))),
                                      SizedBox(width: 7),
                                      Icon(
                                        Icons.arrow_right_alt_sharp,
                                        color: Color(0xffBABABA),
                                      ),
                                      SizedBox(width: 7),
                                      Text('06:30',
                                          style: TextStyle(
                                              color: Color(0xffBABABA))),
                                    ],
                                  )
                                  //  Text("20:11${Icons.arrow_right_alt_sharp}06:30",style: TextStyle(color:Color(0xffBABABA)),),
                                  //  Image.asset("assets/images/icons8-Long Arr.png")
                                ]),
                            SizedBox(width: 20),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "₹640",
                                    style: TextStyle(
                                        color: Color(0xff50C96A),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "34 Seats",
                                    style: TextStyle(color: Color(0xffBABABA)),
                                  ),
                                ])
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
