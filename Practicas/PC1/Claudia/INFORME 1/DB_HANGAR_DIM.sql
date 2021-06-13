use master
go

if exists
(
	select name
	from sysdatabases
	where name='HANGAR_DIM'
)
drop database HANGAR_DIM
go

create database HANGAR_DIM
on primary
(
	name=HANGAR_DIM_dat,
	filename='D:\CEPSUNI\HANGAR_DIM_dat.mdf',
	size=30 MB,
	maxsize=50 MB,
	filegrowth=10 MB
)
log on
(
	name=HANGAR_DIM_log,
	filename='D:\CEPSUNI\HANGAR_DIM_log.ldf',
	size=10MB,
	maxsize=unlimited,
	filegrowth=10%
)
go

use HANGAR_DIM
GO

create table DIM_ALMACEN
(
	ID_ALMACEN int constraint pk_almacen primary key clustered not null,
	DIR_ALMACEN varchar(100) not null
)
go

create table DIM_PRODUCTO
(
	ID_PRODUCTO int constraint pk_producto primary key clustered not null,
	NOM_PRODUCTO varchar(200) not null
)
go

create table DIM_FAMILIA
(
	ID_FAMILIA int constraint pk_familia primary key clustered not null,
	NOM_FAMILIA varchar(200) not null
)
go

create table DIM_PROVEEDOR
(
	ID_PROVEEDOR int constraint pk_proveedor primary key clustered not null,
	NOM_PROVEEDOR varchar(100) not null
)
go

create table DIM_FECHA
(
	ID_FECHA int constraint pk_fecha primary key clustered not null,
	MES VARCHAR(50),
	AÑO INT
)
go


create table ALMACENANIENTO
(
	ID_ALMACEN int constraint fk_alm_alm foreign key (ID_ALMACEN) references DIM_ALMACEN(ID_ALMACEN),
	ID_PRODUCTO int constraint fk_alm_prod foreign key (ID_PRODUCTO) references DIM_PRODUCTO(ID_PRODUCTO),
	ID_FAMILIA int constraint fk_alm_fam foreign key (ID_FAMILIA) references DIM_FAMILIA(ID_FAMILIA),
	ID_PROVEEDOR int constraint fk_alm_prov foreign key (ID_PROVEEDOR) references DIM_PROVEEDOR(ID_PROVEEDOR),
	ID_FECHA int constraint fk_alm_fech foreign key (ID_FECHA) references DIM_FECHA(ID_FECHA),
	CANT_STOCK int,
	COSTO_UNIT float,
	COSTO_TOTAL float,
	COSTO_VENTAPROM float,
	VENTA_PROM12MESES_UN float,
	VENTA_PROM12MESES_MONTO float
)
go