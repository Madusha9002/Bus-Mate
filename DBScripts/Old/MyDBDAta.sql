USE [MyDB]
GO
SET IDENTITY_INSERT [dbo].[config] ON 

INSERT [dbo].[config] ([RecordRef], [field_name], [int_field_value], [field_type], [description]) VALUES (1, N'VEHICLE_ID', 1, N'ee', N'')
SET IDENTITY_INSERT [dbo].[config] OFF
SET IDENTITY_INSERT [dbo].[Hiring] ON 

INSERT [dbo].[Hiring] ([RecordRef], [VehicleId], [Rate], [WithDriver], [WithoutDriver], [IsAvailable], [Location]) VALUES (1, N'1', 5, 1, 1, 0, N'Colombo')
INSERT [dbo].[Hiring] ([RecordRef], [VehicleId], [Rate], [WithDriver], [WithoutDriver], [IsAvailable], [Location]) VALUES (2, N'2', 40, 0, 1, 1, N'Kelaniya')
INSERT [dbo].[Hiring] ([RecordRef], [VehicleId], [Rate], [WithDriver], [WithoutDriver], [IsAvailable], [Location]) VALUES (3, N'3', 50, 1, 1, 1, N'Galle')
SET IDENTITY_INSERT [dbo].[Hiring] OFF
SET IDENTITY_INSERT [dbo].[Vehical] ON 

INSERT [dbo].[Vehical] ([RecordRef], [UserId], [VehicleId], [Brand], [Model], [WithAC], [NoOfSeats], [OtherOption]) VALUES (1, N'a', N'1', N'Nissan', N'64', 1, 34, N'gwdbgd')
INSERT [dbo].[Vehical] ([RecordRef], [UserId], [VehicleId], [Brand], [Model], [WithAC], [NoOfSeats], [OtherOption]) VALUES (2, N'a', N'2', N'Tpyota', N'52', 0, 52, N'ftvggy')
INSERT [dbo].[Vehical] ([RecordRef], [UserId], [VehicleId], [Brand], [Model], [WithAC], [NoOfSeats], [OtherOption]) VALUES (3, N'b', N'3', N'Nissan', N'13a', 1, 60, N'')
SET IDENTITY_INSERT [dbo].[Vehical] OFF
SET IDENTITY_INSERT [dbo].[VehicleOwner] ON 

INSERT [dbo].[VehicleOwner] ([RecordRef], [UserId], [Name], [Email], [TelephoneNo1], [TelephoneNo2]) VALUES (1, N'a', N'Perera', N'perera@gmail.com', N'0772451213', N'')
INSERT [dbo].[VehicleOwner] ([RecordRef], [UserId], [Name], [Email], [TelephoneNo1], [TelephoneNo2]) VALUES (2, N'b', N'Nishan', N'nishan@gmail.com', N'0712453636', N'')
SET IDENTITY_INSERT [dbo].[VehicleOwner] OFF
