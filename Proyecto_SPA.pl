
% --- Información sobre masajes ---
masaje(1, 'Relajante', 60, 50, 'Relajacion').
masaje(2, 'Descontracturante', 90, 70, 'Terapia').
masaje(3, 'Piedras Calientes', 60, 60, 'Terapia').
masaje(4, 'Reflexología', 45, 40, 'Relajacion').
masaje(5, 'Aromaterapia', 60, 55, 'Relajacion').
masaje(6, 'Deportivo', 90, 80, 'Terapia').
masaje(7, 'Drenaje Linfático', 60, 65, 'Terapia').
masaje(8, 'Masaje Facial', 45, 45, 'Estetico').
masaje(9, 'Masaje con Chocolate', 75, 85, 'Estetico').
masaje(10, 'Masaje Hawaiano', 60, 75, 'Relajacion').
masaje(11, 'Masaje de Piedras Frías', 60, 65, 'Terapia').
masaje(12, 'Masaje Anticelulítico', 60, 70, 'Estetico').
masaje(13, 'Masaje Shiatsu', 90, 90, 'Terapia').
masaje(14, 'Masaje de Ventosas', 60, 80, 'Terapia').
masaje(15, 'Masaje Preparto', 60, 50, 'Relajacion').

% --- Información sobre ambientes (ampliados) ---
ambiente('Relajacion', 'Salón con música').
ambiente('Relajacion', 'Cabina privada').
ambiente('Relajacion', 'Baños/Jacuzzi').
ambiente('Terapia', 'Cabina privada').
ambiente('Terapia', 'Baños/Jacuzzi').
ambiente('Terapia', 'Salón con música').
ambiente('Estetico', 'Salón con música').
ambiente('Estetico', 'Cabina privada').
ambiente('Estetico', 'Baños/Jacuzzi').

% --- Lógica para interactuar con el usuario ---
preguntar_sintoma(Sintoma) :-
    Sintomas = ['dolor_de_cabeza', 'lesion_muscular', 'estres', 'paralisis', 'ansiedad', 'insomnio', 'fatiga', 'tension_muscular', 'dolor_articular', 'circulacion_deficiente'],
    new(@ventana_sintoma, dialog('Selecciona un síntoma', size(400, 400))),
    mostrar_imagen(@ventana_sintoma, dolor_cabeza),
    gui_preguntar("¿Tienes alguno de los siguientes síntomas?", Sintomas, Sintoma),
    send(@ventana_sintoma, destroy).

preguntar_tratamiento(Tratamiento) :-
    TiposTratamiento = ['Relajacion', 'Terapia', 'Estetico'],
    new(@ventana_tratamiento, dialog('Selecciona un tratamiento', size(400, 400))),
    mostrar_imagen(@ventana_tratamiento, tratamiento),
    gui_preguntar("¿Qué tipo de tratamiento prefieres?", TiposTratamiento, Tratamiento),
    send(@ventana_tratamiento, destroy).

preguntar_precio(Precio) :-
    OpcionesPrecio = ['vip', 'economico'],
    new(@ventana_precio, dialog('Selecciona tu presupuesto', size(400, 400))),
    mostrar_imagen(@ventana_precio, presupuesto),
    gui_preguntar("¿Qué precio prefieres?", OpcionesPrecio, Precio),
    send(@ventana_precio, destroy).

preguntar_ambiente(Tratamiento, Ambiente) :-
    writeln('Tratamiento recibido:'),
    findall(A, ambiente(Tratamiento, A), Ambientes),
    writeln(Ambientes),
    new(@ventana_ambiente, dialog('Selecciona un ambiente', size(400, 400))),
    gui_preguntar("¿Cuál ambiente prefieres?", Ambientes, Ambiente),
    send(@ventana_ambiente, destroy).


filtrar_masaje(Sintoma, Tratamiento, Precio, Ambiente, Recomendacion) :-
    findall(Nombre, (
        masaje(_, Nombre, _, Costo, Tratamiento),
        validar_precio(Precio, Costo),
        validar_sintoma(Sintoma, Tratamiento),
        ambiente(Tratamiento, Ambiente)
    ), Recomendacion).

% Validación de precio
validar_precio(vip, Costo) :- Costo >= 60.
validar_precio(economico, Costo) :- Costo < 60.

