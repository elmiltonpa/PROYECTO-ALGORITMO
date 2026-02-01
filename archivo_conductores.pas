unit archivo_conductores;

{$codepage UTF8}

INTERFACE   

USES
    crt,arboles, sysutils,def_archivo_conductores, confirmacion,funciones_arboles,listas, manejo_fechas;

procedure alta_conductor(var archivo_conductores:t_archivo_conductores; var arbol_dni,arbol_apynom:T_punt);
procedure pasar_conductores(var archivo_conductores:t_archivo_conductores; var arbol_dni,arbol_apynom:T_punt);
procedure habilitar_conductores(var archivo_conductores:t_archivo_conductores);

IMPLEMENTATION

procedure pasar_conductores(var archivo_conductores:t_archivo_conductores; var arbol_dni,arbol_apynom:T_punt);

var
    x_conductor:t_dato_conductor;
    x_arbol:t_dato_arbol;
    pos:cardinal;
begin
    abrir_archivo_conductores(archivo_conductores);
    pos:=0;
    while not eof(archivo_conductores) do
        begin
            seek(archivo_conductores,pos);
            read(archivo_conductores,x_conductor);
            x_arbol.clave:=x_conductor.dni;
            x_arbol.posicion:=pos;
            agregar(arbol_dni,x_arbol);
            x_arbol.clave:=(x_conductor.nombre) + (x_conductor.apellido);
            agregar(arbol_apynom,x_arbol);
            pos:=pos+1;
        end;
    close(archivo_conductores);
end;

procedure inicializar_datos(var x:t_dato_conductor);
begin
    x.dni:='';
    x.nombre:='';
    x.apellido:='';
    x.fecha_nacimiento.dia:='';
    x.fecha_nacimiento.mes:='';
    x.fecha_nacimiento.anio:='';
    x.telefono:='';
    x.email:='';
    x.scoring:=20;
    x.habilitado:=true;
    x.fecha_habilitacion.dia:='';
    x.fecha_habilitacion.mes:='';
    x.fecha_habilitacion.anio:='';
    x.cantidad_reincidencias:=0;
end;

procedure mostrar_datos_conductor(x_conductor:t_dato_conductor;var x,y:integer);

begin
    gotoxy(x,y);
    writeln('DNI: ',x_conductor.dni);
    gotoxy(x,y+1);
    writeln('Nombre y apellido: ',x_conductor.nombre,' ',x_conductor.apellido);
    gotoxy(x,y+2);
    writeln('Fecha de nacimiento: ',x_conductor.fecha_nacimiento.dia,'/',x_conductor.fecha_nacimiento.mes,'/',x_conductor.fecha_nacimiento.anio);
    gotoxy(x,y+3);
    writeln('Telefono: ',x_conductor.telefono);
    gotoxy(x,y+4);
    writeln('Email: ',x_conductor.email);
    gotoxy(x,y+5);
    writeln('Scoring: ',x_conductor.scoring);
    gotoxy(x,y+6);
    writeln('Habilitado: ',x_conductor.habilitado);
    gotoxy(x,y+7);
    writeln('Fecha de habilitacion: ',x_conductor.fecha_habilitacion.dia,'/',x_conductor.fecha_habilitacion.mes,'/',x_conductor.fecha_habilitacion.anio);
    gotoxy(x,y+8);
    writeln('Cantidad de reincidencias: ',x_conductor.cantidad_reincidencias);
    y:=y+9;
end;

procedure ingresar_datos_conductor(var x_conductor:t_dato_conductor);
var
    x,y:integer;
    fecha_actual:TFecha;
