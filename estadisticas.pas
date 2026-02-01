unit estadisticas;

{$codepage UTF8}

INTERFACE  

USES
    crt,sysutils,listas,funciones_varias,def_archivo_infracciones,def_archivo_conductores,archivo_conductores,archivo_infracciones,confirmacion,manejo_fechas,arboles,funciones_arboles;

procedure cant_infracciones_fechas(var archivo_infracciones: t_archivo_infracciones);
procedure rango_etario(var archivo_infracciones:t_archivo_infracciones;var archivo_conductores:t_archivo_conductores;arbol_dni:t_punt);
procedure total_habilitados(var archivo_conductores:t_archivo_conductores);
procedure porcentaje_reincidencias(var archivo_conductores:t_archivo_conductores);
procedure porcentaje_scoring_0(var archivo_conductores:t_archivo_conductores);

IMPLEMENTATION

procedure total_habilitados(var archivo_conductores:t_archivo_conductores);
var
    cantidad,pos:integer;
    x_conductor:t_dato_conductor;

begin
    clrscr;
    abrir_archivo_conductores(archivo_conductores);
    cantidad:=0;
    pos:=0;
    while pos < filesize(archivo_conductores) do
        begin
            seek(archivo_conductores,pos);
            read(archivo_conductores,x_conductor);
            if x_conductor.habilitado then
                begin
                    cantidad:= cantidad + 1;
                end;
            pos:= pos + 1;
        end;

    clrscr;
    gotoxy(5,5);
    write('La cantidad de conductores habilitados es: ');
    textcolor(LightRed);
    write(cantidad);
    textcolor(white);
    write(' de un total de ');
    textcolor(LightRed);
    write(filesize(archivo_conductores));
    textcolor(white);
    writeln(' conductores');
    close(archivo_conductores);
    gotoxy(5,7);
    writeln('Presione enter para continuar');
    gotoxy(5,8);
    readkey;
end;


procedure calcular_rango(fecha_nacimiento:TFecha;var rango:integer);
var
    anio:integer;
begin
    anio:= 2024 - strToInt(fecha_nacimiento.anio);
    if (anio >= 17) and (anio <= 30) then
        begin
            rango:= 1;
        end
    else if (anio >= 31) and (anio <= 50) then
        begin
            rango:= 2;
        end
    else
        begin
            rango:= 3;
        end;
end;


procedure rango_etario(var archivo_infracciones:t_archivo_infracciones;var archivo_conductores:t_archivo_conductores;arbol_dni:t_punt);
var
    l:t_lista;
    x_infraccion:t_dato_infraccion;
    x_conductor:t_dato_conductor;
    encontrado:boolean;
    pos_conductor:t_punt;
    cant_17_30,cant_31_50,cant_51_o_mas,rango,pos:integer;
    aux_lista:t_dato_arbol;

begin
    clrscr;
    pos:=0;
    cant_17_30:=0;
    cant_31_50:=0;
    cant_51_o_mas:=0;
    abrir_archivo_infracciones(archivo_infracciones);
    abrir_archivo_conductores(archivo_conductores);
    crear_lista(l);
    while not EOF(archivo_infracciones) do
        begin
            seek(archivo_infracciones,pos);
            read(archivo_infracciones,x_infraccion);
            buscar_lista(l,x_infraccion.dni,encontrado);
            if not encontrado then
                begin
                    pos_conductor:=preorden(arbol_dni,x_infraccion.dni);
                    aux_lista.clave:=x_infraccion.dni;
                    aux_lista.posicion:=pos_conductor^.info.posicion;
                    agregar_lista(l,aux_lista);
                    seek(archivo_conductores,pos_conductor^.info.posicion);
                    read(archivo_conductores,x_conductor);
                    calcular_rango(x_conductor.fecha_nacimiento,rango);
                    case rango of
                        1: cant_17_30:= cant_17_30 + 1;
                        2: cant_31_50:= cant_31_50 + 1;
                        3: cant_51_o_mas:= cant_51_o_mas + 1;
                    end;
                end;
            pos:= pos + 1;
        end;
    close(archivo_infracciones);
    close(archivo_conductores);

    clrscr;
    gotoxy(5,5);
    writeln('Cantidad de infracciones por rango etario:');

    gotoxy(5,7);
    write('17-30 años: ');
    textcolor(LightRed);
    writeln(cant_17_30);
    textcolor(white);

    gotoxy(5,8);
    write('31-50 años: ');
    textcolor(LightRed);
    writeln(cant_31_50);
    textcolor(white);

    gotoxy(5,9);
    write('51 o más años: ');
    textcolor(LightRed);
    writeln(cant_51_o_mas);
    textcolor(white);

    gotoxy(5,11);
    writeln('Presione enter para continuar');
    gotoxy(5,12);
    readkey;