% Validación de síntomas y tratamiento
validar_sintoma(dolor_de_cabeza, 'Relajacion').
validar_sintoma(dolor_de_cabeza, 'Terapia').
validar_sintoma(dolor_de_cabeza, 'Estetico').
validar_sintoma(lesion_muscular, 'Relajacion').
validar_sintoma(lesion_muscular, 'Terapia').
validar_sintoma(lesion_muscular, 'Estetico').
validar_sintoma(estres, 'Relajacion').
validar_sintoma(estres, 'Terapia').
validar_sintoma(estres, 'Estetico').
validar_sintoma(paralisis, 'Terapia').
validar_sintoma(paralisis, 'Relajacion').
validar_sintoma(paralisis, 'Estetico').
validar_sintoma(ansiedad, 'Relajacion').
validar_sintoma(ansiedad, 'Estetico').
validar_sintoma(ansiedad, 'Relajacion').
validar_sintoma(insomnio, 'Relajacion').
validar_sintoma(insomnio, 'Terapia').
validar_sintoma(insomnio, 'Estetico').
validar_sintoma(fatiga, 'Relajacion').
validar_sintoma(fatiga, 'Terapia').
validar_sintoma(fatiga, 'Estetico').
validar_sintoma(tension_muscular, 'Terapia').
validar_sintoma(tension_muscular, 'Relajacion').
validar_sintoma(tension_muscular, 'Estetico').
validar_sintoma(dolor_articular, 'Terapia').
validar_sintoma(dolor_articular, 'Relajacion').
validar_sintoma(dolor_articular, 'Estetico').
validar_sintoma(contractura, 'Terapia').
validar_sintoma(contractura, 'Relajacion').
validar_sintoma(contractura, 'Estetico').
validar_sintoma(imflamacion, 'Terapia').
validar_sintoma(imflamacion, 'Relajacion').
validar_sintoma(imflamacion, 'Estetico').
validar_sintoma(circulacion_deficiente, 'Estetico').
validar_sintoma(circulacion_deficiente, 'Terapia').
validar_sintoma(circulacion_deficiente, 'Relajacion').


% --- Información sobre terapeutas ---
terapeuta(1, 'Laura', femenino, 5, [1, 2, 5, 10, 14]).
terapeuta(2, 'Carlos', masculino, 8, [2, 3, 6, 11, 13]).
terapeuta(3, 'Ana', femenino, 4, [1, 4, 7, 8, 9]).
terapeuta(4, 'Miguel', masculino, 6, [3, 5, 6, 10, 14]).
terapeuta(5, 'Sofía', femenino, 7, [2, 4, 7, 12, 13]).
terapeuta(6, 'Isabel', femenino, 9, [1, 3, 8, 15, 7]).
terapeuta(7, 'Luis', masculino, 3, [4, 6, 12, 14, 5]).
terapeuta(8, 'Raúl', masculino, 5, [7, 10, 11, 15, 9]).
terapeuta(9, 'Paola', femenino, 10, [1, 2, 3, 6, 9]).
terapeuta(10, 'Juan', masculino, 7, [5, 8, 12, 4, 13]).


% --- Información sobre clientes ---
cliente(1, 'María', 28, femenino, [1, 5, 8]).
cliente(2, 'Javier', 35, masculino, [2, 6, 3]).
cliente(3, 'Lucía', 42, femenino, [3, 7, 4]).
cliente(4, 'Pedro', 30, masculino, [1, 6, 5, 10]).
cliente(5, 'Sandra', 50, femenino, [2, 4, 7]).
cliente(6, 'Antonio', 29, masculino, [4, 5, 11]).
cliente(7, 'Sofía', 37, femenino, [3, 7, 12]).
cliente(8, 'Ricardo', 32, masculino, [6, 10, 13]).
cliente(9, 'Carmen', 41, femenino, [7, 2, 9]).
cliente(10, 'Esteban', 25, masculino, [8, 14, 12]).


% --- Horarios de terapeutas ---
horario(1, 'Lunes', 9, 17).
horario(1, 'Miércoles', 9, 15).
horario(1, 'Viernes', 10, 14).
horario(2, 'Martes', 10, 18).
horario(2, 'Jueves', 9, 13).
horario(3, 'Miércoles', 11, 19).
horario(3, 'Viernes', 9, 17).
horario(4, 'Lunes', 9, 17).
horario(4, 'Martes', 10, 14).
horario(5, 'Domingo', 9, 16).
horario(5, 'Sábado', 9, 18).
horario(6, 'Lunes', 8, 16).
horario(6, 'Jueves', 11, 18).
horario(7, 'Martes', 9, 15).
horario(7, 'Jueves', 9, 17).
horario(8, 'Viernes', 12, 18).
horario(8, 'Sábado', 10, 16).
horario(9, 'Domingo', 10, 15).
horario(9, 'Lunes', 9, 17).
horario(10, 'Martes', 9, 15).
horario(10, 'Jueves', 10, 16).


