# FiltroSQL_GourtmetDelight
Bienvenidos al proyecto de creación de la base de datos para nuestro restaurante, Gourmet
Delight. Como propietario de este restaurante, necesito una solución integral para gestionar la
información relacionada con nuestros clientes, menús, pedidos y los detalles de cada pedido. La
base de datos será crucial para organizar y mantener nuestros registros de manera eficiente,
permitiéndonos brindar un mejor servicio y tomar decisiones informadas para el crecimiento del
negocio.

![](https://github.com/DanyelleGiraldo/FiltroSQL_GourtmetDelight/blob/main/Diagrama/DiagramaERGourtmetDelight.png)

## Consultas SQL sobre una base de datos de restaurante

1. **Obtener la lista de todos los menús con sus precios:**
    - **Enunciado:**
        Obtener la lista de todos los menús con sus precios.
    - **Solución:**
        ```sql
        SELECT nombre, precio FROM menus;
        ```
    - **Resultado:**
      ```
        +-----------------+--------+
        | nombre          | precio |
        +-----------------+--------+
        | Ensalada César  |  12.50 |
        | Sopa de Tomate  |   8.75 |
        | Filete de Res   | 123.12 |
        | Pasta Alfredo   | 980.00 |
        | Tarta de Queso  |   7.50 |
        | Café Americano  |   3.00 |
        +-----------------+--------+
      ```
    - **Explicación:**
        Esta consulta selecciona el nombre y el precio de todos los menús disponibles en la tabla `menus`.

2. **Encontrar todos los pedidos realizados por el cliente 'Juan Perez':**
    - **Enunciado:**
        Encontrar todos los pedidos realizados por el cliente 'Juan Perez'.
    - **Solución:**
        ```sql
        SELECT p.id_pedido, p.fecha, p.total 
        FROM pedidos p 
        JOIN clientes c ON c.id_cliente = p.id_cliente 
        WHERE c.nombre = 'Juan Perez';
        ```
     - **Resultado:**
      ```
        +-----------+------------+-------+
        | id_pedido | fecha      | total |
        +-----------+------------+-------+
        |         1 | 2024-05-15 | 40.00 |
        |         2 | 2024-06-01 | 25.50 |
        +-----------+------------+-------+
      ```
    - **Explicación:**
        Esta consulta recupera los pedidos, incluyendo el identificador del pedido, la fecha y el total, realizados por el cliente 'Juan Perez'.

3. **Listar los detalles de todos los pedidos, incluyendo el nombre del menú, cantidad y precio unitario:**
    - **Enunciado:**
        Listar los detalles de todos los pedidos, incluyendo el nombre del menú, cantidad y precio unitario.
    - **Solución:**
        ```sql
        SELECT dp.id_pedido AS PedidoID, m.nombre, dp.cantidad, dp.precio_unitario 
        FROM detallespedidos dp
        JOIN menus m ON dp.id_menu = m.id_menu;
        ```
     - **Resultado:**
          ```
            +----------+-----------------+----------+-----------------+
            | PedidoID | nombre          | cantidad | precio_unitario |
            +----------+-----------------+----------+-----------------+
            |        1 | Ensalada César  |        1 |           12.50 |
            |        3 | Ensalada César  |        1 |           12.50 |
            |        5 | Ensalada César  |        2 |           12.50 |
            |        7 | Ensalada César  |        2 |           12.50 |
            |       10 | Ensalada César  |        1 |           12.50 |
            |       13 | Ensalada César  |        2 |           12.50 |
            |       16 | Ensalada César  |        1 |           12.50 |
            |        2 | Sopa de Tomate  |        1 |            8.75 |
            |        6 | Sopa de Tomate  |        1 |            8.75 |
            |        8 | Sopa de Tomate  |        1 |            8.75 |
            |       12 | Sopa de Tomate  |        1 |            8.75 |
            |       14 | Sopa de Tomate  |        1 |            8.75 |
            |       18 | Sopa de Tomate  |        1 |            8.75 |
            |        1 | Filete de Res   |        1 |           25.00 |
            |        4 | Filete de Res   |        1 |           25.00 |
            |        9 | Filete de Res   |        1 |           25.00 |
            |       10 | Filete de Res   |        1 |           25.00 |
            |       15 | Filete de Res   |        1 |           25.00 |
            |       16 | Filete de Res   |        1 |           25.00 |
            |        2 | Pasta Alfredo   |        1 |           15.00 |
            |        3 | Pasta Alfredo   |        1 |           15.00 |
            |        7 | Pasta Alfredo   |        1 |           15.00 |
            |       11 | Pasta Alfredo   |        1 |           15.00 |
            |       12 | Pasta Alfredo   |        1 |           15.00 |
            |       13 | Pasta Alfredo   |        1 |           15.00 |
            |       17 | Pasta Alfredo   |        1 |           15.00 |
            |       18 | Pasta Alfredo   |        1 |           15.00 |
            |        2 | Tarta de Queso  |        1 |            7.50 |
            |        5 | Tarta de Queso  |        2 |            7.50 |
            |        8 | Tarta de Queso  |        2 |            7.50 |
            |       11 | Tarta de Queso  |        1 |            7.50 |
            |       12 | Tarta de Queso  |        1 |            7.50 |
            |       14 | Tarta de Queso  |        2 |            7.50 |
            |       17 | Tarta de Queso  |        1 |            7.50 |
            |       18 | Tarta de Queso  |        1 |            7.50 |
            |        1 | Café Americano  |        3 |            3.00 |
            |        3 | Café Americano  |        2 |            3.00 |
            |        4 | Café Americano  |        1 |            3.00 |
            |        6 | Café Americano  |        3 |            3.00 |
            |        9 | Café Americano  |        3 |            3.00 |
            |       11 | Café Americano  |        2 |            3.00 |
            |       15 | Café Americano  |        3 |            3.00 |
            |       17 | Café Americano  |        2 |            3.00 |
            +----------+-----------------+----------+-----------------+
          ```
    - **Explicación:**
        Esta consulta lista los detalles de los pedidos, incluyendo el identificador del pedido, el nombre del menú, la cantidad y el precio unitario de cada ítem.

4. **Calcular el total gastado por cada cliente en todos sus pedidos:**
    - **Enunciado:**
        Calcular el total gastado por cada cliente en todos sus pedidos.
    - **Solución:**
        ```sql
        SELECT c.nombre, SUM(p.total) AS TotalGastado 
        FROM clientes c 
        JOIN pedidos p ON p.id_cliente = c.id_cliente
        GROUP BY c.nombre;
        ```
    - **Resultado:**
      ```
        +-------------------+--------------+
        | nombre            | TotalGastado |
        +-------------------+--------------+
        | Juan Perez        |        65.50 |
        | Maria Lopez       |        83.75 |
        | Carlos Mendoza    |        55.00 |
        | Ana González      |        61.00 |
        | Luis Torres       |        45.00 |
        | Laura Rivera      |        56.25 |
        | Fernando García   |        97.50 |
        | Isabel Fernández  |        84.25 |
        | Ricardo Morales   |        41.00 |
        | Lucía Martínez    |        55.75 |
        | Santiago Jiménez  |        52.00 |
        | Patricia Romero   |        46.25 |
        +-------------------+--------------+
      ```
    - **Explicación:**
        Esta consulta calcula el total gastado por cada cliente sumando el total de todos sus pedidos.

5. **Encontrar los menús con un precio mayor a $10:**
    - **Enunciado:**
        Encontrar los menús con un precio mayor a $10.
    - **Solución:**
        ```sql
        SELECT nombre, precio FROM menus WHERE precio > 10;
        ```
    - **Resultado:**
      ```
        +-----------------+--------+
        | nombre          | precio |
        +-----------------+--------+
        | Ensalada César  |  12.50 |
        | Filete de Res   | 123.12 |
        | Pasta Alfredo   | 980.00 |
        +-----------------+--------+
      ```
    - **Explicación:**
        Esta consulta selecciona el nombre y el precio de los menús cuyo precio es mayor a $10.

6. **Obtener el menú más caro pedido al menos una vez:**
    - **Enunciado:**
        Obtener el menú más caro pedido al menos una vez.
    - **Solución:**
        ```sql
        SELECT m.nombre AS nombre_menu, m.precio AS precio_menu
        FROM menus m
        JOIN (
            SELECT dp.id_menu, SUM(dp.cantidad * dp.precio_unitario) AS total
            FROM detallespedidos dp
            GROUP BY dp.id_menu
            ORDER BY total DESC
            LIMIT 1
        ) AS mascaro ON m.id_menu = mascaro.id_menu;
        ```
    - **Resultado:**
      ```
        +---------------+-------------+
        | nombre_menu   | precio_menu |
        +---------------+-------------+
        | Filete de Res |      123.12 |
        +---------------+-------------+
      ```
    - **Explicación:**
        Esta consulta obtiene el menú más caro que ha sido pedido al menos una vez, utilizando una subconsulta para encontrar el menú con el mayor total de ingresos.

7. **Listar los clientes que han realizado más de un pedido:**
    - **Enunciado:**
        Listar los clientes que han realizado más de un pedido.
    - **Solución:**
        ```sql
        SELECT c.nombre, c.correo_electronico
        FROM clientes c
        JOIN pedidos p ON c.id_cliente = p.id_cliente
        GROUP BY c.id_cliente
        HAVING COUNT(p.id_pedido) > 1;
        ```
    - **Resultado:**
      ```
        +-------------------+------------------------------+
        | nombre            | correo_electronico           |
        +-------------------+------------------------------+
        | Juan Perez        | juan.perez@example.com       |
        | Maria Lopez       | maria.lopez@example.com      |
        | Ana González      | ana.gonzalez@example.com     |
        | Laura Rivera      | laura.rivera@example.com     |
        | Fernando García   | fernando.garcia@example.com  |
        | Isabel Fernández  | isabel.fernandez@example.com |
        +-------------------+------------------------------+
      ```
    - **Explicación:**
        Esta consulta lista los clientes que han realizado más de un pedido, mostrando su nombre y correo electrónico.

8. **Obtener el cliente con el mayor gasto total:**
    - **Enunciado:**
        Obtener el cliente con el mayor gasto total.
    - **Solución:**
        ```sql
        SELECT c.nombre
        FROM clientes c
        JOIN pedidos p ON c.id_cliente = p.id_cliente
        JOIN detallespedidos dp ON p.id_pedido = dp.id_pedido
        GROUP BY c.id_cliente
        LIMIT 1;
        ```
    - **Resultado:**
      ```
        +------------+
        | nombre     |
        +------------+
        | Juan Perez |
        +------------+
      ```
    - **Explicación:**
        Esta consulta obtiene el cliente con el mayor gasto total, utilizando una combinación de las tablas `clientes`, `pedidos` y `detallespedidos`.

9. **Mostrar el pedido más reciente de cada cliente:**
    - **Enunciado:**
        Mostrar el pedido más reciente de cada cliente.
    - **Solución:**
        ```sql
        SELECT c.nombre AS nombre_cliente, p.fecha, p.total
        FROM clientes c
        JOIN pedidos p ON c.id_cliente = p.id_cliente
        JOIN (
            SELECT id_cliente, MAX(fecha) AS fecha_reciente
            FROM pedidos
            GROUP BY id_cliente
        ) p_max ON p.id_cliente = p_max.id_cliente AND p.fecha = p_max.fecha_reciente;
        ```
    - **Resultado:**
      ```
        +-------------------+------------+-------+
        | nombre_cliente    | fecha      | total |
        +-------------------+------------+-------+
        | Juan Perez        | 2024-06-01 | 25.50 |
        | Maria Lopez       | 2024-06-05 | 48.00 |
        | Carlos Mendoza    | 2024-06-10 | 55.00 |
        | Ana González      | 2024-06-15 | 28.25 |
        | Luis Torres       | 2024-06-20 | 45.00 |
        | Laura Rivera      | 2024-06-10 | 33.75 |
        | Fernando García   | 2024-06-25 | 47.00 |
        | Isabel Fernández  | 2024-06-30 | 39.50 |
        | Ricardo Morales   | 2024-05-25 | 41.00 |
        | Lucía Martínez    | 2024-06-04 | 55.75 |
        | Santiago Jiménez  | 2024-06-09 | 52.00 |
        | Patricia Romero   | 2024-06-15 | 46.25 |
        +-------------------+------------+-------+
      ```
    - **Explicación:**
        Esta consulta muestra el pedido más reciente de cada cliente, incluyendo el nombre del cliente, la fecha y el total del pedido.

10. **Obtener el detalle de pedidos (menús y cantidades) para el cliente 'Juan Perez':**
    - **Enunciado:**
        Obtener el detalle de pedidos (menús y cantidades) para el cliente 'Juan Perez'.
    - **Solución:**
        ```sql
        SELECT dp.id_pedido AS id, m.nombre, dp.cantidad, dp.precio_unitario 
        FROM detallespedidos dp 
        JOIN menus m ON dp.id_menu = m.id_menu
        JOIN pedidos p ON dp.id_pedido = p.id_pedido
        JOIN clientes c ON c.id_cliente = p.id_cliente
        WHERE c.nombre = 'Juan Perez';
        ```
    - **Resultado:**
      ```
        +----+-----------------+----------+-----------------+
        | id | nombre          | cantidad | precio_unitario |
        +----+-----------------+----------+-----------------+
        |  1 | Ensalada César  |        1 |           12.50 |
        |  1 | Filete de Res   |        1 |           25.00 |
        |  1 | Café Americano  |        3 |            3.00 |
        |  2 | Sopa de Tomate  |        1 |            8.75 |
        |  2 | Pasta Alfredo   |        1 |           15.00 |
        |  2 | Tarta de Queso  |        1 |            7.50 |
        +----+-----------------+----------+-----------------+
      ```
    - **Explicación:**
        Esta consulta obtiene el detalle de los pedidos, incluyendo el nombre del menú, la cantidad y el precio unitario, para el cliente 'Juan Perez'.

## Procedimientos Almacenados 

1. **Crear un procedimiento almacenado para agregar un nuevo cliente:**
    - **Enunciado:**
        Crear un procedimiento almacenado llamado `AgregarCliente` que reciba como parámetros el nombre, correo electrónico, teléfono y fecha de registro de un nuevo cliente y lo inserte en la tabla `Clientes`.
    - **Solución:**
        ```sql
        DELIMITER $$
        CREATE PROCEDURE AgregarCliente(
            IN pnombre VARCHAR(100),
            IN pcorreo_electronico VARCHAR(100),
            IN ptelefono VARCHAR(15),
            IN pfecha_registro DATE
        )
        BEGIN
            INSERT INTO clientes (nombre, correo_electronico, telefono, fecha_registro) 
            VALUES (pnombre, pcorreo_electronico, ptelefono, pfecha_registro);
        END $$
        DELIMITER ;
        ```
    - **Ejemplo de uso:**
      ```sql
        call AgregarCliente("Danyelle Giraldo", "Danyellesgiraldoj@gmail.com", "3104819492", '2024-06-12');
      ``` 
    - **Explicación:**
        Este procedimiento inserta un nuevo cliente en la tabla `clientes` utilizando los parámetros proporcionados.

2. **Crear un procedimiento almacenado para obtener los detalles de un pedido:**
    - **Enunciado:**
        Crear un procedimiento almacenado llamado `ObtenerDetallesPedido` que reciba como parámetro el ID del pedido y devuelva los detalles del pedido, incluyendo el nombre del menú, cantidad y precio unitario.
    - **Solución:**
        ```sql
        DELIMITER $$
        CREATE PROCEDURE ObtenerDetallesPedido(
            IN pidPedido INT
        )
        BEGIN
            SELECT dp.id_pedido,
                   dp.id_menu, 
                   m.nombre AS nombre_menu, 
                   dp.cantidad, 
                   dp.precio_unitario
            FROM detallespedidos dp 
            JOIN menus m ON m.id_menu = dp.id_menu
            JOIN pedidos p ON p.id_pedido = dp.id_pedido
            WHERE pidPedido = p.id_pedido;
        END $$
        DELIMITER ;
        ```
    - **Resultado:**
      ```
        +-----------+---------+----------------+----------+-----------------+
        | id_pedido | id_menu | nombre_menu    | cantidad | precio_unitario |
        +-----------+---------+----------------+----------+-----------------+
        |         2 |       2 | Sopa de Tomate |        1 |            8.75 |
        |         2 |       4 | Pasta Alfredo  |        1 |           15.00 |
        |         2 |       5 | Tarta de Queso |        1 |            7.50 |
        +-----------+---------+----------------+----------+-----------------+
      ```
      
    - **Explicación:**
        Este procedimiento recupera los detalles de un pedido específico, incluyendo el nombre del menú, la cantidad y el precio unitario de cada ítem.

3. **Crear un procedimiento almacenado para actualizar el precio de un menú:**
    - **Enunciado:**
        Crear un procedimiento almacenado llamado `ActualizarPrecioMenu` que reciba como parámetros el ID del menú y el nuevo precio, y actualice el precio del menú en la tabla `Menus`.
    - **Solución:**
        ```sql
        DELIMITER$$
        CREATE PROCEDURE ActualizarPrecioMenu(
            IN aidMenu INT,
            IN precionuevo DECIMAL(10,2)
        )
        BEGIN
            UPDATE menus 
            SET precio = precionuevo 
            WHERE id_menu = aidMenu;
        END $$
        DELIMITER ;
        ```
   - **Ejemplo de uso:**
      ```sql
        call ActualizarPrecioMenu(4, 980.00);
      ``` 
    - **Explicación:**
        Este procedimiento actualiza el precio de un menú específico en la tabla `menus` utilizando el ID del menú y el nuevo precio proporcionado.

4. **Crear un procedimiento almacenado para eliminar un cliente y sus pedidos:**
    - **Enunciado:**
        Crear un procedimiento almacenado llamado `EliminarCliente` que reciba como parámetro el ID del cliente y elimine el cliente junto con todos sus pedidos y los detalles de los pedidos.
    - **Solución:**
        ```sql
        DELIMITER $$
        CREATE PROCEDURE EliminarCliente(
            IN p_idclienteeliminar INT
        )
        BEGIN
            DELETE FROM detallespedidos 
            WHERE id_pedido IN (SELECT id_pedido FROM pedidos WHERE id_cliente = p_idclienteeliminar);
            
            DELETE FROM pedidos 
            WHERE id_cliente = p_idclienteeliminar;
            
            DELETE FROM clientes 
            WHERE id_cliente = p_idclienteeliminar;
        END$$
        DELIMITER ;
        ```
    - **Ejemplo de uso:**
      ```sql
        call EliminarCliente(13);
      ```
    - **Explicación:**
        Este procedimiento elimina un cliente específico, junto con todos sus pedidos y los detalles de esos pedidos, de las tablas `clientes`, `pedidos` y `detallespedidos`.

5. **Crear un procedimiento almacenado para obtener el total gastado por un cliente:**
    - **Enunciado:**
        Crear un procedimiento almacenado llamado `TotalGastadoPorCliente` que reciba como parámetro el ID del cliente y devuelva el total gastado por ese cliente en todos sus pedidos.
    - **Solución:**
        ```sql
        DELIMITER $$
        CREATE PROCEDURE TotalGastadoPorCliente(
            IN c_idcliente INT 
        )
        BEGIN
            SELECT c.nombre, SUM(p.total) AS TotalGastado 
            FROM clientes c 
            JOIN pedidos p ON p.id_cliente = c.id_cliente
            WHERE c.id_cliente = c_idcliente
            GROUP BY c.nombre;
        END$$
        DELIMITER ;
        ```
    - **Resultado:**
      ```
        +----------------+--------------+
        | nombre         | TotalGastado |
        +----------------+--------------+
        | Carlos Mendoza |        55.00 |
        +----------------+--------------+
      ```
    - **Explicación:**
        Este procedimiento calcula el total gastado por un cliente específico en todos sus pedidos.

Este README proporciona una guía completa para ejecutar y entender cada consulta y procedimiento almacenado SQL necesario para la gestión y análisis de datos en un restaurante.
