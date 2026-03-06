import 'dart:core';

import 'package:sqlite/alumno.dart';
import 'package:sqlite/db.dart';
import 'package:flutter/material.dart';

class Listado extends StatelessWidget {
  const Listado({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro"),
      ),
      
      body: Container(
        child: Lista()
      )
    );
  }
}

class Lista extends StatefulWidget {
  const Lista({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _MiLista createState() => _MiLista();

}

class _MiLista extends State<Lista> {

  List<Alumno> alumnos = [];

  @override
  void initState() {
    cargarAlumnos();
    super.initState();
  }

  Future<void> cargarAlumnos() async {
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
              title: Text("Nombre:${alumnos[i].nombre} Matricula:${alumnos[i].matricula} Carrera:${alumnos[i].carrera} Semestre:${alumnos[i].semestre} Modalidad:${alumnos[i].modalidad} Curso:${alumnos[i].curso} Beca:${alumnos[i].beca}"),
              
              
            )
          )
    );
  }

}