unit def_archivo_infracciones;

INTERFACE

uses
    CRT, manejo_fechas;

CONST 
    ruta_infracciones = 'C:\ARCHIVOS\infracciones.dat';
 
TYPE

t_dato_infraccion = record
    dni: string[8];
    fecha_infraccion: TFecha;
    tipo_infraccion: string[80];
    puntos_descontar: integer;
end;

t_archivo_infracciones = file of t_dato_infraccion;

procedure abrir_archivo_infracciones(var archivo:t_archivo_infracciones);

IMPLEMENTATION

procedure abrir_archivo_infracciones(var archivo:t_archivo_infracciones);
begin
    assign(archivo, ruta_infracciones);
    {$i-}
    reset(archivo);
    {$i+}
    if ioresult <> 0 then
        rewrite(archivo);
end;


END.