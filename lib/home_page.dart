import 'package:crud_sqlite/models/contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  Contact _contact = Contact(id: '',name: '',phoneNumber:'');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Titulo',
            style: TextStyle(color: Color.fromARGB(66, 0, 187, 212),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _form(),  
          ],         
        ),
      ), 
      backgroundColor: Colors.grey[300],     
    );
  }

  _form() => Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Full Name'),
            onSaved: (value) => setState(() => _contact.name = value ?? ''),
            validator: (value){
              if(value!.trim().isEmpty){return 'This field is required';}
              if(value.trim().length < 3){ return 'Minimum 3 characters';}
              else {return null;}
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Phone Number'),
            onSaved: (value) => setState(() => _contact.phoneNumber = value ?? ''),
            validator:(value){
              if(value!.trim().isEmpty){return 'This field is required';}
              if(value!.trim().length != 11){return 'This field must contain 11 numbers';}
              else{return null;}
            }
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: (){_onSubmit();},
              child: Text('Submit'),
              color: Color.fromARGB(43, 33, 100, 243),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  _list() => Container();

  _onSubmit(){
    var form = _formKey.currentState;
    if(form!.validate()){
      form.save();    
      print(_contact.name);
    }
  }
}
      
    