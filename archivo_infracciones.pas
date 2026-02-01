Unit archivo_infracciones;

{$codepage UTF8}

INTERFACE

USES
    crt,manejo_fechas,funciones_varias,def_archivo_infracciones,def_archivo_conductores,arboles,funciones_arboles,confirmacion,sysutils,listas,estructura_listados,tipos_infraccion;

procedure alta_infraccion(var archivo_infracciones:t_archivo_infracciones;vector_infracciones:t_vector_infracciones;var archivo_conductores:t_archivo_conductores ;var arbol_dni:t_punt);
procedure busqueda_binaria_infraccion(var archivo_infracciones:t_archivo_infracciones;fecha:TFecha ;var pos:integer);
procedure consulta_infraccion_conductor(var archivo_infracciones:t_archivo_infracciones;arbol_dni:t_punt);

IMPLEMENTATION

procedure descontar_puntos(var archivo_conductores:t_archivo_conductores;var pos:t_punt ;var x_infraccion:t_dato_infraccion);

var
    x_conductor:t_dato_conductor;
    fecha_nueva:TFecha;
begin
    abrir_archivo_conductores(archivo_conductores);
    seek(archivo_conductores,pos^.info.posicion);
    read(archivo_conductores,x_conductor);
    x_conductor.scoring := (x_conductor.scoring - x_infraccion.puntos_descontar);
    if x_conductor.scoring <= 0 then
        begin
            clrscr;
            gotoxy(5,5);
            writeln('El conductor ha sido deshabilitado por falta de puntos');
            gotoxy(5,7);
            writeln('Presione enter para continuar');
            gotoxy(5,8);
            readkey;
            x_conductor.habilitado:= false;
            x_conductor.scoring:= 0;
            fecha_nueva:= x_infraccion.fecha_infraccion;
            calcular_fecha_habilitacion(fecha_nueva,x_conductor.cantidad_reincidencias);
            x_conductor.fecha_habilitacion:= fecha_nueva;
            x_conductor.cantidad_reincidencias:= x_conductor.cantidad_reincidencias + 1;
        end;
    seek(archivo_conductores,pos^.info.posicion);
    write(archivo_conductores,x_conductor);
    close(archivo_conductores);
end;

procedure mostrar_infraccion(x_infraccion:t_dato_infraccion;var x,y:integer);

begin
    gotoxy(x,y);
    writeln('DNI: ',x_infraccion.dni);
    y:=y+1;
    gotoxy(x,y);
    writeln('Fecha de la infraccion: ',x_infraccion.fecha_infraccion.dia,'/',x_infraccion.fecha_infraccion.mes,'/',x_infraccion.fecha_infraccion.anio);
    y:=y+1;
    gotoxy(x,y);
    writeln('Tipo de infraccion: ',x_infraccion.tipo_infraccion);
    y:=y+1;
    gotoxy(x,y);
    writeln('Puntos a descontar: ',x_infraccion.puntos_descontar);
    y:=y+1;
end;


procedure seleccionar_infraccion(var opcion: string;var vector_infracciones:t_vector_infracciones);

var
    x, i, y: integer;

begin
    clrscr;
    x :=5;
    y := 7;
    gotoxy(x, 5);
    textcolor(LightRed);
    write('                      TIPOS DE INFRACCIONES                           ');
    textcolor(white);
    write(' | ');
    textcolor(LightRed);
    writeln('PUNTOS');
    textcolor(white);
    gotoxy(x, 6);
    writeln('-------------------------------------------------------------------------------');
    for i := 0 to 11 do
    begin
        gotoxy(x, y);
        write(i + 1:3, '. ', Copy(vector_infracciones[i].tipo_infraccion + StringOfChar(' ', 65), 1, 65), ' | ', vector_infracciones[i].puntos_descontar:6);
        y := y + 1;
        gotoxy(x, y);
        writeln('-------------------------------------------------------------------------------');
        y := y + 1;
    end;
    gotoxy(5, y + 2);
    textcolor(LightRed);
    writeln('INGRESE "0" PARA SALIR');
    textcolor(white);
    gotoxy(5, y + 4);
    writeln('Seleccione opcion: ');
    gotoxy(24, y + 4);
    readln(opcion);
    y:=y+5;
    x:=5;
    confirmacion_infraccion(opcion,x,y);
end;

procedure ingresar_datos_infraccion(var x_infraccion:t_dato_infraccion);

var
    x,y:integer;
    aux:string;

