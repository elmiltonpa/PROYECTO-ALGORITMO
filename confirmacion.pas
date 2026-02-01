{$codepage UTF8}
unit confirmacion;


INTERFACE

USES
    crt,sysutils,manejo_fechas;

procedure confirmacion_sn(var opcion:char;var x,y:integer);
procedure confirmacion_6_opciones(var opcion:char;var x,y:integer);
procedure confirmacion_5_opciones(var opcion:char;x,y:integer);
procedure confirmacion_3_opciones(var opcion:char;x,y:integer);
procedure confirmacion_4_opciones(var opcion:char;x,y:integer);
procedure confirmacion_fecha_infraccion(var fecha:TFecha;var x,y:integer);
procedure confirmacion_fecha_conductor(var fecha:TFecha;var x,y:integer);
procedure confirmacion_fecha_conductor2(var fecha:TFecha;var x,y:integer);
procedure confirmacion_anio_infraccion(var anio:string;var x,y:integer);
procedure confirmacion_anio_conductor(var anio:string;var x,y:integer);
procedure confirmacion_dni(var dni:string;var x,y:integer);
procedure confirmacion_puntos(var puntos:integer;var x,y:integer);
procedure confirmacion_dias(var dias:string;var x,y:integer);
procedure confirmacion_mes(var mes:string;var x,y:integer);
procedure confirmacion_sn_conductor(var opcion:char;var x,y:integer);
procedure confirmacion_nombre(var nombre:string;var x,y:integer);
procedure confirmacion_apellido(var apellido:string;var x,y:integer);
procedure confirmacion_puntos2(var puntos:integer; aux:string; var x,y:integer);
procedure confirmacion_telefono(var telefono:string; var x,y:integer);
procedure confirmacion_infraccion(var infraccion:string;var x,y:integer);
procedure confirmacion_snv(var opcion:char;var x,y:integer);
procedure confirmacion_email(var email:string;var x,y:integer);

IMPLEMENTATION

procedure confirmacion_dias(var dias: string;var x,y:integer);
begin
    if length(dias) = 1 then
       dias:='0' + dias;
    
    if (not (dias[1] in ['0'..'9'])) or (not (dias[2] in ['0'..'9'])) or (length(dias) > 2) or (dias = '') then
        begin
            gotoxy(x,y);
            writeln('Ingrese un valor válido (1-31): ');
            gotoxy(x + 33,y);
            clreol;
            readln(dias);
            confirmacion_dias(dias,x,y);
        end
    else
        begin
            if (StrToInt(dias) < 1) or (StrToInt(dias) > 31) then
                begin
                    gotoxy(x,y);
                    writeln('Ingrese un valor válido (1-31) ');
                    gotoxy(x + 33,y);
                    clreol;
                    readln(dias);
                    confirmacion_dias(dias,x,y);
                end;
        end;
end;
procedure confirmacion_mes(var mes:string;var x,y:integer);
begin
    if length(mes) = 1 then
        mes:='0' + mes;

    if (not (mes[1] in ['0'..'9'])) or (not (mes[2] in ['0'..'9'])) or (length(mes) > 2) or (mes = '') then
        begin
            gotoxy(x, y);
            writeln('Ingrese un valor válido (1-12): ');
            gotoxy(x + 33, y);
            clreol;
            readln(mes);
            confirmacion_mes(mes, x, y);
        end
    else
        begin
            if (StrToInt(mes) < 1) or (StrToInt(mes) > 12) then
                begin
                    gotoxy(x, y);
                    writeln('Ingrese un valor válido (1-12) ');
                    gotoxy(x + 33, y);
                    clreol;
                    readln(mes);
                    confirmacion_mes(mes, x, y);
                end;
        end;
end;

procedure confirmacion_puntos(var puntos:integer;var x,y:integer);

begin
    if not (puntos in [1,2,4,5,10,20] ) then
        begin
            gotoxy(x,y);
            writeln('Asegurese de ingresar un valor valido, [1,2,4,5,10,20] y vuelva a intentarlo');
            gotoxy(x,y + 1);
            clreol;
            readln(puntos);
            confirmacion_puntos(puntos,x,y);
        end;
end;

