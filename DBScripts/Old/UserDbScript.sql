
/****** Object:  Table [dbo].[System_Functions]    Script Date: 6/29/2019 3:50:53 PM ******/
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
/****** Object:  Table [dbo].[Token]    Script Date: 6/29/2019 3:50:54 PM ******/
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
/****** Object:  Table [dbo].[user_profile]    Script Date: 6/29/2019 3:50:54 PM ******/
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
 CONSTRAINT [PK_user_profile] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_role]    Script Date: 6/29/2019 3:50:54 PM ******/
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
ALTER TABLE [dbo].[user_role] ADD  CONSTRAINT [DF_user_role_user_role]  DEFAULT ('') FOR [user_role]
GO
ALTER TABLE [dbo].[user_role] ADD  CONSTRAINT [DF_user_role_description]  DEFAULT ('') FOR [description]
GO
ALTER TABLE [dbo].[user_role] ADD  CONSTRAINT [DF_user_role_functions]  DEFAULT ('') FOR [functions]
GO

