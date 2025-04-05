unit tipos_infraccion;



INTERFACE

USES
    crt;

CONST
    N = 11;

type
        t_infraccion = record
            tipo_infraccion:string[70];
            puntos_descontar:integer;
        end;

        t_vector_infracciones = array[0..N] of t_infraccion;

procedure inicializar_infracciones(var v:t_vector_infracciones);

IMPLEMENTATION
    
procedure inicializar_infracciones(var v:t_vector_infracciones);
    begin
        v[0].tipo_infraccion := 'CIRCULAR SIN EL CINTURON DE SEGURIDAD';
        v[0].puntos_descontar := 4;
        v[1].tipo_infraccion := 'CIRCULAR SIN LA REVISION TECNICA OBLIGATORIA (RTO)';
        v[1].puntos_descontar := 4;
        v[2].tipo_infraccion := 'CRUZAR SEMAFORO EN ROJO';
        v[2].puntos_descontar := 5;
        v[3].tipo_infraccion := 'NO USAR CASCO';
        v[3].puntos_descontar := 5;
        v[4].tipo_infraccion := 'CONDUCIR UTILIZANDO EL CELULAR';
        v[4].puntos_descontar := 5;
        v[5].tipo_infraccion := 'CIRCULACION EN SENTIDO CONTRARIO';
        v[5].puntos_descontar := 5;
        v[6].tipo_infraccion := 'NO RESPETAR LOS LIMITES DE VELOCIDAD (MENOS DEL 30%)';
        v[6].puntos_descontar := 5;
        v[7].tipo_infraccion := 'NO RESPETAR LOS LIMITES DE VELOCIDAD (MAS DEL 30%)';
        v[7].puntos_descontar := 10;
        v[8].tipo_infraccion := 'CONDUCIR BAJO LOS EFECTOS DEL ALCOHOL, ESTUPEFACIENTES O MEDICAMENTOS';
        v[8].puntos_descontar := 10;
        v[9].tipo_infraccion := 'CIRCULAR EN CONTRAMANO';
        v[9].puntos_descontar := 10;
        v[10].tipo_infraccion := 'CONDUCCION PELIGROSA';
        v[10].puntos_descontar := 10;
        v[11].tipo_infraccion := 'PARTICIPAR Y/U ORGANIZAR PICADAS EN LA VIA PUBLICA';
        v[11].puntos_descontar := 20;
    end;
    

END.