procedure confirmacion_puntos2(var puntos:integer; aux:string; var x,y:integer);

begin
    if (aux <> '1') and (aux <> '2') and (aux <> '4') and (aux <> '5') and (aux <> '10') and (aux <> '20')  then
        begin
            gotoxy(x,y);
            writeln('Asegurese de ingresar un valor valido, [1,2,4,5,10,20] y vuelva a intentarlo');
            gotoxy(x,y + 1);
            clreol;
            readln(aux);
            confirmacion_puntos2(puntos,aux,x,y);
        end
    else
        puntos:=StrToInt(aux);
end;

procedure confirmacion_sn(var opcion:char;var x,y:integer);

begin
    if (lowercase(opcion) <> 's') and (lowercase(opcion) <> 'n') then
        begin
            gotoxy(x,y);
            writeln('Opción incorrecta, presione "s" para confirmar o "n" para volver');
            gotoxy(x,y + 1);
            clreol;
            readln(opcion);
            confirmacion_sn(opcion,x,y);
        end;
end;



procedure confirmacion_5_opciones(var opcion:char;x,y:integer);
const
    opciones: set of char = ['1','2','3','4','0'];
begin
    if not (opcion in opciones) then
        begin
            gotoxy(x,y);
            writeln('Opcion incorrecta, vuelva a intentarlo o presione "0" para volver');
            gotoxy(x,y + 1);
            clreol;
            readln(opcion);
            confirmacion_5_opciones(opcion,x,y);
        end;
end;

procedure confirmacion_6_opciones(var opcion:char;var x,y:integer);
const
    opciones: set of char = ['1','2','3','4','5','0'];
begin
    if not (opcion in opciones) then
        begin
            gotoxy(x,y);
            writeln('Opcion incorrecta, vuelva a intentarlo o presione "0" para volver');
            gotoxy(x,y + 1);
            clreol;
            readln(opcion);
            confirmacion_6_opciones(opcion,x,y);
        end;
end;


procedure confirmacion_3_opciones(var opcion:char;x,y:integer);
const
    opciones: set of char = ['1','2','0'];
begin
    if not (opcion in opciones) then
        begin
            gotoxy(x,y);
            writeln('Opcion incorrecta, vuelva a intentarlo o presione "0" para volver');
            gotoxy(x,y + 1);
            clreol;
            readln(opcion);
            confirmacion_3_opciones(opcion,x,y);
        end;
end;

procedure confirmacion_4_opciones(var opcion:char;x,y:integer);
const
    opciones: set of char = ['1','2','3','0'];
begin
    if not (opcion in opciones) then
        begin
            gotoxy(x,y);
            writeln('Opcion incorrecta, vuelva a intentarlo o presione "0" para volver');
            gotoxy(x,y + 1);
            clreol;
            readln(opcion);
            confirmacion_4_opciones(opcion,x,y);
        end;
end;

procedure confirmacion_dni(var dni:string;var x,y:integer);
var
    i:integer;
    aux:boolean;
begin
    aux:=true;
    if dni <> 'n' then
        begin
            for i:=1 to length(dni) do
                begin
                    if not (dni[i] in ['0'..'9']) then
                        begin
                            aux:=false;
                        end;
                end;
            if (length(dni) <> 8) or not aux then
                begin
                    gotoxy(x,y);
                    writeln('Formato de DNI incorrecto, vuelva a intentarlo o presione "n" para volver');
                    gotoxy(x,y + 1);
                    clreol;
                    readln(dni);
                    confirmacion_dni(dni,x,y);
                end;
        end;
end;

procedure confirmacion_anio_conductor(var anio:string;var x,y:integer);

begin 
    if anio <> 'n' then
        begin 
            if (length(anio) <> 4) or (anio < '1900') or (anio > '2007') then
                begin
                    gotoxy(x,y);
                    writeln('Ingrese un año valido (1900 - 2007) o presione "n" para volver: ');
                    gotoxy(x,y + 1);
                    clreol;
                    readln(anio);
                    confirmacion_anio_conductor(anio,x,y);
                end;
        end;
end;

procedure confirmacion_sn_conductor(var opcion:char;var x,y:integer);

