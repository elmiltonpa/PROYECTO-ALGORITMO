unit estructura_listados;


INTERFACE

USES
    crt,def_archivo_conductores,def_archivo_infracciones,listas;

procedure estruc_listado_apynom(var archivo_conductores:t_archivo_conductores;l:t_lista);
procedure estruc_listado_scoring_0(var archivo_conductores:t_archivo_conductores;var aux:boolean);
procedure estruc_listado_infracciones(var archivo_infracciones:t_archivo_infracciones; var l:t_lista);

IMPLEMENTATION

procedure estruc_listado_infracciones(var archivo_infracciones:t_archivo_infracciones; var l:t_lista);
var
    x_infraccion:t_dato_infraccion;
    i:integer;
    cant_infracciones:integer;

begin
    clrscr;
    cant_infracciones := tamanio(l);
    primero(l);
    if (cant_infracciones = 0) then
        begin
            gotoxy(2, 5);
            i:=7;
        end
    else    
        begin
            gotoxy(2, 1);
            i:=5;
        end;
    writeln('Se hallaron ', cant_infracciones, ' infracciones');
    if (tamanio(l) <> 0) then
        begin
            gotoxy(2, 3);
            writeln('   DNI    | Fecha Infrac. | Puntos | Descripción');
            gotoxy(2, 4);
            writeln('-------------------------------------------------------------------------------');
        end;

    while not (fin(l)) do
        begin
            seek(archivo_infracciones, l.act^.info.posicion);
            read(archivo_infracciones, x_infraccion);
            gotoxy(2, i);
            writeln(x_infraccion.dni:8, ' | ', x_infraccion.fecha_infraccion.dia:2, '/', x_infraccion.fecha_infraccion.mes:2, '/', x_infraccion.fecha_infraccion.anio:4, ' | ', x_infraccion.puntos_descontar:6, ' | ', Copy(x_infraccion.tipo_infraccion, 1, 40));
            i := i + 1;
            gotoxy(2, i);
            writeln('-------------------------------------------------------------------------------');
            siguiente(l);
            i := i + 1;
            
        end;
    gotoxy(2, i + 1);
    writeln('Presione una tecla para continuar');
    readkey;
    clrscr;

end;

procedure estruc_listado_apynom(var archivo_conductores:t_archivo_conductores;l:t_lista);
var
    x_conductor:t_dato_conductor;
    i:integer;
    apynom:string;

begin
    clrscr;
    i := 4;
    gotoxy(2, 2); 
    writeln(' Nombre y Apellido      | Fecha Nac. | Scoring | DNI');
    gotoxy(2, 3);
    writeln('-------------------------------------------------------------------------------');
    while not (fin(l)) do
    begin
        seek(archivo_conductores, l.act^.info.posicion);
        read(archivo_conductores, x_conductor);
        gotoxy(2, i);
        apynom := x_conductor.nombre + ' ' + x_conductor.apellido;
        apynom := Copy(apynom + StringOfChar(' ', 23), 1, 23); 
        writeln(apynom, ' | ', x_conductor.fecha_nacimiento.dia:2, '/', x_conductor.fecha_nacimiento.mes:2, '/', x_conductor.fecha_nacimiento.anio:4, ' | ', x_conductor.scoring:7,' | ', x_conductor.dni:9);
        i := i + 1;
        gotoxy(2, i);
        writeln('-------------------------------------------------------------------------------');
        i := i + 1;
        siguiente(l);
    end;
end;

procedure estruc_listado_scoring_0(var archivo_conductores:t_archivo_conductores;var aux:boolean);
var
    pos,cont,i:integer;
    x_conductor:t_dato_conductor;

begin
    clrscr;
    cont:=6;
    pos:=0;
    i:=4;
    gotoxy(2, 2); 
    writeln(' DNI      | Fecha Habilit. | Reincid. | Nombre y Apellido');
    gotoxy(2, 3);
    writeln('-------------------------------------------------------------------------------');

    while pos < filesize(archivo_conductores) do
        begin
            seek(archivo_conductores, pos);
            read(archivo_conductores, x_conductor);
            if x_conductor.scoring = 0 then
            begin
                cont := cont + 1;
                aux := true;
                gotoxy(2, i);
                i := i + 1;
                writeln(x_conductor.dni:8, ' | ', x_conductor.fecha_habilitacion.dia:2,'/',x_conductor.fecha_habilitacion.mes:2,'/',x_conductor.fecha_habilitacion.anio:4,' | ', x_conductor.cantidad_reincidencias:8 ,' | ', x_conductor.nombre ,' ', x_conductor.apellido);  
                gotoxy(2, i);
                i := i + 1;
                writeln('-------------------------------------------------------------------------------');
            end;
            pos := pos + 1;
        end;
    if aux = false then
        begin
            gotoxy(5, 4);
            writeln('No hay conductores con scoring igual a cero');
        end;
    gotoxy(5, i+2);
    writeln('Presione enter para continuar');
    gotoxy(5, i+3);
    readkey;

end;


END.