begin
    x:=5;
    y:=5;
    inicializar_datos(x_conductor);
    fecha_hoy(fecha_actual);
    x_conductor.fecha_habilitacion.dia:=fecha_actual.dia;
    x_conductor.fecha_habilitacion.mes:=fecha_actual.mes;
    x_conductor.fecha_habilitacion.anio:=fecha_actual.anio;
    clrscr;
    gotoxy(x,y);
    writeln('Ingrese el primer nombre del conductor');
    gotoxy(x,y+1);
    readln(x_conductor.nombre);
    y:=y+1;
    confirmacion_nombre(x_conductor.nombre,x,y);
    x_conductor.nombre:=lowercase(x_conductor.nombre);
    gotoxy(x,y+1);
    writeln('Ingrese el primer apellido del conductor');
    gotoxy(x,y+2);
    readln(x_conductor.apellido);
    y:=y+3;
    confirmacion_apellido(x_conductor.apellido,x,y);
    x_conductor.apellido:=lowercase(x_conductor.apellido);
    gotoxy(x,y+1);
    writeln('Ingrese la fecha de nacimiento del conductor');
    gotoxy(x,y+2);
    writeln('Dia: ');
    gotoxy(x+5,y+2);
    readln(x_conductor.fecha_nacimiento.dia);
    y:=y+3;
    confirmacion_dias(x_conductor.fecha_nacimiento.dia,x,y);
    gotoxy(x,y+1);
    writeln('Mes: ');
    gotoxy(x+5,y+1);
    readln(x_conductor.fecha_nacimiento.mes);
    y:=y+2;
    confirmacion_mes(x_conductor.fecha_nacimiento.mes,x,y);
    gotoxy(x,y+1);
    writeln('Año: ');
    gotoxy(x+5,y+1);
    readln(x_conductor.fecha_nacimiento.anio);
    y:=y+2;
    confirmacion_fecha_conductor(x_conductor.fecha_nacimiento,x,y);
    y:=y+1;
    if(lowercase(x_conductor.fecha_nacimiento.anio) <> 'n') then
        begin
            gotoxy(x,y+1);
            writeln('Ingrese el telefono del conductor');
            gotoxy(x,y+2);
            readln(x_conductor.telefono);
            gotoxy(x,y+3);
            writeln('Ingrese el email del conductor');
            gotoxy(x,y+4);
            readln(x_conductor.email);
            y:=y+4;
            confirmacion_email(x_conductor.email,x,y);
        end;


end;
procedure menu_modificar(var opcion:char; var x_conductor:t_dato_conductor; var arbol_apynom:t_punt;posicion:cardinal);
var
    aux_conductor:t_dato_conductor;
    aux_dato_arbol:t_dato_arbol;
    nombre_arbol:string;
    x,y:integer;
    opcion1:char;
