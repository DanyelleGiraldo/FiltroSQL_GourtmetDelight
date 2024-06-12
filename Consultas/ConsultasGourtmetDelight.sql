--  Obtener la lista de todos los menús con sus precios
	select nombre, precio from menus;
	
-- Encontrar todos los pedidos realizados por el cliente 'Juan Perez'
	select p.id_pedido, p.fecha, p.total 
	from pedidos p 
	join clientes c on c.id_cliente = p.id_cliente 
	where c.nombre = 'Juan Perez';
	
-- Listar los detalles de todos los pedidos, 
-- incluyendo el nombre del menú, cantidad y precio unitario

	select dp.id_pedido as PedidoID, m.nombre, dp.cantidad, dp.precio_unitario 
	from detallespedidos dp
	join menus m on dp.id_menu = m.id_menu;

-- Calcular el total gastado por cada cliente en todos sus pedidos

	select c.nombre, sum(p.total) as TotalGastado 
	from clientes c 
	join pedidos p on p.id_cliente = c.id_cliente
	group by c.nombre;

-- Encontrar los menús con un precio mayor a $10
	
	select nombre, precio from menus where precio > 10;
	
-- Obtener el menú más caro pedido al menos una vez

	select m.nombre as nombre_menu, m.precio as precio_menu
	from menus m
	join (
	    select dp.id_menu, sum(dp.cantidad * dp.precio_unitario) as total
	    from detallespedidos dp
	    group by dp.id_menu
	    order by total desc
	    limit 1
	) as mascaro on m.id_menu = mascaro.id_menu;

-- Listar los clientes que han realizado más de un pedido

	select c.nombre, c.correo_electronico
	from clientes c
	join pedidos p on c.id_cliente = p.id_cliente
	group by c.id_cliente
	having count(p.id_pedido) > 1;


-- Obtener el cliente con el mayor gasto total

	select  c.nombre
	from clientes c
	join pedidos p on c.id_cliente = p.id_cliente
	join detallespedidos dp on p.id_pedido = dp.id_pedido
	group by c.id_cliente
	limit 1;


-- Mostrar el pedido más reciente de cada cliente

	SELECT c.nombre AS nombre_cliente, p.fecha, p.total
	FROM clientes c
	JOIN pedidos p ON c.id_cliente = p.id_cliente
	JOIN (
	    SELECT id_cliente, MAX(fecha) AS fecha_reciente
	    FROM pedidos
	    GROUP BY id_cliente
	) p_max ON p.id_cliente = p_max.id_cliente AND p.fecha = p_max.fecha_reciente;


-- Obtener el detalle de pedidos (menús y cantidades) para el cliente 'Juan Perez'.

	select dp.id_pedido as id, m.nombre, dp.cantidad, dp.precio_unitario 
	from detallespedidos dp 
	join menus m on dp.id_menu = m.id_menu
	join pedidos p on dp.id_pedido = p.id_pedido
	join clientes c on c.id_cliente = p.id_cliente
	where c.nombre = 'Juan Perez';

-- Procedimientos Almacenados

/*
Crear un procedimiento almacenado para agregar un nuevo cliente

Enunciado: Crea un procedimiento almacenado llamado AgregarCliente que reciba como
parámetros el nombre, correo electrónico, teléfono y fecha de registro de un nuevo cliente y lo
inserte en la tabla Clientes .
*/

delimiter $$
create procedure AgregarCliente(
	in pnombre varchar(100),
	in pcorreo_electronico varchar(100),
	in ptelefono varchar(15),
	in pfecha_registro date
)
begin
	INSERT INTO clientes (nombre, correo_electronico, telefono, fecha_registro) VALUES 
	(pnombre , pcorreo_electronico , ptelefono , pfecha_registro);
end $$
DELIMITER ;

-- ejemplo uso
call AgregarCliente("Daniel Giraldo", "Danyellesgiraldoj@gmail.com", "3104819492", '2024-06-12');

/*
Crear un procedimiento almacenado para obtener los detalles de un pedido

Enunciado: Crea un procedimiento almacenado llamado ObtenerDetallesPedido que reciba
como parámetro el ID del pedido y devuelva los detalles del pedido, incluyendo el nombre del
menú, cantidad y precio unitario.
*/

	DELIMITER $$
	create procedure ObtenerDetallesPedido(
		pidPedido int
	)
	begin
		select dp.id_pedido,
		dp.id_menu, 
		m.nombre as nombre_menu, 
		dp.cantidad, 
		dp.precio_unitario
		from detallespedidos dp 
		join menus m on m.id_menu = dp.id_menu
		join pedidos p on p.id_pedido = dp.id_pedido
		where pidPedido = p.id_pedido;
	end $$
	DELIMITER ;
	
-- ejemplo de uso
call ObtenerDetallesPedido(2);

/*
Crear un procedimiento almacenado para actualizar el precio de un menú

Enunciado: Crea un procedimiento almacenado llamado ActualizarPrecioMenu que reciba
como parámetros el ID del menú y el nuevo precio, y actualice el precio del menú en la tabla
Menus .
*/

	DELIMITER$$
	create procedure ActualizarPrecioMenu(
		in aidMenu int,
		in precionuevo decimal(10,2)
	)
	begin
		update menus 
		set precio = precionuevo 
		where id_menu = aidMenu;
	end $$
	DELIMITER ;

-- ejemplo de uso

call ActualizarPrecioMenu(4, 980.00);

/*
Crear un procedimiento almacenado para eliminar un cliente y sus pedidos

Enunciado: Crea un procedimiento almacenado llamado EliminarCliente que reciba como
parámetro el ID del cliente y elimine el cliente junto con todos sus pedidos y los detalles de los
pedidos.
*/

	DELIMITER $$
	create procedure EliminarCliente(
	    in p_idclienteeliminar int
	)
	begin
	    delete from clientes 
	    where id_cliente = p_idclienteeliminar;
	    
	    delete from pedidos 
	    where id_cliente = p_idclienteeliminar;
	    
	    delete from detallespedidos
	    where id_pedido 
	    in (select id_pedido from pedidos where id_cliente = p_idclienteeliminar);
	end$$
	DELIMITER ;

-- ejemplo de uso
call EliminarCliente(13);

/*
Crear un procedimiento almacenado para obtener el total gastado por un cliente

Enunciado: Crea un procedimiento almacenado llamado TotalGastadoPorCliente que reciba
como parámetro el ID del cliente y devuelva el total gastado por ese cliente en todos sus pedidos.
*/

	DELIMITER $$
	create procedure TotalGastadoPorCliente(
		in c_idcliente int 
	)
	begin
		select c.nombre, sum(p.total) as TotalGastado 
		from clientes c 
		join pedidos p on p.id_cliente = c.id_cliente
		where c.id_cliente = c_idcliente
		group by c.nombre;
	end$$
	DELIMITER ;

-- ejemplo de uso
call TotalGastadoPorCliente(3);
