Unit Arboles;

INTERFACE

USES
   CRT;

TYPE
T_dato_arbol = record
clave: string[50];
posicion: cardinal;
end;

T_punt = ^T_nodo;

T_nodo = record
info: T_dato_arbol;
sai,sad: T_punt;
end;

procedure crear_arbol (var raiz:T_punt);
procedure agregar (var raiz:T_punt; x:T_dato_arbol);
function arbol_vacio (raiz:T_punt): boolean;
function arbol_lleno (): boolean;
procedure eliminar_nodo(var arbol: T_punt; clave: string; posicion: cardinal);

IMPLEMENTATION

procedure crear_arbol (var raiz:T_punt);
begin
     raiz:= nil;
end;

procedure agregar (var raiz:T_punt; x:T_dato_arbol);
begin
     if raiz = nil then
     begin
        new (raiz);
        raiz^.info:= x;
        raiz^.sai:= nil;
        raiz^.sad:= nil;
     end
     else
        if raiz^.info.clave > x.clave then
           agregar(raiz^.sai,x)
        else
           agregar(raiz^.sad,x);
end;

function arbol_vacio (raiz:T_punt):boolean;
begin
     arbol_vacio:= raiz = nil;
end;

function arbol_lleno ():boolean;
begin
     arbol_lleno:= getheapstatus.totalfree < sizeof (T_nodo);
end;

function minimo(var nodo: T_punt): T_punt;
    begin
        while nodo^.sai <> nil do
            nodo := nodo^.sai;
        minimo := nodo;
    end;

procedure eliminar_nodo(var arbol: T_punt; clave: string; posicion: cardinal);
var
    temp: T_punt;
begin
    if arbol <> nil then
    begin
        if (clave < arbol^.info.clave) or ((clave = arbol^.info.clave) and (posicion < arbol^.info.posicion)) then
            eliminar_nodo(arbol^.sai, clave, posicion) 
        else if (clave > arbol^.info.clave) or ((clave = arbol^.info.clave) and (posicion > arbol^.info.posicion)) then
            eliminar_nodo(arbol^.sad, clave, posicion)
        else
        begin
            if (arbol^.sai = nil) and (arbol^.sad = nil) then
            begin
                dispose(arbol);
                arbol := nil;
            end
            else if arbol^.sai = nil then
            begin
                temp := arbol;
                arbol := arbol^.sad;
                dispose(temp);
            end
            else if arbol^.sad = nil then
            begin
                temp := arbol;
                arbol := arbol^.sai;
                dispose(temp);
            end
            else
            begin
                temp := minimo(arbol^.sad);
                arbol^.info := temp^.info;
                eliminar_nodo(arbol^.sad, temp^.info.clave, temp^.info.posicion);
            end;
        end;
    end;
end;

END.
