# FiltroSQL_GourtmetDelight
Bienvenidos al proyecto de creación de la base de datos para nuestro restaurante, Gourmet
Delight. Como propietario de este restaurante, necesito una solución integral para gestionar la
información relacionada con nuestros clientes, menús, pedidos y los detalles de cada pedido. La
base de datos será crucial para organizar y mantener nuestros registros de manera eficiente,
permitiéndonos brindar un mejor servicio y tomar decisiones informadas para el crecimiento del
negocio.

## Consultas SQL sobre una base de datos de restaurante

1. **Obtener la lista de todos los menús con sus precios:**
    - **Enunciado:**
        Obtener la lista de todos los menús con sus precios.
    - **Solución:**
        ```sql
        SELECT nombre, precio FROM menus;
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
    - **Explicación:**
        Esta consulta calcula el total gastado por cada cliente sumando el total de todos sus pedidos.

5. **Encontrar los menús con un precio mayor a $10:**
    - **Enunciado:**
        Encontrar los menús con un precio mayor a $10.
    - **Solución:**
        ```sql
        SELECT nombre, precio FROM menus WHERE precio > 10;
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
    - **Explicación:**
        Este procedimiento calcula el total gastado por un cliente específico en todos sus pedidos.

Este README proporciona una guía completa para ejecutar y entender cada consulta y procedimiento almacenado SQL necesario para la gestión y análisis de datos en un restaurante.