begin
    repeat
        clrscr;
        x:=5;
        y:=5;
        aux_conductor:=x_conductor;
        mostrar_datos_conductor(x_conductor,x,y);
        gotoxy(5,y+1);
        Writeln ('¿Que dato desea modificar?');
        gotoxy(5,y+2);
        writeln ('1- Nombre y Apellido');
        gotoxy(5,y+3);
        writeln ('2- Fecha de Nacimiento');
        gotoxy(5,y+4);
        writeln ('3- Telefono');
        gotoxy(5,y+5);
        writeln ('4- Email');
        gotoxy(5,y+6);
        writeln ('0- Volver');
        gotoxy(5,y+7);
        writeln ('Selecione opción: ');
        gotoxy(23,y+7);
        readln(opcion);
        y:=y+8;
        confirmacion_5_opciones(opcion,5,y);
        clrscr;
        y:=5;
        x:=5;
        case opcion of
            '1':begin
                    mostrar_datos_conductor(x_conductor,x,y);
                    gotoxy(x,y+1);
                    writeln('Ingrese el nuevo nombre del conductor');
                    gotoxy(x,y+2);
                    readln(aux_conductor.nombre);
                    y:=y+3;
                    confirmacion_nombre(aux_conductor.nombre,x,y);
                    aux_conductor.nombre:=lowercase(aux_conductor.nombre);
                    gotoxy(x,y+1);
                    writeln('Ingrese el nuevo apellido del conductor');
                    gotoxy(x,y+2);
                    readln(aux_conductor.apellido);
                    y:=y+3;
                    confirmacion_apellido(aux_conductor.apellido,x,y);  
                    nombre_arbol:=lowercase(x_conductor.nombre) + lowercase(x_conductor.apellido);
                    eliminar_nodo(arbol_apynom,nombre_arbol,posicion);
                    aux_dato_arbol.clave:=lowercase(aux_conductor.nombre) + lowercase(aux_conductor.apellido);
                    aux_dato_arbol.posicion:=posicion;
                    agregar(arbol_apynom,aux_dato_arbol);
                end;
            '2':begin
                    repeat
                    clrscr;
                    y:=5;
                    mostrar_datos_conductor(x_conductor,x,y);
                    gotoxy(x,y+1);
                    writeln('Ingrese la nueva fecha de nacimiento del conductor');
                    gotoxy(x,y+2);
                    writeln('Dia: ');
                    gotoxy(65,y+2);
                    readln(aux_conductor.fecha_nacimiento.dia);
                    y:=y+3;
                    confirmacion_dias(aux_conductor.fecha_nacimiento.dia,x,y);
                    gotoxy(x,y+1);
                    writeln('Mes: ');
                    gotoxy(65,y+1);
                    readln(aux_conductor.fecha_nacimiento.mes);
                    y:=y+2;
                    confirmacion_mes(aux_conductor.fecha_nacimiento.mes,x,y);
                    gotoxy(x,y+1);
                    writeln('Año: ');
                    gotoxy(65,y+1);
                    readln(aux_conductor.fecha_nacimiento.anio);
                    opcion1:='1';
                    if (lowercase(aux_conductor.fecha_nacimiento.anio) <> 'n') then
                        begin
                            y:=y+2;
                            confirmacion_fecha_conductor2(aux_conductor.fecha_nacimiento,x,y);
                            if (lowercase(aux_conductor.fecha_nacimiento.anio) = 'n') then
                                begin
                                    opcion:='0';
                                end
                            else
                                if (lowercase(aux_conductor.fecha_nacimiento.anio) <> 's') then
                                    begin
                                        opcion1:='0';
                                    end;
                        end
                    else
                        begin
                            opcion:='0';
                        end;
                    until (opcion = '0') or (opcion1 = '0');
                end;
            '3':begin
                    mostrar_datos_conductor(x_conductor,x,y);
                    gotoxy(x,y+1);
                    writeln('Ingrese el nuevo telefono del conductor');
                    gotoxy(x,y+2);
                    readln(aux_conductor.telefono);
                    y:=y+3;
                    confirmacion_telefono(aux_conductor.telefono,x,y);
                    if (lowercase(aux_conductor.telefono) = 'n') then
                        begin
                            opcion:='0'
                        end;
                end;
            '4':begin
                    mostrar_datos_conductor(x_conductor,x,y);
                    gotoxy(x,y+1);
                    writeln('Ingrese el nuevo email del conductor');
                    gotoxy(x,y+2);
                    readln(aux_conductor.email);
                    y:=y+3;
                    confirmacion_email(aux_conductor.email,x,y);
                end;
            end;
        

        if opcion <> '0' then
            begin
                clrscr;
                x:=60;
                y:=5;
                mostrar_datos_conductor(aux_conductor,x,y);
                gotoxy(60,y+2);
                writeln('Confirma la modificacion? s/n');
                gotoxy(60,y+3);
                readln(opcion);
                y:=y+4;
                confirmacion_sn(opcion,x,y);
                clrscr;
                if (lowercase(opcion) = 's') then
                    begin
                        x_conductor:=aux_conductor;
                        gotoxy(60,5);
                        writeln('Modificacion realizada con exito');
                    end
                else
                    begin
                        gotoxy(60,5);
                        writeln('Modificacion cancelada');
                    end;
                gotoxy(60,7);
                writeln('Presione enter para continuar');
                gotoxy(60,8);
                readkey;
            end;
        clrscr;
        x:=60;
        y:=5;
        mostrar_datos_conductor(x_conductor,x,y);
        gotoxy(60,y+1);    
        writeln('Desea modificar otro dato? s/n');
        gotoxy(60,y+2);
        readln(opcion);
        y:=y+3;
        confirmacion_sn(opcion,x,y);
        until (opcion = '0') or (lowercase(opcion) = 'n');
end;



procedure modificar_conductor(var archivo_conductores:t_archivo_conductores;pos:cardinal ;var arbol_apynom,arbol_dni:t_punt; var x_conductor:t_dato_conductor);
var 
    opcion:char;
    x,y:integer;