% --- Registro de masajes realizados a los clientes ---

% registro_masaje(ClienteID, MasajeID, TerapeutaID, Dia, Hora).
registro_masaje(1, 1, 1, 'Lunes', 10).
registro_masaje(2, 2, 3, 'Martes', 12).
registro_masaje(3, 3, 2, 'Miércoles', 9).
registro_masaje(4, 4, 5, 'Jueves', 15).
registro_masaje(5, 5, 4, 'Viernes', 11).
registro_masaje(6, 6, 3, 'Lunes', 14).
registro_masaje(7, 7, 6, 'Martes', 9).
registro_masaje(8, 8, 9, 'Miércoles', 16).
registro_masaje(9, 9, 7, 'Jueves', 13).
registro_masaje(10, 10, 8, 'Viernes', 12).
registro_masaje(1, 11, 1, 'Lunes', 17).
registro_masaje(2, 12, 5, 'Martes', 10).
registro_masaje(3, 13, 4, 'Miércoles', 11).
registro_masaje(4, 14, 6, 'Jueves', 16).
registro_masaje(5, 15, 7, 'Viernes', 14).


% --- Reglas ---

% Buscar masajes por tipo
buscar_masajes_por_tipo(Tipo, Masajes) :-
    findall(Nombre, masaje(_, Nombre, _, _, Tipo), Masajes).


% Buscar terapeutas disponibles para un tipo de masaje
buscar_terapeutas_por_tipo(Tipo, Terapeutas) :-
    findall(Nombre, (
        terapeuta(ID, Nombre, _, _, Masajes),
        masaje(MasajeID, _, _, _, Tipo),
        member(MasajeID, Masajes)
    ), Terapeutas).


% Consultar disponibilidad de un terapeuta en un día específico
disponibilidad_terapeuta(TerapeutaID, Dia, Hora, Disponible) :-
    horario(TerapeutaID, Dia, HoraInicio, HoraFin),
    (Hora >= HoraInicio, Hora =< HoraFin -> Disponible = 'Sí'; Disponible = 'No').


% Calcular el costo total de una sesión múltiple

calcular_costo_total(MasajesIDs, CostoTotal) :-
    findall(Precio, (
        member(ID, MasajesIDs),
        masaje(ID, _, _, Precio, _)
    ), Precios),
    sum_list(Precios, CostoTotal),
    format('Costo total de la sesión: ~w\n', [CostoTotal]), % Muestra el costo total en la consola

    % Crear un mensaje para la ventana
    format(atom(Mensaje), 'Costo total de la sesión: ~w', [CostoTotal]),

    % Crear y mostrar la ventana
    new(Ventana, dialog('Costo Total de la Sesión', size(400, 200))),
    new(Texto, label(nombre, Mensaje, font('times', 'roman', 14))),
    send(Ventana, display, Texto, point(20, 50)),
    send(Ventana, open_centered).



% Reglas adicionales para la gestión de reservas y horarios

% Reservar un masaje
reservar_masaje(ClienteID, MasajeID, TerapeutaID, Dia, Hora) :-
    cliente(ClienteID, NombreCliente, _, _, _),
    masaje(MasajeID, NombreMasaje, Duracion, Precio, _),
    terapeuta(TerapeutaID, NombreTerapeuta, _, _, _),
    disponibilidad_terapeuta(TerapeutaID, Dia, Hora, 'Sí'),
    format('Reserva confirmada para ~w: ~w con el terapeuta ~w el ~w a las ~w horas. Duración: ~w minutos. Precio: ~w€.\n',
           [NombreCliente, NombreMasaje, NombreTerapeuta, Dia, Hora, Duracion, Precio]).


% Buscar disponibilidad de un terapeuta en toda la semana
disponibilidad_semanal(TerapeutaID) :-
    findall((Dia, Hora), horario(TerapeutaID, Dia, HoraInicio, HoraFin), Horarios),
    format('Horarios disponibles para el terapeuta ~w: ~w\n', [TerapeutaID, Horarios]).

