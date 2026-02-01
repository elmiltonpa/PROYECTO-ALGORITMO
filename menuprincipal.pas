unit menuprincipal;

interface



uses 
    crt,arboles,def_archivo_conductores,def_archivo_infracciones,archivo_conductores,archivo_infracciones,menus,confirmacion,tipos_infraccion;

procedure menu_principal();

implementation

procedure menu_principal();



var
    opcion:char;
    arbol_dni,arbol_apynom:t_punt;
    arch_conductores:t_archivo_conductores;
    arch_infracciones:t_archivo_infracciones;
    vector_infracciones:t_vector_infracciones;


begin
    crear_arbol(arbol_dni);
    crear_arbol(arbol_apynom);
    habilitar_conductores(arch_conductores);
    pasar_conductores(arch_conductores,arbol_dni,arbol_apynom);
    inicializar_infracciones(vector_infracciones);

    textcolor(white);
    repeat
        clrscr;
        gotoxy(5,5);
        writeln('1. ABMC conductor');
        gotoxy(5,6);
        writeln('2. AC infraccion');
        gotoxy(5,7);
        writeln('3. Estadisticas');
        gotoxy(5,8);
        writeln('4. Listados');
        gotoxy(5,9);
        writeln('0. Salir');
        gotoxy(5,11);
        writeln('Seleccione opcion: ');
        gotoxy(24,11);
        readln(opcion);
        confirmacion_5_opciones(opcion,5,13);
        case opcion of
            '1': alta_conductor(arch_conductores,arbol_dni,arbol_apynom);
            '2': AMC_infraccion(arch_infracciones,arch_conductores,arbol_dni,vector_infracciones);
            '3': estadisticas(arch_infracciones,arch_conductores,arbol_dni);
            '4': listados(arch_infracciones,arch_conductores,arbol_dni,arbol_apynom);
        end;
    until opcion = '0';
end;

END.