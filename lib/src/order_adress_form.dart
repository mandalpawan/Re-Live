import 'package:flutter/material.dart';


class OrderFrom extends StatefulWidget {
  @override
  _OrderFromState createState() => _OrderFromState();
}

class _OrderFromState extends State<OrderFrom> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _mobile = TextEditingController();
  TextEditingController _table = TextEditingController();
  TextEditingController _name = TextEditingController();
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details"
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      key: _key,
      body:Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[350],
                    blurRadius:
                    20.0, // has the effect of softening the shadow
                  )
                ],
              ),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              'assets/images/Illu/order.png',
                              width: 260.0,height: 150.0,
                            )),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.3),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _name,
                                decoration: InputDecoration(
                                    hintText: "Full name",
                                    icon: Icon(Icons.person_outline),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "The name field cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.3),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _mobile,
                                decoration: InputDecoration(
                                    hintText: "Mobile Number",
                                    icon: Icon(Icons.phone),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "The name field cannot be empty";
                                  } if (value.length != 10) {
                                    return "Number is invalid";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.3),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _table,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "Table Number",
                                    icon: Icon(Icons.table_chart),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "The name field cannot be empty";
                                  }if (value.length != 1) {
                                    return "Invalid table Number";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                   /*
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.orangeAccent,
                            elevation: 0.0,
                            child: MaterialButton(
                              onPressed: () async{
                                if(_formKey.currentState.validate()) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context){
                                      return Payment(Name:_name.text ,mobile: _mobile.text,table_no: _table.text,);
                                    }
                                  ));
                                }
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text(
                                "Process to Payment",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            )),
                      ),*/
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

}