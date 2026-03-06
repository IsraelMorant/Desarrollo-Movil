import 'package:flutter/material.dart';
import 'package:sqlite/alumno.dart';

//Iportnado la clase db
import 'package:sqlite/db.dart';


void main() {
  runApp(MyApp());
}

// Variables de los datos para guardar la información del usuario
class DatosRegistro {
  String nombre = "";
  String matricula = "";
  String carrera = "";
  String semestre = "---Seleccione opcion---";
  String modalidad = "Presencial";
  List<String> cursos = [];

  bool completo = false;
}

DatosRegistro miRegistro = DatosRegistro();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Registro',
      theme: ThemeData(primarySwatch: Colors.blue),
      //theme: ThemeData(colorSchemeSeed: const Color(0xff6750a4)),
      home: const PantallaInicio(),
    );
  }
}

// --- PANTALLA PRINCIPAL ---
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bienvenidos")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("¡Bienvenido al Sistema!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton( // funcion de los botones
              onPressed: () { // dependiendo de la seleccion del usuario
                if (miRegistro.completo) { // si quiere ver su registro nos manda a otra pantalla
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Listado ()));
                } else { // si aun no esta registado nos manda un mensaje a pantalla
                  ScaffoldMessenger.of(context).showSnackBar( //metodo para mensajes inferiores en pantalla
                    const SnackBar(content: Text("Aún no estás registrado")), //mensaje que aparecera en pantalla
                  );
                }
              },
              child: const Text("Ver Registro"),
            ),
            ElevatedButton( // si quiere un nuevo registro
              onPressed: () { // nos manda a la primera parte de los formularios
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistroParte1()));
              },
              child: const Text("Nuevo Registro"),
            ),
          ],
        ),
      ),
    );
  }
}

// primera parte del registro con las validaciones anteriormente implementadas
class RegistroParte1 extends StatefulWidget {
  const RegistroParte1({super.key});

  @override
  State<RegistroParte1> createState() => _RegistroParte1State();
}

class _RegistroParte1State extends State<RegistroParte1> {


  


  // Clave para el formulario
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nombre = TextEditingController();
  final TextEditingController matricula = TextEditingController();
  final TextEditingController carrera = TextEditingController();

  void _validarYSiguiente() { //validacion de los campos y despues nos dirige a la siguiente pagina
    // Solo avanza si todas las reglas del validator se cumplen
    if (_formKey.currentState!.validate()) {
      miRegistro.nombre = nombre.text;
      miRegistro.matricula = matricula.text;
      miRegistro.carrera = carrera.text;
      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistroParte2()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paso 1: Datos Básicos")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Asignamos la clave al Form
          child: ListView(
            children: [
              TextFormField(
                controller: nombre,
                decoration: const InputDecoration(labelText: "Nombre Completo"),
                //verifica que el campo este completo
                validator: (value) => value!.isEmpty ? 'Por favor ingresa tu nombre' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: matricula,
                decoration: const InputDecoration(labelText: "Matrícula"),
                keyboardType: TextInputType.number, //teclado numerico
                validator: (value) { //validacion del campo
                  //campo completo
                  if (value == null || value.isEmpty) return 'Campo obligatorio';
                  //campo solo numerico
                  if (int.tryParse(value) == null) return 'Debe contener solo números';
                  //numero de digitos aceptados
                  if (value.length != 10) return 'La matrícula debe tener 10 dígitos';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: carrera,
                decoration: const InputDecoration(labelText: "Carrera"),
                //campo completo
                validator: (value) => value!.isEmpty ? 'Por favor ingresa tu carrera' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _validarYSiguiente,
                child: const Text("Siguiente"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// segunda parte del registro
class RegistroParte2 extends StatefulWidget {
  const RegistroParte2({super.key});

  @override
  State<RegistroParte2> createState() => _RegistroParte2State();
}

class _RegistroParte2State extends State<RegistroParte2> {
  String selectedSemestre = "---Seleccione opcion---";
  String selectedMod = "Presencial";
  
  Map<String, bool> cursosMap = {"Salud mental": false, "Programacion en java": false, "Deportes": false, "Musica": false, "Educacion Ambinetal": false};

  @override
  Widget build(BuildContext context) {
   
    
    return Scaffold(
      appBar: AppBar(title: const Text("Paso 2: Selección de Talleres")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [ //muestra el nombre del usuario que se esta registrando
          Text("Usuario: ${miRegistro.nombre}", style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(),
          const Text("Selecciona tu semestre:"),
          DropdownButton<String>(
            value: selectedSemestre,
            isExpanded: true,
            //Despliegue de lista
            items: <String>['---Seleccione opcion---','1ro', '2do', '3ro', '4to', '5to', '6to', '7mo', '8vo', '9no', '10mo'].map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (val) => setState(() => selectedSemestre = val!),
          ),
          const SizedBox(height: 20),
          const Text("Modalidad:"),
          //seleccion unica de modalidad
          RadioListTile(title: const Text("Presencial"),
              value: "Presencial",
              groupValue: selectedMod,
              onChanged: (v) => setState(() => selectedMod = v!
              )),
          RadioListTile(title: const Text("En línea"), value: "En línea", groupValue: selectedMod, onChanged: (v) => setState(() => selectedMod = v!)),
          const SizedBox(height: 20),
          const Text("Cursos disponibles (Selección múltiple):"),
          ...cursosMap.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: cursosMap[key],
              onChanged: (bool? value) => setState(() => cursosMap[key] = value!),
            );
          }).toList(),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              miRegistro.semestre = selectedSemestre;
              miRegistro.modalidad = selectedMod;
              miRegistro.cursos = cursosMap.entries.where((e) => e.value).map((e) => e.key).toList();
              miRegistro.completo = true;
              // Navega al resumen y borra el historial para que no pueda volver atrás al registro
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  Listado()), (route) => false);

              //Insertando a la base de datos 
              DB.insert(Alumno(nombre: miRegistro.nombre,matricula: miRegistro.matricula,carrera:miRegistro.carrera,semestre: miRegistro.semestre,modalidad:miRegistro.modalidad,cursos:miRegistro.cursos));
            },
            child: const Text("Finalizar Registro"),
          )
        ],
      ),
    );
  }
}

// --- PANTALLA DE RESUMEN ---

class Listado extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animales"),
      ),
      
      body: Container(
        child: Lista()
      )
    );
  }
}


class Lista extends StatefulWidget {

  @override
  _MiLista createState() => _MiLista();

}

class _MiLista extends State<Lista> {

  List<Alumno> alumnos = [];

  @override
  void initState() {
    cargaAlumnos();
    super.initState();
  }

  cargaAlumnos() async {
    List<Alumno> auxAlumno = await DB.alumnos();

    setState(() {
      alumnos = auxAlumno;
    });

  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: alumnos.length,
        itemBuilder:
            (context, i) =>
          Dismissible(key: Key(i.toString()),
              direction: DismissDirection.startToEnd,
              background: Container (
                color: Colors.red,
                padding: EdgeInsets.only(left: 5),
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.delete, color: Colors.white)
              )
              ),
           
            child: ListTile(
              title: Text(alumnos[i].nombre),
              trailing: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context,"/editar",arguments: alumnos[i]);
                },
                child: Icon(Icons.edit)
              )
            )
          )
    );
  }

}