begin
    clrscr;
    x:=5;
    y:=7;
    gotoxy(5,5);
    writeln('Ingrese la fecha de la infraccion: ');
    gotoxy(5,6);
    writeln('Ingrese el dia: ');
    gotoxy(21,6);
    readln(x_infraccion.fecha_infraccion.dia);
    confirmacion_dias(x_infraccion.fecha_infraccion.dia,x,y);
    y:=y+1;
    gotoxy(5,y);
    writeln('Ingrese el mes: ');
    gotoxy(21,y);
    readln(x_infraccion.fecha_infraccion.mes);
    y:=y+1;
    confirmacion_mes(x_infraccion.fecha_infraccion.mes,x,y);
    y:=y+1;
    gotoxy(5,y);
    writeln('Ingrese el año: ');
    gotoxy(21,y);
    readln(x_infraccion.fecha_infraccion.anio);
    y:=y+1;
    confirmacion_fecha_infraccion(x_infraccion.fecha_infraccion,x,y);
    if(lowercase(x_infraccion.fecha_infraccion.anio) <> 'n') then
        begin
            gotoxy(5,y+1);
            writeln('Ingrese el tipo de infraccion');
            gotoxy(5,y+2);
            readln(x_infraccion.tipo_infraccion);
            gotoxy(5,y+3);
            writeln('Ingrese los puntos a descontar: ');
            gotoxy(5,y+4);
            readln(aux);
            y:=y+4;
            confirmacion_puntos2(x_infraccion.puntos_descontar,aux,x,y);
        end;
end;


procedure busqueda_binaria_infraccion(var archivo_infracciones:t_archivo_infracciones;fecha:TFecha ;var pos:integer);
var
    pri,ult,med:integer;
    x_infraccion_aux:t_dato_infraccion;
begin
    pri:=0;
    ult:=filesize(archivo_infracciones)-1;
    while (pri<=ult) do
        begin
            med:=((pri+ult) div 2);
            seek(archivo_infracciones,med);
            read(archivo_infracciones,x_infraccion_aux);
            if comparar_fechas(fecha,x_infraccion_aux.fecha_infraccion) then
                pri:=(med+1)
            else
                ult:=(med-1);

        end;
    pos:=pri;
end;

procedure mover_infracciones(var archivo_infracciones:t_archivo_infracciones; pos:integer);
var
    tamanio,i:integer;
    x_infraccion:t_dato_infraccion;
begin
    tamanio:=(filesize(archivo_infracciones) - 1);
    seek(archivo_infracciones, tamanio);
    for i:=tamanio downto pos do
        begin
            if i >= 0 then
                begin
                    seek(archivo_infracciones,i);
                    read(archivo_infracciones,x_infraccion);
                    seek(archivo_infracciones,i+1);
                    write(archivo_infracciones,x_infraccion);
                end;
        end;
end;

procedure alta_infraccion(var archivo_infracciones:t_archivo_infracciones;vector_infracciones:t_vector_infracciones;var archivo_conductores:t_archivo_conductores ;var arbol_dni:t_punt);
var
    x_infraccion: t_dato_infraccion;
    opcion:char;
    infraccion:string;
    dni:string[8];
    pos:t_punt;
    pos_aux,x,y:integer;
    x_conductor:t_dato_conductor;

