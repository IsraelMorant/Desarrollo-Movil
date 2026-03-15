import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqlite/dispositivo.dart';
import 'package:sqlite/db.dart';
import 'Listado.dart';

class VentanaRegistro extends StatefulWidget {
  final Dispositivo? dispositivo; 

  const VentanaRegistro({super.key, this.dispositivo});

  @override
  State<VentanaRegistro> createState() => _VentanaRegistroState();
}

class _VentanaRegistroState extends State<VentanaRegistro> {
  final _formKey = GlobalKey<FormState>();
  
  
  final clienteCtrl = TextEditingController();
  final marcaCtrl = TextEditingController();
  final modeloCtrl = TextEditingController();
  final serieCtrl = TextEditingController();
  final fallaCtrl = TextEditingController();
  final fechaCtrl = TextEditingController();

  String tipoSeleccionado = "Celular";
  final List<String> tiposList = ["Celular", "Laptop", "Tablet", "Consola", "Otro"];

  @override
  void initState() {
    super.initState();
    // Si se recibe un dispositivo se llenan los campos para actulaizr lod datos del dispositovs
    if (widget.dispositivo != null) {
      clienteCtrl.text = widget.dispositivo!.cliente;
      tipoSeleccionado = widget.dispositivo!.tipo;
      marcaCtrl.text = widget.dispositivo!.marca;
      modeloCtrl.text = widget.dispositivo!.modelo;
      serieCtrl.text = widget.dispositivo!.serie;
      fallaCtrl.text = widget.dispositivo!.falla;
      fechaCtrl.text = widget.dispositivo!.fecha;
    } else {
      // Fecha de hoy si es registro nuevo
      fechaCtrl.text = DateTime.now().toString().split(' ')[0];
    }
  }


  String? validarVacio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  void guardarRegistro() async {
    if (_formKey.currentState!.validate()) {
      //bandera pra saber si existe ese numero de serie
      bool existe = await DB.checkSerieExists(serieCtrl.text, currentId: widget.dispositivo?.id);
      
      if (existe) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: El número de serie ya está registrado.')),
        );
        return;
      }

      Dispositivo nuevoDispositivo = Dispositivo(
        id: widget.dispositivo?.id,
        cliente: clienteCtrl.text,
        tipo: tipoSeleccionado,
        marca: marcaCtrl.text,
        modelo: modeloCtrl.text,
        serie: serieCtrl.text,
        falla: fallaCtrl.text,
        fecha: fechaCtrl.text,
      );

      if (widget.dispositivo == null) {
        await DB.insert(nuevoDispositivo);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dispositivo registrado')));
      } else {
        await DB.update(nuevoDispositivo);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dispositivo actualizado')));
      }

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Listado()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dispositivo == null ? 'Registrar Dispositivo' : 'Editar Dispositivo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: clienteCtrl,
                decoration: const InputDecoration(labelText: 'Nombre del Cliente'),
                validator: validarVacio,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: tipoSeleccionado,
                decoration: const InputDecoration(labelText: 'Tipo de Dispositivo'),
                items: tiposList.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    tipoSeleccionado = value!;
                  });
                },
              ),
              TextFormField(
                controller: marcaCtrl,
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: validarVacio,
              ),
              TextFormField(
                controller: modeloCtrl,
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: validarVacio,
              ),
              TextFormField(
                controller: serieCtrl,
                // numeros y solo 10 dígitos
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(labelText: 'Número de Serie (Max 10 dígitos)'),
                validator: validarVacio,
              ),
              TextFormField(
                controller: fallaCtrl,
                decoration: const InputDecoration(labelText: 'Descripción de la Falla'),
                maxLines: 2,
                validator: validarVacio,
              ),
              TextFormField(
                controller: fechaCtrl,
                decoration: const InputDecoration(labelText: 'Fecha de Ingreso (YYYY-MM-DD)'),
                validator: validarVacio,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: guardarRegistro,
                child: Text(widget.dispositivo == null ? 'Registrar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}