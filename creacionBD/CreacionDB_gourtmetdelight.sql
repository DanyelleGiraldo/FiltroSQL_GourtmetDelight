create database gourtmetdelight;
use gourtmetdelight;

create table clientes(
	id_cliente int primary key auto_increment,
	nombre varchar(100),
	correo_electronico varchar(100),
	telefono varchar(15),
	fecha_registro date
);

create table menus(
	id_menu int primary key auto_increment,
	nombre varchar(100),
	descripcion text,
	precio decimal(10,2)
);

create table pedidos(
	id_pedido int primary key auto_increment,
	id_cliente int,
	fecha date,
	total decimal(10,2),
	foreign key(id_cliente) references clientes(id_cliente)
);

create table detallespedidos(
	id_pedido int,
	id_menu int,
	cantidad int,
	precio_unitario decimal(10,2),
	primary key(id_pedido, id_menu),
	foreign key(id_pedido) references pedidos(id_pedido),
	foreign key(id_menu) references menus(id_menu)
);