unit funciones_varias;

INTERFACE

USES
    crt,def_archivo_conductores,def_archivo_infracciones,arboles,manejo_fechas,confirmacion,listas;

procedure ingresar_fechas_periodo(var fecha_inicio:TFecha; var fecha_fin:TFecha; var opcion:char);
procedure enlistar_infracciones(x_infraccion:t_dato_infraccion; var l:t_lista; pos:integer);

IMPLEMENTATION

procedure enlistar_infracciones(x_infraccion:t_dato_infraccion; var l:t_lista; pos:integer);
var
    aux:t_dato_arbol;

begin
    aux.clave:=x_infraccion.fecha_infraccion.anio + x_infraccion.fecha_infraccion.mes + x_infraccion.fecha_infraccion.dia;
    aux.posicion:=pos;
    agregar_lista(l,aux);
end;

procedure ingresar_fecha(var fecha:TFecha;var x,y:integer);

begin
    gotoxy(x,y);
    writeln('Ingrese el dia: ');
    gotoxy(x+16,y);
    readln(fecha.dia);
    y:= y + 1;
    confirmacion_dias(fecha.dia,x,y);
    y:= y + 1;
    gotoxy(x,y);
    writeln('Ingrese el mes: ');
    gotoxy(x+16,y);
    readln(fecha.mes);
    y:= y + 1;
    confirmacion_mes(fecha.mes,x,y);
    y:= y + 1;
    gotoxy(x,y);
    writeln('Ingrese el año: ');
    gotoxy(x+16,y);
    readln(fecha.anio);
    y:= y + 1;
    confirmacion_fecha_infraccion(fecha,x,y);
end;

procedure ingresar_fechas_periodo(var fecha_inicio:TFecha; var fecha_fin:TFecha; var opcion:char);
var
    x,y:integer;
    begin
        clrscr;
        x:= 50;
        y:= 6;
        opcion:= 's';
        gotoxy(50,5);
        writeln('Ingrese la fecha de inicio del periodo a consultar: ');
        ingresar_fecha(fecha_inicio,x,y);
        if lowercase(fecha_inicio.anio) <> 'n' then
            begin
                clrscr;
                y:= 6;
                x:= 50;
                gotoxy(50,5);
                writeln('Ingrese la fecha de fin del periodo a consultar: ');
                ingresar_fecha(fecha_fin,x,y);
                if (lowercase(fecha_fin.anio) <> 'n') then
                    begin
                        if comparar_fechas(fecha_inicio,fecha_fin) then
                            begin
                                clrscr;
                                gotoxy(50,5);
                                writeln('Fecha de inicio mayor a fecha de fin');
                                gotoxy(50,7);
                                writeln('Desea ingresar nuevamente las fechas? s/n');
                                gotoxy(50,8);
                                readln(opcion);
                                y:= 7;
                                confirmacion_sn(opcion,x,y);
                                if (lowercase(opcion) = 's') then
                                    ingresar_fechas_periodo(fecha_inicio,fecha_fin,opcion);
                                
                            end;
                    end;
            end;
        if (lowercase(fecha_inicio.anio) = 'n') or (lowercase(fecha_fin.anio) = 'n') then
            opcion:= 'n';           
    end;

END.