% Consultar todos los masajes
todos_los_masajes :-
    findall(Nombre, masaje(_, Nombre, _, _, _), Masajes),
    format('Masajes disponibles: ~w\n', [Masajes]), % Muestra los masajes en la consola

    % Crear una representación textual para la ventana
    atomic_list_concat(Masajes, ', ', MasajesTexto),
    format(atom(Mensaje), 'Masajes disponibles: ~w', [MasajesTexto]),

    % Crear y mostrar la ventana
    new(Ventana, dialog('Masajes Disponibles', size(400, 300))),
    new(Texto, label(nombre, Mensaje, font('times', 'roman', 14))),
    send(Ventana, display, Texto, point(20, 50)),
    send(Ventana, open_centered).


% Consultar todos los terapeutas
todos_los_terapeutas :-
    findall(Nombre, terapeuta(_, Nombre, _, _, _), Terapeutas),
    format('Terapeutas disponibles: ~w\n', [Terapeutas]), % Muestra los terapeutas en la consola

    % Crear una representación textual para la ventana
    atomic_list_concat(Terapeutas, ', ', TerapeutasTexto),
    format(atom(Mensaje), 'Terapeutas disponibles: ~w', [TerapeutasTexto]),

    % Crear y mostrar la ventana
    new(Ventana, dialog('Terapeutas Disponibles', size(400, 300))),
    new(Texto, label(nombre, Mensaje, font('times', 'roman', 14))),
    send(Ventana, display, Texto, point(20, 50)),
    send(Ventana, open_centered).