begin
    if (lowercase(opcion) <> 's') and (lowercase(opcion) <> 'n') and (opcion <> '0') then
        begin
            gotoxy(x,y);
            writeln('Opción incorrecta, presione "s" para confirmar, "n" para continuar o "0" para salir');
            gotoxy(x,y + 1);
            clreol;
            readln(opcion);
            confirmacion_sn_conductor(opcion,x,y);
        end;
end;


procedure confirmacion_fecha_conductor(var fecha:TFecha;var x,y:integer);
var
    opcion:char;

begin
    if lowercase(fecha.anio) <> 'n' then
        begin
            completar_fecha(fecha);
            confirmacion_anio_conductor(fecha.anio,x,y);
        
            if not (fecha_valida(fecha)) and (fecha.anio <> 'n') then
                begin
                    clrscr;
                    y:=5;
                    x:=5;
                    gotoxy(x,y);
                    writeln('Fecha invalida, presione "s" para volver a intentarlo o "n" para salir');
                    gotoxy(x,y + 1);
                    clreol;
                    readln(opcion);
                    confirmacion_sn(opcion,x,y);
                    fecha.anio:='n';
                    if lowercase(opcion) = 's' then
                        begin
                            clrscr;
                            gotoxy(x,y);
                            writeln('Dia: ');
                            gotoxy(x+5,y);
                            readln(fecha.dia);
                            y:=y+1;
                            confirmacion_dias(fecha.dia,x,y);
                            gotoxy(x,y+1);
                            writeln('Mes: ');
                            gotoxy(x+5,y+1);
                            readln(fecha.mes);
                            y:=y+2;
                            confirmacion_mes(fecha.mes,x,y);
                            gotoxy(x,y+1);
                            writeln('Año: ');
                            gotoxy(x+5,y+1);
                            readln(fecha.anio);
                            y:=y+2;
                            confirmacion_fecha_conductor(fecha,x,y);      
                        end;
                end;
        end;
end;

procedure confirmacion_fecha_conductor2(var fecha:TFecha;var x,y:integer);
var
    opcion:char;

begin
    if lowercase(fecha.anio) <> 'n' then
        begin
            completar_fecha(fecha);
            confirmacion_anio_conductor(fecha.anio,x,y);
            if not (fecha_valida(fecha)) and (fecha.anio <> 'n') then
                begin
                    gotoxy(5,y);
                    writeln('Fecha invalida, presione "s" para volver a intentarlo o "n" para salir');
                    gotoxy(5,y + 1);
                    clreol;
                    readln(opcion);
                    y:=y+1;
                    confirmacion_sn(opcion,x,y);
                    fecha.anio:='n';
                    if opcion = 's' then
                        begin
                            fecha.anio:='s';
                        end;
                end;
        end;
end;

procedure confirmacion_anio_infraccion(var anio:string;var x,y:integer);

begin
    if lowercase(anio) <> 'n' then
        begin
            if (length(anio) <> 4) or (anio < '1900') or (anio > '2024') then
                begin
                    gotoxy(x,y);
                    writeln('Ingrese un año valido (1900 - 2024) o presione "n" para volver: ');
                    gotoxy(x,y + 1);
                    clreol;
                    readln(anio);
                    confirmacion_anio_infraccion(anio,x,y);
                end;
        end;

end;

procedure confirmacion_fecha_infraccion(var fecha:TFecha;var x,y:integer);
var
    opcion:char;

begin
    if (lowercase(fecha.anio) <> 'n') then
        begin
            completar_fecha(fecha);
            confirmacion_anio_infraccion(fecha.anio,x,y);
        
            if not fecha_valida(fecha) and (lowercase(fecha.anio) <> 'n') then
                begin
                    gotoxy(x,y);
                    writeln('Fecha invalida, presione "s" para volver a intentarlo o "n" para salir');
                    gotoxy(x,y + 1);
                    clreol;
                    readln(opcion);
                    y:=y+1;
                    confirmacion_sn(opcion,x,y);
                    fecha.anio:='n';
                    if lowercase(opcion) = 's' then
                        begin   
                            clrscr;
                            y:=5;
                            x:=5;
                            clrscr;
                            gotoxy(x,y);
                            writeln('Dia: ');
                            gotoxy(x+5,y);
                            readln(fecha.dia);
                            y:=y+1;
                            confirmacion_dias(fecha.dia,x,y);
                            gotoxy(x,y+1);
                            writeln('Mes: ');
                            gotoxy(x+5,y+1);
                            readln(fecha.mes);
                            y:=y+2;
                            confirmacion_mes(fecha.mes,x,y);
                            gotoxy(x,y+1);
                            writeln('Año: ');
                            gotoxy(x+5,y+1);
                            readln(fecha.anio);
                            y:=y+2;
                             confirmacion_fecha_infraccion(fecha,x,y);
                
                            
                        end;
                end;
        end;
