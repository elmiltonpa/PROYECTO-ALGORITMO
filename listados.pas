unit listados;

INTERFACE

USES
    crt,estructura_listados,listas,funciones_varias,funciones_arboles,arboles,def_archivo_conductores,def_archivo_infracciones, confirmacion,archivo_infracciones,manejo_fechas;

procedure listado_infracciones_periodo(var archivo_infracciones:t_archivo_infracciones);
procedure listado_infracciones_conductor(var archivo_infracciones:t_archivo_infracciones;arbol_dni:t_punt);
procedure listado_scoring_cero(var archivo_conductores:t_archivo_conductores; var arbol_dni:t_punt);
procedure listado_apynom(var archivo_conductores:t_archivo_conductores; var arbol_apynom:t_punt);

IMPLEMENTATION

function comparar_inicio_fin(fecha1,fecha2:TFecha):boolean;
begin
    comparar_inicio_fin:= (fecha1.anio + fecha1.mes + fecha1.dia ) >= (fecha2.anio + fecha2.mes + fecha2.dia );
end;

procedure listado_infracciones_periodo(var archivo_infracciones:t_archivo_infracciones);

var
    fecha_inicio,fecha_fin:TFecha;
    opcion:char;
    aux:boolean;
    pos,x,y:integer;
    x_infraccion:t_dato_infraccion;
    l:t_lista;

begin
    x:=50;
    y:=6;
    clrscr;
    opcion:='s';
    while (lowercase(opcion) = 's') do
        begin
            aux:=true;
            ingresar_fechas_periodo(fecha_inicio,fecha_fin,opcion);
            if lowercase(opcion) = 's' then
                begin
                    abrir_archivo_infracciones(archivo_infracciones);
                    busqueda_binaria_infraccion(archivo_infracciones,fecha_inicio,pos);
                    seek(archivo_infracciones,pos);
                    if pos < filesize(archivo_infracciones) then
                        begin                            
                            read(archivo_infracciones,x_infraccion);
                            if (comparar_inicio_fin(fecha_fin,x_infraccion.fecha_infraccion)) then
                                begin
                                    crear_lista(l);
                                    while (pos < filesize(archivo_infracciones)) and (comparar_inicio_fin(fecha_fin,x_infraccion.fecha_infraccion)) do
                                        begin
                                            enlistar_infracciones(x_infraccion,l,pos);
                                            pos := pos + 1;
                                            if pos < filesize(archivo_infracciones) then
                                                begin
                                                    seek(archivo_infracciones, pos);
                                                    read(archivo_infracciones, x_infraccion);
                                                end;
                                        end;
                                    estruc_listado_infracciones(archivo_infracciones,l);
                                end
                            else
                                begin
                                    aux:=false;
                                end;
                        end
                    else
                        begin
                            aux:=false;
                        end; 
                    close(archivo_infracciones);
                end;
            if not aux then
                begin
                    clrscr;
                    gotoxy(5, 5);
                    writeln('No se encontraron infracciones en el periodo seleccionado.');
                    gotoxy(5, 7);
                    writeln('Presione enter para continuar');
                    gotoxy(5, 8);
                    readkey;
                end;
            if opcion <>'n' then
                begin
                    clrscr;
                    x:=5;
                    y:=6;
                    gotoxy(5,5);
                    writeln('Desea seguir consultando infracciones en un periodo determinado? s/n');
                    gotoxy(5,6);
                    readln(opcion);
                    confirmacion_sn(opcion,x,y);
                end;
        end;

end;

procedure listado_infracciones_conductor(var archivo_infracciones:t_archivo_infracciones;arbol_dni:t_punt);
var
    fecha_inicio,fecha_fin:TFecha;
    opcion:char;
    pos,x,y:integer;
    conductor:t_punt;
    x_infraccion:t_dato_infraccion;
    aux:boolean;
    dni:string;
    l:t_lista;

