USE [master]
GO
/****** Object:  Database [MyDB]    Script Date: 2019-10-21 11:13:37 AM ******/
CREATE DATABASE [MyDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\MyDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MyDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\MyDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [MyDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MyDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MyDB] SET  MULTI_USER 
GO
ALTER DATABASE [MyDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MyDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MyDB] SET QUERY_STORE = OFF
GO
USE [MyDB]
GO
/****** Object:  Table [dbo].[Vehical]    Script Date: 2019-10-21 11:13:37 AM ******/
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
/****** Object:  Table [dbo].[Hiring]    Script Date: 2019-10-21 11:13:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hiring](
	[RecordRef] [int] IDENTITY(1,1) NOT NULL,
	[HireID] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[VehicleId] [nvarchar](50) NOT NULL,
	[Rate] [float] NOT NULL,
	[WithDriver] [bit] NOT NULL,
	[WithoutDriver] [bit] NOT NULL,
	[IsAvailable] [bit] NOT NULL,
	[Location] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_Hirings]    Script Date: 2019-10-21 11:13:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [dbo].[V_Hirings] AS
	select h.RecordRef,h.HireID, h.VehicleId, h.Rate, h.WithDriver, h.WithoutDriver, h.IsAvailable,h.[Location], v.UserId, v.Brand,
		v.Model, v.WithAC, v.NoOfSeats, v.OtherOption, o.first_name, o.Email,o.mobile_phone, o.mobile_phone2,h.Status
		from Hiring h,Vehical v,UDB.dbo.user_profile o
		where h.VehicleId = v.VehicleId and v.UserId = o.user_id;
	
GO
/****** Object:  Table [dbo].[config]    Script Date: 2019-10-21 11:13:37 AM ******/
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
/****** Object:  Table [dbo].[VehicleOwner]    Script Date: 2019-10-21 11:13:37 AM ******/
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
ALTER TABLE [dbo].[Hiring] ADD  CONSTRAINT [DF_Hiring_HireID]  DEFAULT ('') FOR [HireID]
GO
ALTER TABLE [dbo].[Hiring] ADD  CONSTRAINT [DF_Hiring_UserID]  DEFAULT ('') FOR [UserID]
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
ALTER TABLE [dbo].[Hiring] ADD  CONSTRAINT [DF_Hiring_Status]  DEFAULT ('') FOR [Status]
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
USE [master]
GO
ALTER DATABASE [MyDB] SET  READ_WRITE 
GO
