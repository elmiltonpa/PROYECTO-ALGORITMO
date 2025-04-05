unit def_archivo_conductores;

INTERFACE

USES
   CRT,manejo_fechas;

CONST 
    ruta_conductores = 'C:\ARCHIVOS\conductores.dat';
TYPE

t_dato_conductor = record
    dni: string[8];
    nombre:string[10];
    apellido:string[10];
    fecha_nacimiento: TFecha;
    telefono: string[50];
    email:string[50];
    scoring:integer;
    habilitado: boolean;
    fecha_habilitacion: TFecha;
    cantidad_reincidencias: integer;
end;

t_archivo_conductores = file of t_dato_conductor;
 
procedure abrir_archivo_conductores(var archivo:t_archivo_conductores);

implementation

procedure abrir_archivo_conductores(var archivo:t_archivo_conductores);
begin
    assign(archivo, ruta_conductores);
    {$i-}
    reset(archivo);
    {$i+}
    if ioresult <> 0 then
        rewrite(archivo);
end;


END.
