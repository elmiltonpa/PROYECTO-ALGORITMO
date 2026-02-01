unit menus;

INTERFACE

USES
    crt,listados,def_archivo_conductores,tipos_infraccion,def_archivo_infracciones,arboles,archivo_conductores,archivo_infracciones,estadisticas,confirmacion;

procedure AMC_infraccion(var archivo_infracciones:t_archivo_infracciones;var archivo_conductores:t_archivo_conductores;var arbol_dni:T_punt;vector_infracciones:t_vector_infracciones);
procedure estadisticas(var archivo_infracciones:t_archivo_infracciones;var archivo_conductores:t_archivo_conductores;arbol_dni:t_punt);
procedure listados(var archivo_infracciones:t_archivo_infracciones;var archivo_conductores:t_archivo_conductores;arbol_dni,arbol_apynom:t_punt);

IMPLEMENTATION

procedure AMC_infraccion(var archivo_infracciones:t_archivo_infracciones;var archivo_conductores:t_archivo_conductores;var arbol_dni:T_punt;vector_infracciones:t_vector_infracciones);
var
    opcion:char;

begin
    repeat
        clrscr;
        gotoxy(5, 5);
        writeln('1. Cargar infraccion');
        gotoxy(5, 6);
        writeln('2. Consultar las infracciones de un conductor');
        gotoxy(5, 7);
        writeln('0. Volver al menu principal');
        gotoxy(5, 9);
        writeln('Seleccione opcion: '); 
        gotoxy(24, 9);
        readln(opcion);
        confirmacion_3_opciones(opcion,5,11);
        case opcion of
            '1': alta_infraccion(archivo_infracciones,vector_infracciones,archivo_conductores,arbol_dni);
            '2': consulta_infraccion_conductor(archivo_infracciones,arbol_dni);
        end;
    until opcion = '0';
end;

procedure listados(var archivo_infracciones:t_archivo_infracciones;var archivo_conductores:t_archivo_conductores;arbol_dni,arbol_apynom:t_punt);
var
    opcion:char;

begin
    repeat
        clrscr;
        gotoxy(5, 5);
        writeln('1. Listado de conductores');
        gotoxy(5, 6);
        writeln('2. Listado de infracciones en un periodo');
        gotoxy(5, 7);
        writeln('3. Listado de infracciones de un conductor en un periodo');
        gotoxy(5, 8);
        writeln('4. Listado de conductores con scoring igual a cero'); 
        gotoxy(5, 9);
        writeln('0. Volver al menu principal');
        gotoxy(5, 11);
        writeln('Seleccione opcion: ');
        gotoxy(24, 11);
        readln(opcion);
        confirmacion_5_opciones(opcion,5,13);
        case opcion of
            '1': listado_apynom(archivo_conductores,arbol_apynom);
            '2': listado_infracciones_periodo(archivo_infracciones);
            '3': listado_infracciones_conductor(archivo_infracciones,arbol_dni);
            '4': listado_scoring_cero(archivo_conductores,arbol_dni);
        end;
    until opcion = '0';
end;


procedure estadisticas(var archivo_infracciones:t_archivo_infracciones;var archivo_conductores:t_archivo_conductores;arbol_dni:t_punt);
var
    opcion:char;
    x,y:integer;
begin
    repeat
        clrscr;
        x:=5;
        y:=14;
        gotoxy(5, 5);
        writeln('1. Cantidad de infracciones entre dos fechas');
        gotoxy(5, 6);
        writeln('2. Porcentaje de conductores con reincidencias');
        gotoxy(5, 7);
        writeln('3. Porcentaje de conductores con scoring 0');
        gotoxy(5, 8);
        writeln('4. Total de conductores habilitados');
        gotoxy(5, 9);
        writeln('5. Rango etario con mas infracciones');
        gotoxy(5, 10);
        writeln('0. Volver al menu principal');
        gotoxy(5, 12);
        writeln('Seleccione opcion: ');
        gotoxy(24, 12);
        readln(opcion);
        confirmacion_6_opciones(opcion,x,y);
        case opcion of
            '1': cant_infracciones_fechas(archivo_infracciones);
            '2': porcentaje_reincidencias(archivo_conductores);
            '3': porcentaje_scoring_0(archivo_conductores);
            '4': total_habilitados(archivo_conductores);
            '5': rango_etario(archivo_infracciones,archivo_conductores,arbol_dni);
        end;
    until opcion = '0';
end;


END.