% Consultar todas las reservas de un cliente
todas_las_reservas_cliente(ClienteID) :-
    findall((MasajeID, TerapeutaID, Dia, Hora), (
        reservar_masaje(ClienteID, MasajeID, TerapeutaID, Dia, Hora).

% --- Estadísticas de masajes realizados ---

% Número de masajes realizados por cliente
numero_masajes_realizados(ClienteID, Numero) :-
    findall(MasajeID, registro_masaje(ClienteID, MasajeID, _, _, _), Masajes),
    length(Masajes, Numero).


% Número de masajes realizados por terapeuta
numero_masajes_por_terapeuta(TerapeutaID, Numero) :-
    findall(MasajeID, registro_masaje(_, MasajeID, TerapeutaID, _, _), Masajes),
    length(Masajes, Numero).



% Costo total gastado por un cliente
gasto_total_cliente(ClienteID, GastoTotal) :-
    findall(Precio, (
        registro_masaje(ClienteID, MasajeID, _, _, _),
        masaje(MasajeID, _, _, Precio, _)
    ), Precios),
    sum_list(Precios, GastoTotal).



% Promedio de precios de los masajes realizados por un cliente
promedio_precio_cliente(ClienteID, Promedio) :-
    findall(Precio, (
        registro_masaje(ClienteID, MasajeID, _, _, _),
        masaje(MasajeID, _, _, Precio, _)
    ), Precios),
    length(Precios, N),
    sum_list(Precios, Suma),
    (N > 0 -> Promedio is Suma / N; Promedio is 0).



% Masajes más populares (por número de veces realizados)
masajes_mas_populares(MasajesPopulares) :-
    findall(MasajeID, registro_masaje(_, MasajeID, _, _, _), TodosLosMasajes),
    listar_frecuencia(TodosLosMasajes, Frecuencias),
    sort(2, @>=, Frecuencias, Ordenados),
    obtener_masajes(Ordenados, MasajesPopulares).



listar_frecuencia(Lista, Frecuencias) :-
    setof(X, member(X, Lista), ListaSinRepetir),
    listar_frecuencia_aux(ListaSinRepetir, Lista, Frecuencias).



listar_frecuencia_aux([], _, []).
listar_frecuencia_aux([X|Xs], Lista, [(X, Count)|Rest]) :-
    count_occurrences(X, Lista, Count),
    listar_frecuencia_aux(Xs, Lista, Rest).



count_occurrences(_, [], 0).
count_occurrences(X, [X|Xs], Count) :-
    count_occurrences(X, Xs, Rest),
    Count is Rest + 1.
count_occurrences(X, [Y|Xs], Count) :-
    X \= Y,
    count_occurrences(X, Xs, Count).



obtener_masajes([], []).
obtener_masajes([(MasajeID, _)|Rest], [MasajeNombre|MasajesRest]) :-
    masaje(MasajeID, MasajeNombre, _, _, _),
    obtener_masajes(Rest, MasajesRest).



% --- Estadísticas globales del spa ---

% Total de ingresos generados
ingresos_totales(Ingresos) :-
    findall(Precio, (
        registro_masaje(_, MasajeID, _, _, _),
        masaje(MasajeID, _, _, Precio, _)
    ), Precios),
    sum_list(Precios, Ingresos).

% Ingresos totales generados
ingresos_totales :-
    findall(Precio, (registro_masaje(_, MasajeID, _, _, _), masaje(MasajeID, _, _, Precio, _)), Precios),
    sum_list(Precios, Ingresos),
    atom_concat('Ingresos totales: $', Ingresos, Mensaje),
    new(Ventana, dialog('Ingresos Totales', size(400, 200))),
    new(Texto, label(nombre, Mensaje, font('times', 'roman', 18))),
    send(Ventana, display, Texto, point(50, 50)),
    send(Ventana, open_centered),
    send(Ventana, transient_for, @main), % Asegurar relación con la ventana principal
    send(Ventana, modal, transient).


% Promedio de precio por masaje
promedio_precio_masajes(Promedio) :-
    findall(Precio, masaje(_, _, _, Precio, _), Precios),
    length(Precios, N),
    sum_list(Precios, Suma),
    (N > 0 -> Promedio is Suma / N; Promedio is 0).


% Promedio de precio por masaje
promedio_precio_masajes :-
    findall(Precio, masaje(_, _, _, Precio, _), Precios),
    length(Precios, N),
    sum_list(Precios, Suma),
    Promedio is (N > 0 -> Suma / N ; 0),
    format(atom(Mensaje), 'Promedio de Precio: $~2f', [Promedio]),
    new(Ventana, dialog('Promedio de Precio', size(400, 200))),
    new(Texto, label(nombre, Mensaje, font('times', 'roman', 18))),
    send(Ventana, display, Texto, point(50, 50)),
    send(Ventana, open_centered),
    send(Ventana, transient_for, @main),
    send(Ventana, modal, transient).


% Cantidad de masajes realizados en un día específico
cantidad_masajes_por_dia(Dia, Cantidad) :-
    findall(_, registro_masaje(_, _, _, Dia, _), Masajes),
    length(Masajes, Cantidad).

% Cantidad de masajes por día
cantidad_masajes_por_dia :-
    new(VentanaDia, dialog('Cantidad de Masajes por Día', size(400, 200))),
    new(TextoDia, label(nombre, 'Ingrese el día (YYYY-MM-DD):', font('times', 'roman', 18))),
    new(Input, text_item('', '')),
    send(VentanaDia, append, TextoDia),
    send(VentanaDia, append, Input),
    send(VentanaDia, append, button('Aceptar', message(@prolog, procesar_cantidad_masajes_por_dia, Input?selection))),
    send(VentanaDia, open_centered).

procesar_cantidad_masajes_por_dia(Dia) :-
    findall(_, registro_masaje(_, _, _, Dia, _), Masajes),
    length(Masajes, Cantidad),
    atom_concat('Cantidad de masajes en ', Dia, MensajeDia),
    atom_concat(MensajeDia, ': ', TempMensaje),
    atom_concat(TempMensaje, Cantidad, Mensaje),
    new(Ventana, dialog('Resultado', size(400, 200))),
    new(Texto, label(nombre, Mensaje, font('times', 'roman', 18))),
    send(Ventana, display, Texto, point(50, 50)),
    send(Ventana, open_centered),
    send(Ventana, transient_for, @main),
    send(Ventana, modal, transient).

% --- Consultas y reglas adicionales ---

% Ver todos los masajes realizados por un cliente
ver_masajes_realizados_cliente(ClienteID) :-
    findall((MasajeID, TerapeutaID, Dia, Hora), registro_masaje(ClienteID, MasajeID, TerapeutaID, Dia, Hora), Masajes),
    format('Masajes realizados por el cliente ~w: ~w\n', [ClienteID, Masajes]).

% Ver masajes realizados por cliente
ver_masajes_realizados_cliente :-
    new(VentanaCliente, dialog('Masajes por Cliente', size(400, 200))),
    new(TextoCliente, label(nombre, 'Ingrese ID del Cliente:', font('times', 'roman', 18))),
    new(Input, text_item('', '')),
    send(VentanaCliente, append, TextoCliente),
    send(VentanaCliente, append, Input),
    send(VentanaCliente, append, button('Aceptar', message(@prolog, procesar_masajes_cliente, Input?selection))),
    send(VentanaCliente, open_centered).

procesar_masajes_cliente(ClienteID) :-
    findall((MasajeID, TerapeutaID, Dia, Hora), registro_masaje(ClienteID, MasajeID, TerapeutaID, Dia, Hora), Masajes),
    format(atom(Mensaje), 'Masajes realizados: ~w', [Masajes]),
    new(Ventana, dialog('Resultado', size(400, 200))),
    new(Texto, label(nombre, Mensaje, font('times', 'roman', 18))),
    send(Ventana, display, Texto, point(50, 50)),
    send(Ventana, open_centered),
    send(Ventana, transient_for, @main),
    send(Ventana, modal, transient).


% Ver el historial completo de un terapeuta
ver_historial_terapeuta(TerapeutaID) :-
    findall((ClienteID, MasajeID, Dia, Hora), registro_masaje(ClienteID, MasajeID, TerapeutaID, Dia, Hora), Historial),
    format('Historial de masajes del terapeuta ~w: ~w\n', [TerapeutaID, Historial]).

% Mostrar Historial de un Terapeuta
ver_historial_terapeuta :-
    new(@ventana_terapeuta, dialog('Historial de Terapeuta', size(400, 200))),
    new(@texto_terapeuta, label(nombre, 'Ingrese ID del Terapeuta:', font('times', 'roman', 18))),
    send(@ventana_terapeuta, display, @texto_terapeuta, point(50, 50)),
    send(@ventana_terapeuta, open_centered),
    get(@ventana_terapeuta, confirm, TerapeutaID),
    (TerapeutaID \= @nil ->
        ver_historial_terapeuta(TerapeutaID),
        new(@resultado_terapeuta, label(nombre, 'Historial de masajes: ...', font('times', 'roman', 18))),
        send(@ventana_terapeuta, display, @resultado_terapeuta, point(50, 100))
    ;
        mostrar_mensaje('ID de Terapeuta no válido')).

% Mostrar Reservas Totales
ver_reservas_totales :-
    findall((ClienteID, MasajeID, TerapeutaID, Dia, Hora), registro_masaje(ClienteID, MasajeID, TerapeutaID, Dia, Hora), Reservas),
    new(@ventana_reservas, dialog('Reservas Totales', size(400, 200))),
    new(@texto_reservas, label(nombre, 'Reservas realizadas: ' + Reservas, font('times', 'roman', 18))),
    send(@ventana_reservas, display, @texto_reservas, point(50, 50)),
    send(@ventana_reservas, open_centered).

% --- Consultas adicionales para expansión ---

% Ver todos los masajes de un tipo específico
ver_masajes_por_tipo(Tipo) :-
    findall(MasajeID, masaje(MasajeID, _, _, _, Tipo), Masajes),
    format('Masajes del tipo ~w: ~w\n', [Tipo, Masajes]).



% Ver el historial de masajes de un cliente específico
ver_historial_cliente(ClienteID) :-
    findall((MasajeID, TerapeutaID, Dia, Hora), registro_masaje(ClienteID, MasajeID, TerapeutaID, Dia, Hora), Historial),
    format('Historial de masajes del cliente ~w: ~w\n', [ClienteID, Historial]).



% Ver la cantidad total de masajes realizados en el spa
cantidad_total_masajes :-
    findall(_, registro_masaje(_, _, _, _, _), TodosLosMasajes),
    length(TodosLosMasajes, Cantidad),
    format('Cantidad total de masajes realizados: ~w\n', [Cantidad]).


% PARTE GRAFICA - INTERFACES

% Librerias gráficas
:- use_module(library(pce)).
:- pce_image_directory('./imagenes').
:- use_module(library(pce_style_item)).
:- dynamic color/2.

% Recursos de imágenes
resource(img_principal, image, image('InterfazPrincipal.jpg')).
resource(portada, image, image('Portada.jpeg')).
resource(dolor_cabeza, image, image('dolor_cabeza.jpeg')).
resource(lesion_muscular, image, image('lesion_muscular.jpg')).
resource(e
         stres, image, image('estres.jpg')).
resource(paralisis, image, image('paralisis.jpg')).
resource(ansiedad, image, image('ansiedad.jpg')).
resource(insomnio, image, image('insomnio.jpg')).
resource(fatiga, image, image('fatiga.jpg')).
resource(tension_muscular, image, image('tension_muscular.jpg')).
resource(dolor_articular, image, image('dolor_articular.jpg')).
resource(contractura, image, image('contractura.jpg')).
resource(inflamacion, image, image('inflamacion.jpg')).
resource(circulacion_deficiente, image, image('circulacion_deficiente.jpg')).
resource(tratamiento, image, image('tratamiento.jpg')).
resource(presupuesto, image, image('presupuesto.jpg')).
resource(salon_musica, image, image('salon_musica.jpg')).
resource(cabina_privada, image, image('cabina_privada.jpg')).
resource(baños, image, image('baños.jpg')).

% Funciones para mostrar imágenes
 mostrar_imagen(Pantalla, Imagen) :- new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(100,80)).


 mostrar_imagen_tratamiento(Pantalla, Imagen) :-new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(20,100)).
 nueva_imagen(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(0,0)).

