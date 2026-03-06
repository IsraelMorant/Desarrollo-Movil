
class Alumno {

  int? id;
  String nombre;
  String matricula;
  String carrera;
  String semestre;
  String modalidad;
  String curso;
  String beca;
  Alumno({this.id, required this.nombre, required this.matricula,required this.carrera,required this.semestre, required this.modalidad,required this.curso, required this.beca});

  Map<String, dynamic> toMap() {
    return { 'id': id, 
    'nombre': nombre, 
    'matricula': matricula,
    'carrera': carrera,
    'semestre': semestre,
    'modalidad': modalidad,
    'curso': curso,
    'beca': beca,

    
    
    };
  }
}