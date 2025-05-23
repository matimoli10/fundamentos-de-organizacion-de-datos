program ejercicio_3;
type 
  empleado = record 
    num_emp: integer;
    apellido: string; 
    nombre: string;
    edad: integer;
    dni: integer;
  end;
  archivo_empleado = file of empleado;
  
procedure ops_menu (var re: char);
  begin 
    writeln('elija una de las opciones para continuar');
    writeln(' a: crear un archivo ');
    writeln(' b: abrir un archivo ');
    readln(re);  //preguntar por que si no le pones el ln se rompe todo 
  end;
  
procedure ingresar_datos(var e: empleado);
  begin 
    writeln();
    writeln('ingrese el apellido de la persona');
    readln(e.apellido);
    if (e.apellido <> 'fin') then begin 
      writeln('ingrese el nombre de el empleado ');
      readln(e.nombre);
      writeln('ingrese el numero de empleado');
      readln(e.num_emp);
      writeln('ingrese la edad del empleado ');
      readln(e.edad);
      writeln('ingrese el dni de empleado');
      readln(e.dni);
    end;
  end;
  
procedure nuevo_archivo (var aEmpleado: archivo_empleado);
  var 
    nombre_a: string;
    e: empleado;
  begin 
    writeln('ingrese el nombre del archivo ');
    readln(nombre_a);
    assign (aEmpleado, nombre_a);
    rewrite(aEmpleado);
    ingresar_datos(e);
    while (e.apellido <> 'fin')do begin 
      write(aEmpleado,e);
      ingresar_datos(e);
    end;
    close(aEmpleado);
  end;
  
procedure imprimir_datos(e: empleado);
begin 
  writeln('el apellido del empleado es: ', e.apellido);
  writeln('el nombre del empleado es: ', e.nombre);
  writeln('el numero de empleado es: ', e.num_emp);
  writeln('la edad del empleado es: ', e.edad);
  writeln('el dni del empleado es: ', e.dni);
end;

procedure buscar(var aEmpleado: archivo_empleado);
var 
  bus: string;
  e: empleado;
begin 
  writeln('ingrese el apellido o el nombre que desea buscar ');
  readln(bus);
  while (not eof (aEmpleado))do begin 
    read(aEmpleado, e);
    if(e.apellido = bus) or (e.nombre = bus)then begin 
      writeln();
      imprimir_datos(e);
    end
  end;
  writeln();
end;

procedure listar(var aEmpleado: archivo_empleado);
var 
  e : empleado;
  act: integer;
begin
  act := 1;
  while(not eof(aEmpleado))do begin 
    read(aEmpleado,e);
    writeln();
    writeln(act);
    imprimir_datos(e);
    act := act +1;
  end;
  writeln();
end;

procedure mayores(var aEmpleado: archivo_empleado);
var 
  e: empleado;
  cant: integer;
begin
  cant:= 0;
  while(not eof(aEmpleado))do begin 
    read(aEmpleado, e);
    if(e.edad > 70 )then begin 
      imprimir_datos(e);
      cant := cant + 1;
    end;
  end;
  if(cant = 0)then begin 
    writeln('no se encontro ningun empleado mayor a 70 anos');
    writeln();
  end;
end;

procedure menu(var aEmpleado: archivo_empleado);
var 
  res: char;
begin 
  writeln('que accion desea realizar');
  writeln(' a: buscar por nombre o apellido');
  writeln(' b: listar los empleados ');
  writeln(' c: listar los empleados mayores a 70');
  readln(res);
  case res of
    'a': buscar (aEmpleado);
    'b': listar (aEmpleado);
    'c': mayores (aEmpleado);
  else 
    writeln('caracter no valido');
  end;
end;

procedure abrir_archivo(var aEmpleado: archivo_empleado);
var 
  nombre_a: string;
begin 
  writeln('ingrese el nombre del archivo que desea abrir ');
  readln(nombre_a);
  assign(aEmpleado,nombre_a);
  reset(aEmpleado);
  menu(aEmpleado);
  close(aEmpleado);
end;

var 
  aEmpleado: archivo_empleado;
  re: char;
  res: string [2];
begin 
  res := 'si';
  while(res = 'si')do begin 
    ops_menu(re);
    if(re = 'a')then begin 
      nuevo_archivo(aEmpleado);
    end
    else begin
      if(re = 'b')then begin 
        abrir_archivo(aEmpleado);
      end
      else begin 
        writeln('la opcion ingresada no es valida ');
      end;
    end;
    writeln('desea realizar algo mas ?');
    readln(res);
  end;
  writeln('fin del programa ');
end.
