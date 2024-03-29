
/****** Object:  Table [dbo].[config]    Script Date: 10/15/2019 9:55:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[config](
	[RecordRef] [int] IDENTITY(1,1) NOT NULL,
	[field_name] [nvarchar](50) NOT NULL,
	[int_field_value] [int] NOT NULL,
	[field_type] [nvarchar](50) NOT NULL,
	[description] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hiring]    Script Date: 10/15/2019 9:55:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hiring](
	[RecordRef] [int] IDENTITY(1,1) NOT NULL,
	[VehicleId] [nvarchar](50) NOT NULL,
	[Rate] [float] NOT NULL,
	[WithDriver] [bit] NOT NULL,
	[WithoutDriver] [bit] NOT NULL,
	[IsAvailable] [bit] NOT NULL,
	[Location] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehical]    Script Date: 10/15/2019 9:55:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehical](
	[RecordRef] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](50) NOT NULL,
	[VehicleId] [nvarchar](50) NOT NULL,
	[Brand] [nvarchar](50) NOT NULL,
	[Model] [nvarchar](50) NOT NULL,
	[WithAC] [bit] NOT NULL,
	[NoOfSeats] [int] NOT NULL,
	[OtherOption] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VehicleOwner]    Script Date: 10/15/2019 9:55:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleOwner](
	[RecordRef] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[TelephoneNo1] [nvarchar](15) NOT NULL,
	[TelephoneNo2] [nvarchar](15) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[config] ADD  CONSTRAINT [DF_config_field_name]  DEFAULT ('') FOR [field_name]
GO
ALTER TABLE [dbo].[config] ADD  CONSTRAINT [DF_config_int_field_value]  DEFAULT ((0)) FOR [int_field_value]
GO
ALTER TABLE [dbo].[config] ADD  CONSTRAINT [DF_config_field_type]  DEFAULT ('') FOR [field_type]
GO
ALTER TABLE [dbo].[config] ADD  CONSTRAINT [DF_config_description]  DEFAULT ('') FOR [description]
GO
ALTER TABLE [dbo].[Hiring] ADD  CONSTRAINT [DF_Hiring_VehicleId]  DEFAULT ('') FOR [VehicleId]
GO
ALTER TABLE [dbo].[Hiring] ADD  CONSTRAINT [DF_Hiring_Rate]  DEFAULT ((0)) FOR [Rate]
GO
ALTER TABLE [dbo].[Hiring] ADD  CONSTRAINT [DF_Hiring_WithDriver]  DEFAULT ((0)) FOR [WithDriver]
GO
ALTER TABLE [dbo].[Hiring] ADD  CONSTRAINT [DF_Hiring_WithoutDriver]  DEFAULT ((0)) FOR [WithoutDriver]
GO
ALTER TABLE [dbo].[Hiring] ADD  CONSTRAINT [DF_Hiring_IsAvailable]  DEFAULT ((0)) FOR [IsAvailable]
GO
ALTER TABLE [dbo].[Hiring] ADD  CONSTRAINT [DF_Hiring_Location]  DEFAULT ('') FOR [Location]
GO
ALTER TABLE [dbo].[Vehical] ADD  CONSTRAINT [DF_Vehical_UserId]  DEFAULT ('') FOR [UserId]
GO
ALTER TABLE [dbo].[Vehical] ADD  CONSTRAINT [DF_Vehical_VehicleId]  DEFAULT ('') FOR [VehicleId]
GO
ALTER TABLE [dbo].[Vehical] ADD  CONSTRAINT [DF_Vehical_Brand]  DEFAULT ('') FOR [Brand]
GO
ALTER TABLE [dbo].[Vehical] ADD  CONSTRAINT [DF_Vehical_Model]  DEFAULT ('') FOR [Model]
GO
ALTER TABLE [dbo].[Vehical] ADD  CONSTRAINT [DF_Vehical_A/C]  DEFAULT ((0)) FOR [WithAC]
GO
ALTER TABLE [dbo].[Vehical] ADD  CONSTRAINT [DF_Vehical_Seats]  DEFAULT ((0)) FOR [NoOfSeats]
GO
ALTER TABLE [dbo].[Vehical] ADD  CONSTRAINT [DF_Vehical_OtherFac]  DEFAULT ('') FOR [OtherOption]
GO
ALTER TABLE [dbo].[VehicleOwner] ADD  CONSTRAINT [DF_Owner_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[VehicleOwner] ADD  CONSTRAINT [DF_Owner_TelephoneNo1]  DEFAULT ('') FOR [TelephoneNo1]
GO
ALTER TABLE [dbo].[VehicleOwner] ADD  CONSTRAINT [DF_Owner_TelephoneNo2]  DEFAULT ('') FOR [TelephoneNo2]
GO