imagen_pregunta(Pantalla, Imagen) :-
    new(Figura, figure),
    new(Bitmap, bitmap(resource(Imagen), @on)),
    send(Bitmap, name, 1),
    send(Figura, display, Bitmap),
    send(Figura, status, 1),
    send(Pantalla, display, Figura, point(500, 60)).

% Interfaz principal
crea_interfaz_inicio :-
    new(@interfaz, dialog('Bienvenido al Sistema Asistente de Masajes SPA', size(300, 400))),
    mostrar_imagen(@interfaz, portada),
    new(BotonComenzar, button('COMENZAR',
        and(message(@prolog, interfaz_principal),
            and(message(@interfaz, destroy), message(@interfaz, free))))),
    new(BotonSalir, button('SALIR',
        and(message(@interfaz, destroy), message(@interfaz, free)))),
    send(@interfaz, append, BotonComenzar),
    send(@interfaz, append, BotonSalir),
    send(@interfaz, open_centered).

:- crea_interfaz_inicio.

% Interfaz (principal)
interfaz_principal :-
    new(@main, dialog('Sistema Experto Asistente de Masajes SPA', size(1000, 1000))),  % Crear la ventana principal
    new(@texto, label(nombre, 'El masaje para su tratamiento es:', font('times', 'roman', 18))),  % Etiqueta de texto
    new(@resp1, label(nombre, '', font('times', 'roman', 22))),  % Etiqueta de respuesta (vacía inicialmente)
    new(@salir, button('SALIR', and(message(@main, destroy), message(@main, free)))),  % Botón para salir
    new(@boton, button('Iniciar Asesoría', message(@prolog, iniciar_asesoria))),  % Botón para iniciar asesoría
    new(@boton_todos_masajes, button('Ver Masajes', message(@prolog, todos_los_masajes))),
    new(@boton_todos_terapeutas, button('Ver Terapeutas', message(@prolog, todos_los_terapeutas))),
    new(@boton_buscar_tipo, button('Buscar Masajes por Tipo', message(@prolog, buscar_masajes_por_tipo_cliente))),
    new(@boton_disponibilidad, button('Ver Disponibilidad Terapeutas', message(@prolog, disponibilidad_terapeutas_cliente))),
    new(@boton_ingresos_totales, button('Ingresos Totales', message(@prolog, ingresos_totales))),
    new(@boton_calcular_costo_total, button('Costo Total', message(@prolog, calcular_costo_total))),
    new(@boton_promedio_precio, button('Promedio de Precio', message(@prolog, promedio_precio_masajes))),
    new(@boton_cantidad_masajes, button('Cantidad de Masajes por Día', message(@prolog, cantidad_masajes_por_dia))),
    new(@boton_masajes_cliente, button('Masajes por Cliente', message(@prolog, ver_masajes_realizados_cliente))),
    new(@boton_historial_terapeuta, button('Historial de Terapeuta', message(@prolog, ver_historial_terapeuta))),
    new(@boton_reservas_totales, button('Reservas Totales', message(@prolog, ver_reservas_totales))),

    nueva_imagen(@main, img_principal),  % Cargar imagen en la ventana principal

      % Posicionar elementos en la ventana principal
    send(@main, display, @texto, point(210, 150)),         % Etiqueta de texto
    send(@main, display, @resp1, point(545, 150)),        % Etiqueta de respuesta

    % Botones primera fila
    send(@main, display, @boton, point(150, 400)),       % Botón Iniciar Asesoría
    send(@main, display, @boton_todos_masajes, point(350, 400)), % Botón Recomendar Masajes
    send(@main, display, @boton_ingresos_totales, point(550, 400)),    % Botón Ingresos Totales

    % Botones segunda fila
    send(@main, display, @boton_cantidad_masajes, point(150, 470)),    % Botón Cantidad de Masajes por Día
    send(@main, display, @boton_masajes_cliente, point(350, 470)),     % Botón Masajes por Cliente
    send(@main, display, @boton_todos_terapeutas, point(550, 470)),


   % send(@main, display, @boton_calcular_costo_total, point(50, 450)),
    send(@main, display, @salir, point(700, 470)),                    % Botón Salir

    % Botones tercera fila
    %send(@main, display, @boton_historial_terapeuta, point(50, 450)), % Botón Historial de Terapeuta
    %send(@main, display, @boton_reservas_totales, point(250, 450)),    % Botón Reservas Totales

    send(@main, open_centered).  % Abrir la ventana centrada