begin
    x:=60;
    y:=5;
    mostrar_datos_conductor(x_conductor,x,y);
    gotoxy(60,y+1);
    writeln('¿Desea modificar algun dato? s/n');
    gotoxy(60,y+2);
    readln(opcion);
    y:=y+3;
    confirmacion_sn(opcion,x,y);
    if (lowercase(opcion) = 's') then
        begin
            menu_modificar(opcion,x_conductor,arbol_apynom,pos);
            abrir_archivo_conductores(archivo_conductores);
            seek(archivo_conductores,pos);
            write(archivo_conductores,x_conductor);
            close(archivo_conductores);
        end;
  
end;


procedure baja_conductor(var archivo_conductores:t_archivo_conductores;pos:cardinal;var x_conductor:t_dato_conductor);
    var
        fecha_actual:TFecha;
        opcion:char;
        x,y:integer;

    begin
        abrir_archivo_conductores(archivo_conductores);
        seek(archivo_conductores,pos);
        read(archivo_conductores,x_conductor);
        if (x_conductor.habilitado) then
            begin
                clrscr;
                x:=5;
                y:=7;
                gotoxy(5,5);
                writeln('Desea deshabilitar al conductor? s/n');
                gotoxy(5,6);
                readln(opcion);
                confirmacion_sn(opcion,x,y);
                if (lowercase(opcion) = 's') then
                    begin
                        fecha_hoy(fecha_actual);
                        x_conductor.habilitado:=false;
                        x_conductor.scoring := 0;
                        calcular_fecha_habilitacion(fecha_actual,x_conductor.cantidad_reincidencias); 
                        x_conductor.fecha_habilitacion:=fecha_actual;
                        x_conductor.cantidad_reincidencias:=x_conductor.cantidad_reincidencias + 1;
                        seek(archivo_conductores,pos);
                        write(archivo_conductores,x_conductor);
                        clrscr;
                        gotoxy(50,5);
                        writeln('Conductor deshabilitado con exito');
                        gotoxy(50,7);
                        write('La nueva fecha de habilitacion es: ');
                        textcolor(LightRed);
                        writeln(x_conductor.fecha_habilitacion.dia,'/',x_conductor.fecha_habilitacion.mes,'/',x_conductor.fecha_habilitacion.anio);
                        textcolor(white);
                        gotoxy(50,9);
                        writeln('Presione enter para continuar');
                        gotoxy(50,10);
                        readkey;
                    end;
            end
        else
            begin
                clrscr;
                gotoxy(50,5);
                writeln('El conductor ya esta deshabilitado');
                gotoxy(50,7);
                write('La fecha de habilitacion de este condcutor es: ');
                textcolor(LightRed);
                writeln(x_conductor.fecha_habilitacion.dia,'/',x_conductor.fecha_habilitacion.mes,'/',x_conductor.fecha_habilitacion.anio);
                textcolor(white);
                gotoxy(50,9);
                writeln('Presione enter para continuar');
                gotoxy(50,10);
                readkey;
            end;
        close(archivo_conductores);
    end;

procedure menu_cargar_conductor(var x_conductor:t_dato_conductor;var archivo_conductores:t_archivo_conductores;
                                 var arbol_dni,arbol_apynom,pos:T_punt;pos2:cardinal;var opcion2:char); 
var
    opcion:char;
    x,y:integer;

begin
    repeat
        clrscr;
        x:=5;
        y:=5;
        mostrar_datos_conductor(x_conductor,x,y);
        gotoxy(5,15);
        textcolor(LightRed);
        writeln('¿Que desea hacer?');
        textcolor(white);
        gotoxy(5,17);
        writeln('1. Modificar este conductor');
        gotoxy(5,18);
        writeln('2. Dar de baja este conductor');
        gotoxy(5,19);
        writeln('0. Volver al menu principal');
        gotoxy(5,21);
        writeln('Seleccione opcion: ');
        gotoxy(24,21);
        readln(opcion);
        confirmacion_5_opciones(opcion,5,22);
        clrscr;
        case opcion of
            '1': modificar_conductor(archivo_conductores,pos2,arbol_apynom,arbol_dni,x_conductor);
            '2': baja_conductor(archivo_conductores,pos2,x_conductor);

            '0': begin
                    opcion:='0';
                    opcion2:='n';
                 end;
        end;
    until opcion = '0' ;
                             
end;

procedure alta_conductor(var archivo_conductores:t_archivo_conductores; var arbol_dni,arbol_apynom:T_punt);

