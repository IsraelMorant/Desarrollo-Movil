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
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int contador = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Inicial')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            Text(
              'Bienvenido',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   VentanaRegistro()),
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



class VentanaRegistro extends StatefulWidget {
  const VentanaRegistro({super.key});

  @override
  State<VentanaRegistro> createState() => _VentanaRegistro();
}

class _VentanaRegistro extends State<VentanaRegistro> {
  //Variables para guardas los datos del formulario
  String nombre = '';
  String matricula = '';
  //String carrera = '';

  String semestre='1°';

  String carrera= "Ingeneria en Ciencias de la Computacion";

  String taller="Simulacion";

  String modalidad="Linea";


   bool beca=false;

  final List<String> semestreList = [
    "1°",
    "2°",
    "3°",
    "4°",
    "5°",
    "6°",
    "7°",
    "8°",
    "9°",
    "10°",
  ];

  final List<String> tallerList = [
    "Simulacion",
    "Datos",
    "IA",
    "Robotica"
  ];

    final List<String> carreraList = [
    "Ingeneria en Ciencias de la Computacion",
    "Licenciatura en Ciencias de la Computacion",
    "Licenciatura en Tecnologias de la Informacion"
  ];


  final List<String> modalidadList = [
    "Linea",
    "Presencial",
    "Mixto"
  ];


  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final carController = TextEditingController();
  final matController = TextEditingController();

 
  @override
  Widget build(BuildContext context) {
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
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su nombre';
                  }
                  //si no esta vacio se guarda
                  nombre = value;
                  return null;
                },
              ),
              TextFormField(
                controller: matController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ], //Validacion de que lla matricula sea solo numerica
                decoration: InputDecoration(
                  labelText: 'Matricula',
                ), //Para eso filtramos el texto de entradada para que solo acepte digitos
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    //Validando que el campo no se encuentre vacio
                    return 'Ingrese su Matricula';
                  }
                  // Si no esta vacio y es numerioc entonces se guarda en el campo asginado
                  matricula = value;
                  return null;
                },
              ),

/*

                 DropdownButtonFormField<String>(
                
                hint: Text('Selecciona una opcion'),
                onChanged: (value) {
                  carrera = value;
                },
                validator: (value) {
                  if (value == null) {
                    return 'Porfavor Seleccione una Opcion';
                  }
                  return null;
                },
                items: carreraList.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),



                DropdownButtonFormField<String>(
                initialValue: modalidad,
                hint: Text('Selecciona una opcion'),
                onChanged: (value) {
                  modalidad = value;
                },
                validator: (value) {
                  if (value == null) {
                    return 'Porfavor Seleccione una Opcion';
                  }
                  return null;
                },
                items: modalidadList.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),




           
              DropdownButtonFormField<String>(
                initialValue: semestre,
                hint: Text('Selecciona una opcion'),
                onChanged: (value) {
                  semestre = value;
                },
                validator: (value) {
                  if (value == null) {
                    return 'Porfavor Seleccione una Opcion';
                  }
                  return null;
                },
                items: semestreList.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              DropdownButtonFormField<String>(
                initialValue: taller,
                hint: Text('Selecciona una Opcion'),
                onChanged: (value) {
                  taller = value;
                },
                validator: (value) {
                  if (value == null) {
                    return 'Porfavor Seleccione una Opcion';
                  }
                  return null;
                },
                items: tallerList.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),


*/


        DropdownButton<String>(
          // Initial Value
          value:semestre,

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items:
              semestreList.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged:(value) {
            setState(() {
              semestre = value!;
            });
            
          },
          
        ),




  DropdownButton(
          // Initial Value
          value:carrera,

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items:
              carreraList.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged:(value) {
           setState(() {
              carrera = value!;
            });
          },
        ),


  DropdownButton(
          // Initial Value
          value:modalidad,

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items:
              modalidadList.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged:(value) {
           setState(() {
              modalidad = value!;
            });
          },
        ),






        DropdownButton(
          // Initial Value
          value: taller,

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items:
              tallerList.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
           onChanged:(value) {
            setState(() {
              taller = value!;
            });
          },
          
            
            
            
            
            ),



   Text(
              '¿Necesitas beca?',
              style: const TextStyle(fontSize: 15, ),
            ),
              Checkbox(
                value: beca,
                activeColor: Colors.amber,
                 onChanged:(value) {
                setState(() {
              beca = value!;
                });
          },
                
                
                ),



              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
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
                          builder: (context) => SegundaPantalla(
                            nombre: nombre,
                            matricula: matricula,
                            carrera: carrera,
                            beca:beca,
                            taller:taller,
                            semestre:semestre,
                            modalidad:modalidad
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Registrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}










class SegundaPantalla extends StatelessWidget {
  final String nombre, matricula;
  final String? carrera,taller,semestre,modalidad;
  final bool beca;


  const SegundaPantalla({
    super.key,
    required this.nombre,
    required this.matricula,
    required this.carrera,
    required this.taller,
    required this.semestre,
    required this.modalidad,
    required this.beca,
    
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumen de Registro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            Text(
              'Taller registrado',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text(
              'Nombre: $nombre ',
              style: const TextStyle(fontSize: 15),
            ),

            Text(
              'Matricula: $matricula ',
              style: const TextStyle(fontSize: 15),
            ),

            Text(
              'Carrera: $carrera',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),



             Text(
              'Semestre: $semestre',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),


             Text(
              'Taller: $taller',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),


             Text(
              'Modalidad: $modalidad',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            

            


           Container(child: () {
      if (beca == true) {
        return Text('Se solicita beca');
      }
      return Text('NO se solicita beca');
    }()),


            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
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