% Función para buscar masajes por tipo y mostrar los resultados
buscar_masajes_por_tipo_cliente :-
    Tipo = 'Relajante',  % Este tipo puede ser modificado según sea necesario
    buscar_masajes_por_tipo(Tipo, Masajes),
    new(@ventana_masajes, dialog('Masajes por Tipo', size(400, 200))),
    new(@texto_masajes, label(nombre, 'Masajes encontrados: ' + Masajes, font('times', 'roman', 18))),
    send(@ventana_masajes, display, @texto_masajes, point(50, 50)),
    send(@ventana_masajes, open_centered).

% Función para mostrar la disponibilidad de terapeutas para un tipo de masaje
disponibilidad_terapeutas_cliente :-
    Tipo = 'Relajante',  % Este tipo puede ser modificado según sea necesario
    buscar_terapeutas_por_tipo(Tipo, Terapeutas),
    new(@ventana_terapeutas, dialog('Terapeutas Disponibles', size(400, 200))),
    new(@texto_terapeutas, label(nombre, 'Terapeutas disponibles: ' + Terapeutas, font('times', 'roman', 18))),
    send(@ventana_terapeutas, display, @texto_terapeutas, point(50, 50)),
    send(@ventana_terapeutas, open_centered).


% Predicados para interactuar
gui_preguntar(Pregunta, Opciones, Respuesta) :-
    new(Di, dialog('Selección')),
    send(Di, append, label(texto, Pregunta)),
    % Mostrar la imagen en el cuadro específico de la ventana
    %imagen_pregunta(Di, Pregunta),
    forall(member(Opcion, Opciones),
        send(Di, append, button(Opcion, message(Di, return, Opcion)))),
    send(@main, default_button, @boton),
    send(Di, open_centered),
    get(Di, confirm, Resp),
    free(Di),
    Respuesta = Resp.