var
    opcion:char;
    x_conductor:t_dato_conductor;
    x_arbol:t_dato_arbol;
    pos:t_punt;
    dni:string;
    x,y:integer;
    pos2:cardinal;

begin
    opcion:='s';
    while (lowercase(opcion) = 's') do
                begin
                    clrscr;
                    x:=60;
                    y:=5;
                    gotoxy(x,y);
                    writeln('Ingrese el DNI del conductor o presione "n" para volver');
                    gotoxy(x,y+1);
                    readln(dni);
                    y:=y+1;
                    x:=x-10;
                    confirmacion_dni(dni,x,y);
                    x:=x+10;
                    if lowercase(dni) <> 'n' then
                        begin
                            pos:=preorden(arbol_dni,dni);
                            if (pos = nil) then
                                begin
                                    clrscr;
                                    gotoxy(50,5);
                                    writeln('El conductor no esta dado de alta, desea cargarlo? s/n');
                                    gotoxy(50,6);
                                    readln(opcion);
                                    confirmacion_sn(opcion,x,y);
                                    if (lowercase(opcion) = 's') then
                                        begin
                                            ingresar_datos_conductor(x_conductor);
                                            if (lowercase(x_conductor.fecha_nacimiento.anio) <> 'n') then
                                                    begin
                                                        clrscr;
                                                        abrir_archivo_conductores(archivo_conductores);
                                                        x_conductor.dni:=dni;
                                                        x_arbol.clave:=x_conductor.dni;
                                                        x_arbol.posicion:=filesize(archivo_conductores);
                                                        seek(archivo_conductores,filesize(archivo_conductores));
                                                        write(archivo_conductores,x_conductor);
                                                        agregar(arbol_dni,x_arbol);
                                                        x_arbol.clave := lowercase(x_conductor.nombre) + lowercase(x_conductor.apellido);
                                                        agregar(arbol_apynom,x_arbol);
                                                        gotoxy(60,5);
                                                        writeln('Conductor dado de alta con exito');
                                                        gotoxy(60,7);
                                                        writeln('Presione enter para continuar');
                                                        gotoxy(60,8);
                                                        readkey;
                                                        pos2:=filesize(archivo_conductores)-1;
                                                        close(archivo_conductores);
                                                        menu_cargar_conductor(x_conductor,archivo_conductores,arbol_dni,arbol_apynom,pos,pos2,opcion); 
                                                    end
                                                else
                                                    opcion:='n';

                                        end
                                    else
                                        begin
                                            clrscr;
                                            gotoxy(60,5);
                                            writeln('Desea ingresar otro DNI? s/n');
                                            gotoxy(60,6);
                                            readln(opcion);
                                            y:=6;
                                            confirmacion_sn(opcion,x,y);
                                        end;
                                end
                            else
                                begin
                                    abrir_archivo_conductores(archivo_conductores);
                                    seek(archivo_conductores,pos^.info.posicion);
                                    read(archivo_conductores,x_conductor);
                                    close(archivo_conductores);
                                    menu_cargar_conductor(x_conductor,archivo_conductores,arbol_dni,arbol_apynom,pos,pos^.info.posicion,opcion);                   
                                end;
                        end
                    else
                        opcion:='n';
                end;
end;

procedure habilitar_conductores(var archivo_conductores:t_archivo_conductores);
    var
        fecha_actual:TFecha;
        x_conductor:t_dato_conductor;

    begin
        fecha_actual.dia:='';
        fecha_actual.mes:='';
        fecha_actual.anio:='';
        abrir_archivo_conductores(archivo_conductores);
        fecha_hoy(fecha_actual);
        while not (EOF(archivo_conductores)) do
            begin
                read(archivo_conductores,x_conductor);
                if (fechas_iguales(x_conductor.fecha_habilitacion,fecha_actual)) and (x_conductor.cantidad_reincidencias < 6) and (not (x_conductor.habilitado)) then
                    begin
                        x_conductor.habilitado:=true;
                        x_conductor.scoring:=20;
                        seek(archivo_conductores,filepos(archivo_conductores)-1);
                        write(archivo_conductores,x_conductor);
                    end;
                
            end;
        close(archivo_conductores);
    end;


END.