begin
    aux:=true;
    x:=50;
    y:=6;
    opcion:='s';
    while (lowercase(opcion) = 's') do
        begin
            clrscr;
            gotoxy(5,5);
            writeln('Ingrese el DNI del conductor');
            gotoxy(5,6);
            readln(dni);
            confirmacion_dni(dni,x,y);
            if lowercase(dni) <> 'n' then
                begin
                    conductor:= preorden(arbol_dni, dni);
                    if conductor <> nil then
                        begin
                            ingresar_fechas_periodo(fecha_inicio,fecha_fin,opcion);
                            if lowercase(opcion) = 's' then
                                begin
                                    abrir_archivo_infracciones(archivo_infracciones);
                                    busqueda_binaria_infraccion(archivo_infracciones,fecha_inicio,pos);
                                    seek(archivo_infracciones,pos);
                                    if pos < filesize(archivo_infracciones) then
                                        begin
                                            read(archivo_infracciones,x_infraccion);
                                            if (comparar_inicio_fin(fecha_fin,x_infraccion.fecha_infraccion)) then
                                                begin
                                                    crear_lista(l);
                                                    while (pos < filesize(archivo_infracciones)) and (comparar_inicio_fin(fecha_fin,x_infraccion.fecha_infraccion)) do
                                                        begin
                                                            if x_infraccion.dni = dni then
                                                                begin
                                                                    enlistar_infracciones(x_infraccion,l,pos);
                                                                end;
                                                            pos := pos + 1;
                                                            if pos < filesize(archivo_infracciones) then
                                                                begin
                                                                    seek(archivo_infracciones, pos);
                                                                    read(archivo_infracciones, x_infraccion);
                                                                end;
                                                        end;
                                                    estruc_listado_infracciones(archivo_infracciones,l);
                                                end
                                            else
                                                aux:=false;
                                        end
                                    else
                                        aux:=false;
                                    close(archivo_infracciones);
                                end;
                            if not aux then
                                begin
                                    clrscr;
                                    gotoxy(5,5);
                                    writeln('No se encontraron infracciones en el periodo seleccionado.');
                                    gotoxy(5, 7);
                                    writeln('Presione enter para continuar');
                                    gotoxy(5, 8);
                                    readkey;
                                end;
                            if opcion <>'n' then
                                begin
                                    clrscr;
                                    x:=5;
                                    y:=6;
                                    gotoxy(5,5);
                                    writeln('Desea seguir consultando infracciones de un conductor en un periodo determinado? s/n');
                                    gotoxy(5,6);
                                    readln(opcion);
                                    confirmacion_sn(opcion,x,y);
                                end;    
                        end
                    else
                        begin
                            clrscr;
                            gotoxy(5, 5);
                            writeln('DNI no encontrado');
                        end;

                end
            else
                opcion:= 'n';
        end;
end;

procedure listado_scoring_cero(var archivo_conductores:t_archivo_conductores; var arbol_dni:t_punt);
var
    aux:boolean;

begin
    abrir_archivo_conductores(archivo_conductores);
    aux:=false;
    estruc_listado_scoring_0(archivo_conductores,aux);
    close(archivo_conductores);
end;

procedure enlistar_conductores_apynom(var arbol_apynom:t_punt; var l:t_lista);

begin
    if arbol_apynom <> nil then
        begin
            enlistar_conductores_apynom(arbol_apynom^.sai,l);
            agregar_lista(l,arbol_apynom^.info);
            enlistar_conductores_apynom(arbol_apynom^.sad,l);
        end;
end;

procedure listado_apynom(var archivo_conductores:t_archivo_conductores; var arbol_apynom:t_punt);
var
    l:t_lista;
    y:integer;
begin
    y:=6;
    crear_lista(l);
    enlistar_conductores_apynom(arbol_apynom,l);
    if not (lista_vacia(l)) then
        begin
            y:= (5 + (tamanio(l)*2));
            primero(l);
            abrir_archivo_conductores(archivo_conductores);
            estruc_listado_apynom(archivo_conductores,l);
            close(archivo_conductores);
            gotoxy(5, y );
            writeln('Presione enter para continuar');
            readkey;
        end
    else   
        begin
            clrscr;
            gotoxy(5, 5);
            writeln('No hay conductores cargados');
            gotoxy(5, 7);
            writeln('Presione enter para continuar');
            readkey;
        end;
end;

END.
