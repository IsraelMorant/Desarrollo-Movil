import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practica 6',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    );
     
  }
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  //int contador = 3;

 @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Inicial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

           

            const SizedBox(height: 10),

            Text(
              'Bienvenido',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=>
                         ventanaRegistro(),
                  ),
                   );
                
              
              
              }, 
              child: const Text('Registrar'),
              ),
          ],
        ),
      ),
    );
  }



}


class ventanaRegistro extends StatelessWidget {
 
   //Variables para guardas los datos del formulario
  String nombre = '';
  String matricula ='';
  String carrera = '';



final _formKey = GlobalKey<FormState>();
final nameController = TextEditingController();
final carController = TextEditingController();
final matController = TextEditingController();
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Principal'),
        centerTitle: true,
      ),

      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Ingrese su nombre';
                  }
                  //si no esta vacio se guarda
                  nombre = value;
                  return null;
                },
              ),
              TextFormField(
                controller: matController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],//Validacion de que lla matricula sea solo numerica
                decoration: InputDecoration(labelText: 'Matricula'),      //Para eso filtramos el texto de entradada para que solo acepte digitos
                validator: (value) {
                  if(value==null|| value.isEmpty){ //Validando que el campo no se encuentre vacio
                    return 'Ingrese su Matricula';
                  }
                    // Si no esta vacio y es numerioc entonces se guarda en el campo asginado
                  matricula = value;
                  return null;
                },
              ),

              TextFormField(
                controller: carController,
                decoration: InputDecoration(labelText: 'Carrera'),
                validator: (value) {
                  if(value == null || value.isEmpty){

                    return 'Ingrese su carrera';
                  }
                  //Si no esta vacio el campo entonces guardamos el valor
                  carrera = value;

                  
                  return null;
                },

              ),
             
             Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  //Validando los datos del formulario

                  

                  




                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Formulario registrado')),
                      
                  );
                  //Limmpiando los textfields
                  nameController.clear();
                  carController.clear();
                  matController.clear();
                 
                   Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=>
                         SegundaPantalla(nombre: nombre, matricula: matricula, carrera: carrera),
                  ),
                   );
                }
              }, 
              child: Text('Registrar')),


             ),
             
            ],
          ),

          
        ),
        
        ),
      
    );
    
  }

  
}


class SegundaPantalla extends StatelessWidget{
   final String nombre, matricula, carrera;

  

  const SegundaPantalla({super.key,  required this.nombre, required this.matricula, required this.carrera});

  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda Pantalla'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

           

            const SizedBox(height: 10),

            Text(
              'Alumno registrado',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),


            Text(
              'Nombre: $nombre ',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Matricula: $matricula ',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),


            Text(
              'Carrera: $carrera',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text('Regresar'),
              ),
          ],
        ),
      ),
    );
  }
}