end;

procedure porcentaje_scoring_0(var archivo_conductores:t_archivo_conductores);
var
    cantidad,pos:integer;
    x_conductor:t_dato_conductor;
    porcentaje:real;

begin
    clrscr;
    abrir_archivo_conductores(archivo_conductores);
    cantidad:=0;
    pos:=0;
    while pos < filesize(archivo_conductores) do
        begin
            seek(archivo_conductores,pos);
            read(archivo_conductores,x_conductor);
            if x_conductor.scoring = 0 then
                begin
                    cantidad:= cantidad + 1;
                end;
            pos:= pos + 1;
        end;

    porcentaje := (cantidad * 100) / filesize(archivo_conductores);
    clrscr;
    gotoxy(5,5);
    write('El porcentaje de conductores con scoring 0 es: ');
    textcolor(LightRed);
    write(porcentaje:2:2,'%');
    textcolor(white);
    write(' de un total de ');
    textcolor(LightRed);
    write(filesize(archivo_conductores));
    textcolor(white);
    writeln(' conductores');
    close(archivo_conductores);
    gotoxy(5,7);
    writeln('Presione enter para continuar');
    gotoxy(5,8);
    readkey;
end;


procedure porcentaje_reincidencias(var archivo_conductores:t_archivo_conductores);
var
    cantidad:integer;
    pos:integer;
    x_conductor:t_dato_conductor;
    porcentaje:real;

begin
    clrscr;
    abrir_archivo_conductores(archivo_conductores);
    cantidad:=0;
    pos:=0;
    while pos < filesize(archivo_conductores) do
        begin
            seek(archivo_conductores,pos);
            read(archivo_conductores,x_conductor);
            if x_conductor.cantidad_reincidencias > 0 then
                begin
                    cantidad:= cantidad + 1;
                end;
            pos:= pos + 1;
        end;
    porcentaje:= (cantidad * 100) / filesize(archivo_conductores);
    clrscr;
    gotoxy(5,5);

    write('El porcentaje de conductores con reincidencias es: ');
    textcolor(LightRed);
    write(porcentaje:2:2,'%');
    textcolor(white);
    write(' de un total de ');
    textcolor(LightRed);
    write(filesize(archivo_conductores));
    textcolor(white);
    writeln(' conductores');
    gotoxy(5,7);
    writeln('Presione enter para continuar');
    close(archivo_conductores);
    gotoxy(5,8);
    readkey;
end;


procedure cant_infracciones_fechas(var archivo_infracciones: t_archivo_infracciones);
var
    opcion:char;
    fecha_inicio,fecha_fin:TFecha;
    pos,cantidad:integer;
    x_infraccion:t_dato_infraccion;

begin
    clrscr;
    cantidad:=0;
    ingresar_fechas_periodo(fecha_inicio,fecha_fin,opcion);
    if opcion <> 'n' then
        begin
            abrir_archivo_infracciones(archivo_infracciones);
            busqueda_binaria_infraccion(archivo_infracciones,fecha_inicio,pos);
            if pos < filesize(archivo_infracciones) then
                begin
                    seek(archivo_infracciones,pos);
                    read(archivo_infracciones,x_infraccion);
                    while (pos < filesize(archivo_infracciones)) do
                        begin
                            if comparar_fechas(fecha_fin,x_infraccion.fecha_infraccion) or fechas_iguales(fecha_fin,x_infraccion.fecha_infraccion) then
                                begin
                                    cantidad:= cantidad + 1;
                                end;
                            pos:= pos + 1;
                            if pos < filesize(archivo_infracciones) then
                                    begin
                                        seek(archivo_infracciones, pos);
                                        read(archivo_infracciones, x_infraccion);
                                    end;
                        end;
                
                end;
            close(archivo_infracciones);
            clrscr;
            gotoxy(5,5);
            write('La cantidad de infracciones entre las fechas seleccionadas es: ');
            textcolor(LightRed);
            writeln(cantidad);
            textcolor(white);
            gotoxy(5,7);
            writeln('Presione enter para continuar');
            gotoxy(5,8);
            readkey;
        end;
end;

END.
