import 'package:flutter/material.dart';
import 'package:sqlite/dispositivo.dart';
import 'package:sqlite/db.dart';
import 'VentanaRegistro.dart';

class Listado extends StatelessWidget {
  const Listado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado de Dispositivos"),
      ),
      body: const Lista(),
    );
  }
}

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  _MiLista createState() => _MiLista();
}

class _MiLista extends State<Lista> {
  List<Dispositivo> dispositivos = [];

  @override
  void initState() {
    super.initState();
    cargarDispositivos();
  }

  Future<void> cargarDispositivos() async {
    List<Dispositivo> aux = await DB.dispositivos();
    setState(() {
      dispositivos = aux;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dispositivos.isEmpty) {
      return const Center(child: Text("No hay dispositivos registrados."));
    }

    return ListView.builder(
      itemCount: dispositivos.length,
      itemBuilder: (context, i) {
        final disp = dispositivos[i];
        return Dismissible(//Es el wifget que sirve para eliminar, funciona que en lugar de un boton, de eliminar, diexlias el registro ala derecha
          key: Key(disp.id.toString()),
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Colors.red,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) async {
            await DB.delete(disp.id!); // Elimina el registro de la base dedatos
            setState(() {
              dispositivos.removeAt(i);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registro eliminado correctamente')),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text("Cliente: ${disp.cliente} \nDispositivo: ${disp.tipo} ${disp.marca}"),
              subtitle: Text("Modelo: ${disp.modelo} | Serie: ${disp.serie}\nFalla: ${disp.falla}"),
              isThreeLine: true,
              trailing: const Icon(Icons.edit, color: Colors.blue),
              onTap: () {
                // envia el dispositivo a la ventana de registro para actualizar
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => VentanaRegistro(dispositivo: disp)),
                );
              },
            ),
          ),
        );
      },
    );
  }
}