end;

procedure confirmacion_nombre(var nombre:string;var x,y:integer);
begin
    if (nombre = '') or (length(nombre) < 3) or (length(nombre) > 10)  or (Pos(' ',nombre) > 0) then
        begin
            gotoxy(x,y);
            writeln('Ingrese un nombre valido: ');
            gotoxy(x + 26,y);
            clreol;
            readln(nombre);
            confirmacion_nombre(nombre,x,y);
        end;
end;

procedure confirmacion_apellido(var apellido:string;var x,y:integer);
begin
   if (apellido = '') or (length(apellido) < 3) or (length(apellido) > 10) or (Pos(' ',apellido) > 0) then
        begin 
            gotoxy(x,y);
            writeln('Ingrese un apellido valido: ');
            gotoxy(x + 28,y);
            clreol;
            readln(apellido);
            confirmacion_apellido(apellido,x,y);
        end;
end;

procedure confirmacion_telefono(var telefono:string; var x,y:integer);
var
    i:integer;
    aux:boolean;

begin
    aux:=true;
    if (telefono <> 'n') and (telefono <> '') then
        begin
            for i:=1 to length(telefono) do
                begin
                    if not (telefono[i] in ['0'..'9']) then
                        begin
                            aux:=false;
                        end;
                end;
            if (length(telefono) <> 10) or not aux then
                begin
                    gotoxy(x,y);
                    writeln('Formato incorrecto, vuelva a intentarlo o presione "n" para volver');
                    gotoxy(x,y + 1);
                    writeln('El formato es 10 digitos sin espacios ni guiones');
                    gotoxy(x,y + 2);
                    clreol;
                    readln(telefono);
                    confirmacion_telefono(telefono,x,y);
                end;
        end;
end;

procedure confirmacion_infraccion(var infraccion:string;var x,y:integer);

begin
    if (infraccion <> '0') and (infraccion <> '1') and (infraccion <> '2') and (infraccion <> '3') and (infraccion <> '4') and (infraccion <> '5') and (infraccion <> '6') and
    (infraccion <> '7') and (infraccion <> '8') and (infraccion <> '9') and (infraccion <> '10') and (infraccion <> '11') and (infraccion <> '12') then
        begin
            gotoxy(x,y);
            writeln('Opcion incorrecta, vuelva a intentarlo o presione "0" para volver');
            gotoxy(x,y + 1);
            clreol;
            readln(infraccion);
            confirmacion_infraccion(infraccion,x,y);
        end;

end;

procedure confirmacion_snv(var opcion:char;var x,y:integer);

begin
    if (lowercase(opcion) <> 's') and (lowercase(opcion) <> 'n') and (lowercase(opcion) <> 'v') then
        begin
            gotoxy(x,y);
            writeln('Opcion incorrecta, presione "s" para confirmar, "n" para volver o "v" para seleccionar otra infraccion');
            gotoxy(x,y + 1);
            clreol;
            readln(opcion);
            confirmacion_sn(opcion,x,y);
        end;
end;

procedure confirmacion_email(var email:string;var x,y:integer);
var
    aux:integer;
begin
    aux:=Pos('@',email);
    if not (Trim(email) = '') then
        if (aux = 0) or (RightStr(email, 10) <> '@gmail.com') or (Length(email) <= 10) then
            begin
                gotoxy(x,y);
                writeln('Ingrese un email valido con el siguiente formato: ejemplo@gmail.com');
                gotoxy(x ,y +1);
                clreol;
                readln(email);
                confirmacion_email(email,x,y);
            end;

end;


END.