begin
    clrscr;
    x:=5;
    y:=6;
    clrscr;
    gotoxy(5,5);
    writeln('Ingrese el DNI del conductor o presione "n" para volver');
    gotoxy(5,6);
    readln(dni);
    y:=6;
    confirmacion_dni(dni,x,y);
    if lowercase(dni) <> 'n' then
        begin
            pos := preorden(arbol_dni, dni);
            if pos <> nil then
                begin
                    abrir_archivo_conductores(archivo_conductores);
                    seek(archivo_conductores,pos^.info.posicion);
                    read(archivo_conductores,x_conductor);
                    close(archivo_conductores);
                    if x_conductor.habilitado then
                        begin
                            if not (arbol_lleno()) then
                                begin
                                    x_infraccion.dni:= dni;
                                    opcion:= 'v';
                                    infraccion:= '1';
                                    while (opcion = 'v') and (infraccion <> '0') do
                                        begin
                                            seleccionar_infraccion(infraccion,vector_infracciones);
                                            if (infraccion <> '0') then
                                                begin
                                                    fecha_hoy(x_infraccion.fecha_infraccion);
                                                    x_infraccion.tipo_infraccion:= vector_infracciones[StrToInt(infraccion)-1].tipo_infraccion;
                                                    x_infraccion.puntos_descontar:= vector_infracciones[StrToInt(infraccion)-1].puntos_descontar;

                                                    clrscr;
                                                    gotoxy(5,5);
                                                    writeln('Va a cargar la siguiente infraccion');
                                                    gotoxy(5,6);
                                                    x:=5;
                                                    y:=7;
                                                    mostrar_infraccion(x_infraccion,x,y);
                                                    gotoxy(5, y+1);
                                                    writeln('¿Desea confirmar la carga de la infraccion? s/n o "v" para seleccionar otra infraccion');
                                                    gotoxy(5, y+2);
                                                    readln(opcion);
                                                    y:=y+2;
                                                    x:=5;
                                                    confirmacion_snv(opcion,x,y);
                                                    if (lowercase(opcion) = 's') then
                                                        begin
                                                            descontar_puntos(archivo_conductores,pos,x_infraccion);
                                                            abrir_archivo_infracciones(archivo_infracciones);
                                                            if filesize(archivo_infracciones) = 0 then
                                                                begin
                                                                    seek(archivo_infracciones,0);
                                                                    write(archivo_infracciones,x_infraccion);
                                                                end
                                                            else
                                                                begin
                                                                    busqueda_binaria_infraccion(archivo_infracciones,x_infraccion.fecha_infraccion,pos_aux);
                                                                    mover_infracciones(archivo_infracciones, pos_aux);
                                                                    seek(archivo_infracciones, pos_aux);
                                                                    write(archivo_infracciones, x_infraccion);
                                                                end;
                                                            clrscr;
                                                            gotoxy(5,5);
                                                            writeln('Infraccion cargada con exito');
                                                            gotoxy(5,7);
                                                            writeln('Presione enter para continuar');
                                                            gotoxy(5,8);
                                                            readkey;
                                                            close(archivo_infracciones);
                                                        end
                                                    else
                                                        begin
                                                            if (lowercase(opcion) = 'n') then
                                                                begin
                                                                    clrscr;
                                                                    gotoxy(5,5);
                                                                    writeln('Infraccion no cargada');
                                                                    gotoxy(5,7);
                                                                    writeln('Presione enter para continuar');
                                                                    gotoxy(5,8);
                                                                    readkey;
                                                                end;
                                                        end;
                                                end;
                                        end;
                                end;
                        end
                    else
                        begin
                            clrscr;
                            gotoxy(5,5);
                            write('El conductor se encuentra deshabilitado, ');
                            textcolor(LightRed);
                            writeln('NOTIFICAR A JUDICIALES QUE EL CONDUCTOR SE ENCUENTRA DESHABILITADO');
                            textcolor(white);
                            gotoxy(5,7);
                            writeln('Presione enter para continuar');
                            gotoxy(5,8);
                            readkey;
                        end;
                end
            else
                begin
                    clrscr;
                    gotoxy(5,5);
                    write('DNI no encontrado, ');
                    textcolor(LightRed);
                    writeln('NOTIFICAR A JUDICIALES QUE EL CONDUCTOR NO TIENE LICENCIA');
                    textcolor(white);
                    gotoxy(5,7);
                    writeln('Presione enter para continuar');
                    gotoxy(5,8);
                    readkey;
                end;
        end
    else
        opcion:= 'n';
end;



procedure consulta_infraccion_conductor(var archivo_infracciones:t_archivo_infracciones;arbol_dni:t_punt);

var
    l:t_lista;
    dni:string[8];
    i,x,y:integer;
    pos:t_punt;
    x_infraccion:t_dato_infraccion;

begin
    x:=5;
    y:=6;
    clrscr;
    i:=0;
    gotoxy(5,5);
    writeln('Ingrese el DNI del conductor o presione "n" para volver');
    gotoxy(5,6);
    readln(dni);
    y:=6;
    confirmacion_dni(dni,x,y);
    if lowercase(dni) <> 'n' then
        begin
            pos:= preorden(arbol_dni, dni);
            crear_lista(l);
            if pos <> nil then
                begin
                    abrir_archivo_infracciones(archivo_infracciones);
                    while not EOF(archivo_infracciones) do
                        begin
                            seek(archivo_infracciones,i);
                            read(archivo_infracciones,x_infraccion);
                            if x_infraccion.dni = dni then
                                begin
                                    enlistar_infracciones(x_infraccion,l,i);
                                end;
                            i:=i+1;
                        end;
                    estruc_listado_infracciones(archivo_infracciones,l);
                    close(archivo_infracciones);
                end
            else
                begin
                    clrscr;
                    gotoxy(5,5);
                    writeln('DNI no encontrado');
                    gotoxy(5,6);
                    writeln('Presione enter para continuar');
                    gotoxy(5,7);
                    readkey;
                end;
            vaciar_lista(l);
        end
end;


END.
