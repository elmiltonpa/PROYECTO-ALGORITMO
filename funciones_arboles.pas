unit funciones_arboles;

INTERFACE

USES
    crt,arboles;


function preorden (raiz:t_punt; buscado:string ):t_punt;

IMPLEMENTATION

function preorden (raiz:t_punt; buscado:string ):t_punt;
begin
     if (raiz =  nil) then
         preorden := nil
     else
	 if (raiz^.info.clave  = buscado) then
             preorden:= raiz
         else
	     if raiz^.info.clave > buscado then
                 preorden := preorden(raiz^.sai,buscado)
             else
                 preorden := preorden(raiz^.sad,buscado);
end;


END.
