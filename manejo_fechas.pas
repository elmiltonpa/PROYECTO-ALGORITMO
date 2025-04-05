unit manejo_fechas;


INTERFACE

uses
    crt,dateutils,SysUtils;

type
    TFecha = record
        dia: string[2];
        mes: string[2];
        anio: string[4];
    end;

procedure fecha_habilitacion(var fecha: TFecha; dias:integer);
procedure completar_fecha(var fecha:TFecha);
function fechas_iguales(fecha1,fecha2:TFecha):boolean;
function fecha_valida(fecha:TFecha):boolean;
function comparar_fechas(fecha1:TFecha; fecha2:TFecha):boolean;
procedure calcular_fecha_habilitacion(var fecha_nueva:TFecha;reincidencias:integer);
procedure fecha_hoy(var fecha:TFecha);

IMPLEMENTATION

function potencia(base:integer; exponente:integer):integer;
var
    i,resultado:integer;
begin
    resultado:=1;
    for i:=1 to exponente do
        begin
            resultado:=resultado*base;
        end;
    potencia:=resultado;
end;


function comparar_fechas(fecha1:TFecha; fecha2:TFecha):boolean;

begin
    comparar_fechas:= (fecha1.anio + fecha1.mes + fecha1.dia ) > (fecha2.anio + fecha2.mes + fecha2.dia );
end;

procedure completar_fecha(var fecha:TFecha);

begin
    if length(fecha.dia) = 1 then
        fecha.dia := '0' + fecha.dia;
    if length(fecha.mes) = 1 then
        fecha.mes := '0' + fecha.mes;
end;

function fechas_iguales(fecha1,fecha2:TFecha):boolean;
begin
    if (fecha1.dia = fecha2.dia) and (fecha1.mes = fecha2.mes) and (fecha1.anio = fecha2.anio) then
        fechas_iguales:=true
    else
        fechas_iguales:=false;
end;

procedure fecha_habilitacion(var fecha: TFecha; dias:integer);
var

    fecha_final:TDateTime;
    anio,mes,dia:word;

begin
    dia:=StrToInt(fecha.dia);
    mes:=StrToInt(fecha.mes);
    anio:=StrToInt(fecha.anio);

    fecha_final:=EncodeDate(anio,mes,dia);
    fecha_final:=IncDay(fecha_final,dias);

    fecha.dia := FormatDateTime('dd', fecha_final);
    fecha.mes := FormatDateTime('mm', fecha_final);
    fecha.anio := FormatDateTime('yyyy', fecha_final);
end;

function fecha_valida(fecha:TFecha):boolean;
var
    opciones: set of char = ['0'..'9'];
    dia,mes,anio:integer;
    aux:boolean;
    i:integer;
begin
    aux:=true;
    for i:=1 to length(fecha.dia) do
        begin
            if not (fecha.dia[i] in opciones) then
                aux:=false;
        end;
    for i:=1 to length(fecha.mes) do
        begin
            if not (fecha.mes[i] in opciones) then
                aux:=false;
        end;
    for i:=1 to length(fecha.anio) do
        begin
            if not (fecha.anio[i] in opciones) then
                aux:=false;
        end;
    if aux then
        begin
            dia:=StrToInt(fecha.dia);
            mes:=StrToInt(fecha.mes);
            anio:=StrToInt(fecha.anio);
            fecha_valida:= IsValidDate(anio,mes,dia);
        end
    else
        fecha_valida:=false;
end;

procedure calcular_fecha_habilitacion(var fecha_nueva:TFecha;reincidencias:integer);
var
    dias_aux:integer;

begin
    case reincidencias of
        0: fecha_habilitacion(fecha_nueva,60);
        1: fecha_habilitacion(fecha_nueva,120);
        2: fecha_habilitacion(fecha_nueva,180);
        else
            begin
                dias_aux:= (potencia(2,reincidencias-2) * 180);
                fecha_habilitacion(fecha_nueva,dias_aux);
            end;
    end;
end;

procedure fecha_hoy(var fecha:TFecha);
    var
        fecha_actual:TDateTime;
        anio,mes,dia:word;
    begin
        fecha_actual:=Now;
        DecodeDate(fecha_actual,anio,mes,dia);

        fecha.dia := FormatDateTime('dd', fecha_actual);
        fecha.mes := FormatDateTime('mm', fecha_actual);
        fecha.anio := FormatDateTime('yyyy', fecha_actual);
    end;


END.