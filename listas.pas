Unit listas;

INTERFACE

USES
    crt,arboles;

TYPE
    T_dato_lista = t_dato_arbol;

    T_punt2 = ^nodo;

    nodo = record
    info: T_dato_lista;
    sig: T_punt2;
    end;

    T_lista = record
    cab: T_punt2;
    act: T_punt2;
    tamanio: cardinal;
    end;


procedure crear_lista(var l:T_lista);
procedure agregar_lista (var l:T_lista; x:T_dato_lista);
function tamanio (var l:T_lista):cardinal;
function lista_vacia(var l:T_lista):boolean;
function lista_llena(var l:T_lista):boolean;
function fin(var l:T_lista): boolean;
procedure primero(var l:T_lista);
procedure recuperar (var l:T_lista; var x:T_dato_lista);
procedure siguiente (var l:T_lista);
procedure buscar_lista(l:t_lista;buscado:string;var encontrado:boolean);
procedure vaciar_lista(var l: t_lista);

IMPLEMENTATION

procedure crear_lista(var l:T_lista);
begin
	l.cab := nil;
	l.tamanio := 0;
end;

procedure agregar_lista (var l:T_lista; x:T_dato_lista);
var
dir,ant:T_punt2;
begin

new (dir);
dir^.info:= x;
if (l.cab = nil) or (l.cab^.info.clave > x.clave) then
	begin
	dir^.sig:= l.cab;
	l.cab:= dir;
	end
else
	begin
	ant := l.cab;
	l.act := l.cab^.sig;
	while (l.act <> nil) and (l.act^.info.clave < x.clave) do
        begin
        	ant:= l.act;
            l.act:= l.act^.sig;
        end;
	dir^.sig:= ant^.sig;
	ant^.sig:= dir;
	end;
inc(l.tamanio);
end;

function tamanio (var l:T_lista):cardinal;
begin
	tamanio:= l.tamanio;
end;

function lista_vacia(var l:T_lista):boolean;
begin
	lista_vacia := (l.tamanio = 0);
end;

function lista_llena(var l:T_lista):boolean;
begin
	lista_llena := getheapstatus.totalfree < sizeof(nodo);
end;

function fin(var l:T_lista): boolean;
begin
	fin:= l.act = nil;
end;

procedure primero(var l:T_lista);
begin
	l.act:= l.cab
end;

procedure recuperar (var l:T_lista; var x:T_dato_lista);
begin
	x:= l.act^.info;
end;

procedure siguiente (var l:T_lista);
begin
	l.act:= l.act^.sig;
end;

procedure buscar_lista(l:t_lista;buscado:string;var encontrado:boolean);
var
	pos:byte;
	e:t_dato_lista;

begin
	primero(l);
	pos:=0;
	encontrado:= false;
	while (not fin(l)) and (pos=0) do
	begin
		recuperar(l,e);
		if e.clave = buscado then
			pos:=1
		else
			if e.clave > buscado then
				pos:=2
			else
				siguiente(l);
	end;
	if pos = 1 then
		encontrado:= true;
end;

procedure vaciar_lista(var l: t_lista);
var
    aux: T_punt2;
begin
    while not lista_vacia(l) do
    begin
        aux := l.cab; 
        l.cab := l.cab^.sig; 
        dispose(aux); 
        dec(l.tamanio); 
    end;
    l.act := nil; 
end;


END.



