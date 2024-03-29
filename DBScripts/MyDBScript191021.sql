USE [master]
GO
/****** Object:  Database [myUserDB]    Script Date: 2019-10-21 11:11:49 AM ******/
CREATE DATABASE [myUserDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyUser', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\MyUser.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MyUser_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\MyUser_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [myUserDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [myUserDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [myUserDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [myUserDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [myUserDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [myUserDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [myUserDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [myUserDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [myUserDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [myUserDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [myUserDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [myUserDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [myUserDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [myUserDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [myUserDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [myUserDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [myUserDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [myUserDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [myUserDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [myUserDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [myUserDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [myUserDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [myUserDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [myUserDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [myUserDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [myUserDB] SET  MULTI_USER 
GO
ALTER DATABASE [myUserDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [myUserDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [myUserDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [myUserDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [myUserDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [myUserDB] SET QUERY_STORE = OFF
GO
USE [myUserDB]
GO
/****** Object:  Table [dbo].[Agent]    Script Date: 2019-10-21 11:11:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agent](
	[RecordRef] [int] IDENTITY(1,1) NOT NULL,
	[AgentID] [nvarchar](50) NOT NULL,
	[user_id] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[System_Functions]    Script Date: 2019-10-21 11:11:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[System_Functions](
	[recordref] [int] IDENTITY(1,1) NOT NULL,
	[function_name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Token]    Script Date: 2019-10-21 11:11:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Token](
	[Seq] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [nvarchar](50) NOT NULL,
	[token] [nvarchar](500) NOT NULL,
	[ip] [nvarchar](50) NOT NULL,
	[center_id] [nvarchar](100) NOT NULL,
	[login_time] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_profile]    Script Date: 2019-10-21 11:11:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_profile](
	[recordref] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [nvarchar](50) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](150) NOT NULL,
	[email] [nvarchar](150) NOT NULL,
	[mobile_phone] [nvarchar](50) NOT NULL,
	[password] [nvarchar](100) NOT NULL,
	[user_role] [nvarchar](50) NOT NULL,
	[status] [nvarchar](10) NOT NULL,
	[password_trycount] [int] NOT NULL,
	[last_accessed] [datetime] NULL,
	[IndexType] [char](1) NOT NULL,
	[Center_id] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_user_profile] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_role]    Script Date: 2019-10-21 11:11:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_role](
	[recordref] [int] IDENTITY(1,1) NOT NULL,
	[user_role] [nvarchar](50) NOT NULL,
	[description] [nvarchar](50) NOT NULL,
	[functions] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[System_Functions] ADD  CONSTRAINT [DF_Function_List_function_name]  DEFAULT ('') FOR [function_name]
GO
ALTER TABLE [dbo].[System_Functions] ADD  CONSTRAINT [DF_Function_List_description]  DEFAULT ('') FOR [description]
GO
ALTER TABLE [dbo].[Token] ADD  CONSTRAINT [DF_Token_user_id]  DEFAULT ('') FOR [user_id]
GO
ALTER TABLE [dbo].[Token] ADD  CONSTRAINT [DF_Token_token]  DEFAULT ('') FOR [token]
GO
ALTER TABLE [dbo].[Token] ADD  CONSTRAINT [DF_Token_ip]  DEFAULT ('') FOR [ip]
GO
ALTER TABLE [dbo].[Token] ADD  CONSTRAINT [DF_Token_center_id]  DEFAULT ('') FOR [center_id]
GO
ALTER TABLE [dbo].[Token] ADD  CONSTRAINT [DF_Token_login_time]  DEFAULT ('1900-01-01') FOR [login_time]
GO
ALTER TABLE [dbo].[user_profile] ADD  CONSTRAINT [DF_user_profile_user_id]  DEFAULT ('') FOR [user_id]
GO
ALTER TABLE [dbo].[user_profile] ADD  CONSTRAINT [DF_user_profile_first_name]  DEFAULT ('') FOR [first_name]
GO
ALTER TABLE [dbo].[user_profile] ADD  CONSTRAINT [DF_user_profile_last_name]  DEFAULT ('') FOR [last_name]
GO
ALTER TABLE [dbo].[user_profile] ADD  CONSTRAINT [DF_user_profile_email]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[user_profile] ADD  CONSTRAINT [DF_user_profile_mobile_phone]  DEFAULT ('') FOR [mobile_phone]
GO
ALTER TABLE [dbo].[user_profile] ADD  CONSTRAINT [DF_user_profile_password]  DEFAULT ('') FOR [password]
GO
ALTER TABLE [dbo].[user_profile] ADD  CONSTRAINT [DF_user_profile_user_role]  DEFAULT ('') FOR [user_role]
GO
ALTER TABLE [dbo].[user_profile] ADD  CONSTRAINT [DF_user_profile_status]  DEFAULT ('') FOR [status]
GO
ALTER TABLE [dbo].[user_profile] ADD  CONSTRAINT [DF_user_profile_password_trycount]  DEFAULT ((0)) FOR [password_trycount]
GO
ALTER TABLE [dbo].[user_profile] ADD  CONSTRAINT [DF__user_prof__Index__7D439ABD]  DEFAULT ('Y') FOR [IndexType]
GO
ALTER TABLE [dbo].[user_profile] ADD  CONSTRAINT [DF_user_profile_Center_id]  DEFAULT ('') FOR [Center_id]
GO
ALTER TABLE [dbo].[user_role] ADD  CONSTRAINT [DF_user_role_user_role]  DEFAULT ('') FOR [user_role]
GO
ALTER TABLE [dbo].[user_role] ADD  CONSTRAINT [DF_user_role_description]  DEFAULT ('') FOR [description]
GO
ALTER TABLE [dbo].[user_role] ADD  CONSTRAINT [DF_user_role_functions]  DEFAULT ('') FOR [functions]
GO
USE [master]
GO
ALTER DATABASE [myUserDB] SET  READ_WRITE 
GO
