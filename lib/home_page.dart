import 'package:crud_sqlite/db/database_helper.dart';
import 'package:crud_sqlite/models/contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final Contact _contact = Contact(id: '',name: '',phoneNumber:'');
  List<Contact> _contacts = [];
  DatabaseHelper? _dbHelper;

  @override
  void initState(){
    super.initState();
    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });
    _refreshContactList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Titulo',
            style: TextStyle(color: Color.fromARGB(43, 33, 100, 243),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _form(),  
            _list(),
          ],         
        ),
      ), 
      backgroundColor: Colors.grey[300],     
    );
  }

  _form() => Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Full Name'),
            onSaved: (value) => setState(() => _contact.name = value ?? ''),
            validator: (value){
              if(value!.trim().isEmpty){return 'This field is required';}
              if(value.trim().length < 3){ return 'Minimum 3 characters';}
              else {return null;}
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Phone Number'),
            onSaved: (value) => setState(() => _contact.phoneNumber = value ?? ''),
            validator:(value){
              if(value!.trim().isEmpty){return 'This field is required';}
              if(value.trim().length != 11){return 'This field must contain 11 numbers';}
              else{return null;}
            }
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: (){_onSubmit();},
              child: const Text('Submit'),
              color: const Color.fromARGB(43, 5, 9, 231),
              textColor: Colors.white,
            ),
          ),          
        ],
      ),
    ),
  );

  _list() => Expanded(    
    child: Card(      
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: ListView.builder(        
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index){
          return Column(            
            children: [              
              ListTile(                
                leading:const Icon(
                  Icons.account_circle,
                  color: Color.fromARGB(43, 5, 9, 231),
                  size: 40.0),
                title: Text(_contacts[index].name.toUpperCase(),
                style: const TextStyle(
                  color: Color.fromARGB(43, 5, 9, 231), 
                  fontWeight: FontWeight.bold),
                ), 
                subtitle: Text(_contacts[index].phoneNumber,
                  style: const TextStyle(
                    color: Color.fromARGB(43, 5, 9, 231), 
                  ),
                ), 
              ),
              const Divider(height: 5.0,)
            ],  
          ); 
        },
        itemCount: _contacts.length,
      ),
    ),
  );

  _onSubmit() async {
    var form = _formKey.currentState;
    _contact.id = null;
    if(form!.validate()){      
      form.save();    
      await _dbHelper?.put(_contact);
      form.reset();
      print(_contact.name);
    }
  }

  _refreshContactList() async{
    List<Contact> listContacts = await _dbHelper!.fetchContacts();
    setState((){
      _contacts = listContacts;
    });
  }
}
      
    