% Iniciar asesoría
iniciar_asesoria :-
    preguntar_sintoma(Sintoma),
    preguntar_tratamiento(Tratamiento),
    preguntar_precio(Precio),
    preguntar_ambiente(Tratamiento, Ambiente),
    filtrar_masaje(Sintoma,Tratamiento, Precio, Ambiente, OpcionesFiltradas),
    (   OpcionesFiltradas \= []
    ->  seleccionar_opcion(OpcionesFiltradas)
    ;   seleccionar_opcion(['No hay disponibles'])).

% Procesar opción seleccionada
procesar_opcion(Opcion) :-
    writeln('Opción seleccionada:'),
    writeln(Opcion).

% Mostrar mensajes informativos
mostrar_mensaje(Mensaje) :-
    new(Di, dialog('Mensaje')),
    send(Di, append, label(texto, Mensaje)),
    send(Di, append, button('OK', message(Di, destroy))),
    send(Di, open_centered).

% Seleccionar opción de la lista filtrada
seleccionar_opcion(Opciones) :-
    new(Di, dialog('Seleccione una opción')),
    new(Menu, menu(choices, cycle)),
    forall(member(Opcion, Opciones), send(Menu, append, Opcion)),
    send(Di, append, Menu),
    send(Di, append, button('OK', message(Di, return, Menu?selection))),
    send(Di, open_centered),
    get(Di, confirm, Seleccion),
    send(Di, destroy),
    mostrar_seleccion(Seleccion).

% Mostrar la selección en la interfaz principal y en consola
mostrar_seleccion(Seleccion) :-
    writeln('Opción seleccionada:'),
    writeln(Seleccion),
    send(@resp1, selection, Seleccion).













