
SET IDENTITY_INSERT [dbo].[Token] ON 

INSERT [dbo].[Token] ([Seq], [user_id], [token], [ip], [center_id], [login_time]) VALUES (12, N'a', N'f36bd865-ff14-4336-bbb3-a4bce56aed27', N'::1', N'0', CAST(N'2019-10-27T17:12:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Token] OFF
SET IDENTITY_INSERT [dbo].[user_profile] ON 

INSERT [dbo].[user_profile] ([recordref], [user_id], [first_name], [last_name], [email], [mobile_phone], [mobile_phone2], [password], [user_role], [status], [password_trycount], [last_accessed], [IndexType]) VALUES (2, N'a', N'Usr', N'', N'bbb@123.com', N'07122222222', N'01122222222', N'a', N'USER', N'Active', 0, NULL, N'Y')
INSERT [dbo].[user_profile] ([recordref], [user_id], [first_name], [last_name], [email], [mobile_phone], [mobile_phone2], [password], [user_role], [status], [password_trycount], [last_accessed], [IndexType]) VALUES (3, N'b', N'B', N'', N'bbb@123.com', N'077222222222', N'01133333333', N'b', N'USER', N'Active', 0, NULL, N'Y')
INSERT [dbo].[user_profile] ([recordref], [user_id], [first_name], [last_name], [email], [mobile_phone], [mobile_phone2], [password], [user_role], [status], [password_trycount], [last_accessed], [IndexType]) VALUES (1, N's', N'Sandaruwan', N'Lakjeewa', N'ABC@123.com', N'071111111111', N'01144444444', N's', N'ADMIN', N'Active', 0, NULL, N'Y')
SET IDENTITY_INSERT [dbo].[user_profile] OFF
SET IDENTITY_INSERT [dbo].[user_role] ON 

INSERT [dbo].[user_role] ([recordref], [user_role], [description], [functions]) VALUES (1, N'ADMIN', N'Admin', N'[MNG_VEHICLE][MNG_HIRE][ALL_HIRES]')
INSERT [dbo].[user_role] ([recordref], [user_role], [description], [functions]) VALUES (2, N'USER', N'user', N'[MNG_VEHICLE][MNG_HIRE][USER_HIRES]')
SET IDENTITY_INSERT [dbo].[user_role] OFF
