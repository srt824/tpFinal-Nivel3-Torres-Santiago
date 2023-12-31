USE [CATALOGO_WEB_DB]
GO
/****** Object:  Table [dbo].[ARTICULOS]    Script Date: 10/12/2023 02:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARTICULOS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[Descripcion] [varchar](150) NULL,
	[IdMarca] [int] NULL,
	[IdCategoria] [int] NULL,
	[ImagenUrl] [varchar](1000) NULL,
	[Precio] [money] NULL,
 CONSTRAINT [PK_ARTICULOS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORIAS]    Script Date: 10/12/2023 02:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIAS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CATEGORIAS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FAVORITOS]    Script Date: 10/12/2023 02:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAVORITOS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdArticulo] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MARCAS]    Script Date: 10/12/2023 02:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MARCAS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_MARCAS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 10/12/2023 02:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[pass] [varchar](20) NOT NULL,
	[nombre] [varchar](50) NULL,
	[apellido] [varchar](50) NULL,
	[urlImagenPerfil] [varchar](500) NULL,
	[admin] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[USERS] ADD  DEFAULT ((0)) FOR [admin]
GO
/****** Object:  StoredProcedure [dbo].[agregarFavoritoConSP]    Script Date: 10/12/2023 02:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[agregarFavoritoConSP]
@idUser int,
@idArticulo int
as
insert into FAVORITOS (IdUser, IdArticulo) values (@idUser, @idArticulo)
GO
/****** Object:  StoredProcedure [dbo].[insertarNuevo]    Script Date: 10/12/2023 02:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[insertarNuevo]
@email varchar(50),
@pass varchar(50)
as
insert into USERS (email, pass, admin) output inserted.Id values (@email, @pass, 0)
GO
/****** Object:  StoredProcedure [dbo].[storedAltaArticulo]    Script Date: 10/12/2023 02:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[storedAltaArticulo]
@codigo varchar(50),
@nombre varchar(50),
@desc varchar(150),
@idMarca int,
@idCategoria int,
@img varchar(1000),
@precio money
as
insert into ARTICULOS values (@codigo, @nombre, @desc, @idMarca, @idCategoria, @img, @precio)
GO
/****** Object:  StoredProcedure [dbo].[storedListar]    Script Date: 10/12/2023 02:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create procedure [dbo].[storedListar] as
Select Codigo, Nombre, M.Descripcion Marca, IdMarca, C.Descripcion Categoria, IdCategoria, A.Descripcion Detalle, ImagenUrl, Precio, A.Id 
From ARTICULOS A, CATEGORIAS C, MARCAS M
Where A.IdMarca = M.Id and A.IdCategoria = C.Id
GO
/****** Object:  StoredProcedure [dbo].[storedModificarArticulo]    Script Date: 10/12/2023 02:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[storedModificarArticulo]
@codigo varchar(50),
@nombre varchar(50),
@desc varchar(150),
@idMarca int,
@idCategoria int,
@img varchar(1000),
@precio money,
@id int
as
UPDATE ARTICULOS SET Codigo = @codigo, Nombre = @nombre, Descripcion = @desc, IdMarca = @idMarca, IdCategoria = @idCategoria, ImagenUrl = @img, Precio = @precio where Id = @id
GO


insert into USERS values ('admin@admin.com', 'admin', 'Santiago', 'Torres', '', 1);
insert into USERS values ('user@user.com', 'user', 'Anto', 'Pacente', '', 0);

insert into CATEGORIAS values ('Celulares')
insert into CATEGORIAS values ('Televisores')
insert into CATEGORIAS values ('Media')
insert into CATEGORIAS values ('Audio')

insert into Marcas values ('Samsung')
insert into Marcas values ('Apple')
insert into Marcas values ('Sony')
insert into Marcas values ('Huawei')
insert into Marcas values ('Motorola')

insert into ARTICULOS values ('SA01','Samsung Galaxy S10', 'Lindo celu', 1, 1, 'https://http2.mlstatic.com/D_NQ_NP_743492-MLA52964050287_122022-O.webp', 512000);
insert into ARTICULOS values ('M03', 'Moto G Play 7ma Gen', 'Ya siete de estos?', 5, 1,  'https://http2.mlstatic.com/D_NQ_NP_645127-MLA44486246279_012021-O.webp', 15699);
insert into ARTICULOS values ('SN02','Play 4', 'Ya no se cuantas versiones hay', 3, 3,  'https://http2.mlstatic.com/D_Q_NP_865169-MLA54833481393_042023-O.webp', 35000);
insert into ARTICULOS values ('SN56', 'Bravia 55', 'Alta tele', 3, 2,  'https://intercompras.com/product_thumb_keepratio_2.php?img=images/product/SONY_KDL-55W950A.jpg&w=650&h=450',49500);
insert into ARTICULOS values ('A23', 'Apple TV', 'Lindo loro', 2, 3,  'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/rfb-apple-tv-4k?wid=1144&hei=1144&fmt=jpeg&qlt=80&.v=1513897159574', 7850);
insert into ARTICULOS values ('SN01', 'Play 5', 'La definitiva', 3, 3,  'https://www.atajo.com.ar/images/0000001000031651746091000031651.jpg', 900000);
insert into ARTICULOS values ('SA02', 'Samsung Galaxy S23 Ultra', 'Ultra celular', 1, 1,  'https://http2.mlstatic.com/D_NQ_NP_607001-MLU71541490170_092023-O.webp', 800000);
insert into ARTICULOS values ('A20', 'MacBook PRO M2', 'Una nave', 2, 3,  'https://doctormovil.co/wp-content/uploads/2021/05/pro-m2.jpg', 2500000);
insert into ARTICULOS values ('A19', 'Iphone 15 PRO', 'Tremendo cañon', 2, 1,  'https://http2.mlstatic.com/D_NQ_NP_912227-MLA71782903150_092023-O.webp', 2000000);
insert into ARTICULOS values ('A18', 'Ipad PRO', 'LA tablet', 2, 3,  'https://www.apple.com/newsroom/images/product/ipad/standard/apple_ipad-pro-spring21_lp_04202021.jpg.og.jpg?202310111413', 1827000);



