
SET IDENTITY_INSERT [dbo].[config] ON 

INSERT [dbo].[config] ([RecordRef], [field_name], [int_field_value], [field_type], [description]) VALUES (1, N'VEHICLE_ID', 5, N'ee', N'')
INSERT [dbo].[config] ([RecordRef], [field_name], [int_field_value], [field_type], [description]) VALUES (2, N'HIRE_NO', 17, N'HireId', N'')
SET IDENTITY_INSERT [dbo].[config] OFF
SET IDENTITY_INSERT [dbo].[Hiring] ON 

INSERT [dbo].[Hiring] ([RecordRef], [HireID], [UserID], [VehicleId], [Rate], [WithDriver], [WithoutDriver], [IsAvailable], [Location], [Status]) VALUES (1, N'1', N'a', N'1', 5, 1, 1, 0, N'Colombo', N'ONLINE')
INSERT [dbo].[Hiring] ([RecordRef], [HireID], [UserID], [VehicleId], [Rate], [WithDriver], [WithoutDriver], [IsAvailable], [Location], [Status]) VALUES (2, N'2', N'a', N'2', 40, 0, 1, 1, N'Kelaniya', N'OFFLINE')
INSERT [dbo].[Hiring] ([RecordRef], [HireID], [UserID], [VehicleId], [Rate], [WithDriver], [WithoutDriver], [IsAvailable], [Location], [Status]) VALUES (3, N'3', N'b', N'3', 50, 1, 1, 1, N'Galle', N'ONLINE')
INSERT [dbo].[Hiring] ([RecordRef], [HireID], [UserID], [VehicleId], [Rate], [WithDriver], [WithoutDriver], [IsAvailable], [Location], [Status]) VALUES (7, N'', N's', N'4', 40, 1, 1, 1, N'Col', N'ONLINE')
INSERT [dbo].[Hiring] ([RecordRef], [HireID], [UserID], [VehicleId], [Rate], [WithDriver], [WithoutDriver], [IsAvailable], [Location], [Status]) VALUES (8, N'HI14', N'a', N'5', 50, 1, 1, 0, N'Laa', N'ONLINE')
INSERT [dbo].[Hiring] ([RecordRef], [HireID], [UserID], [VehicleId], [Rate], [WithDriver], [WithoutDriver], [IsAvailable], [Location], [Status]) VALUES (9, N'HI15', N'a', N'VID3', 40, 1, 1, 1, N'Colombo', N'ONLINE')
INSERT [dbo].[Hiring] ([RecordRef], [HireID], [UserID], [VehicleId], [Rate], [WithDriver], [WithoutDriver], [IsAvailable], [Location], [Status]) VALUES (10, N'HI16', N'a', N'VID4', 48, 1, 0, 0, N'mathale', N'OFFLINE')
INSERT [dbo].[Hiring] ([RecordRef], [HireID], [UserID], [VehicleId], [Rate], [WithDriver], [WithoutDriver], [IsAvailable], [Location], [Status]) VALUES (11, N'HI17', N'b', N'VID5', 45, 1, 1, 0, N'kelaniya', N'ONLINE')
SET IDENTITY_INSERT [dbo].[Hiring] OFF
SET IDENTITY_INSERT [dbo].[Vehical] ON 

INSERT [dbo].[Vehical] ([RecordRef], [UserId], [VehicleId], [Brand], [Model], [WithAC], [NoOfSeats], [OtherOption]) VALUES (1, N's', N'1', N'Nissan', N'64', 1, 34, N'gwdbgd')
INSERT [dbo].[Vehical] ([RecordRef], [UserId], [VehicleId], [Brand], [Model], [WithAC], [NoOfSeats], [OtherOption]) VALUES (2, N's', N'2', N'Tpyota', N'52', 0, 52, N'ftvggy')
INSERT [dbo].[Vehical] ([RecordRef], [UserId], [VehicleId], [Brand], [Model], [WithAC], [NoOfSeats], [OtherOption]) VALUES (3, N'b', N'3', N'Nissan', N'13a', 1, 60, N'')
INSERT [dbo].[Vehical] ([RecordRef], [UserId], [VehicleId], [Brand], [Model], [WithAC], [NoOfSeats], [OtherOption]) VALUES (4, N's', N'4', N'Mazda', N'2017', 1, 4, N'gdgd')
INSERT [dbo].[Vehical] ([RecordRef], [UserId], [VehicleId], [Brand], [Model], [WithAC], [NoOfSeats], [OtherOption]) VALUES (5, N'a', N'5', N'Mit', N'2018', 1, 4, N'jd')
INSERT [dbo].[Vehical] ([RecordRef], [UserId], [VehicleId], [Brand], [Model], [WithAC], [NoOfSeats], [OtherOption]) VALUES (6, N's', N'VID2', N'wertyu', N'ddtt', 0, 56, N'drty')
INSERT [dbo].[Vehical] ([RecordRef], [UserId], [VehicleId], [Brand], [Model], [WithAC], [NoOfSeats], [OtherOption]) VALUES (9, N'b', N'VID5', N'Toyota', N'Corolla', 1, 4, N'Car')
INSERT [dbo].[Vehical] ([RecordRef], [UserId], [VehicleId], [Brand], [Model], [WithAC], [NoOfSeats], [OtherOption]) VALUES (7, N'a', N'VID3', N'Toyota', N'2018', 1, 4, N'Car')
INSERT [dbo].[Vehical] ([RecordRef], [UserId], [VehicleId], [Brand], [Model], [WithAC], [NoOfSeats], [OtherOption]) VALUES (8, N'a', N'VID4', N'Nissan', N'Sunny', 1, 5, N'Car')
SET IDENTITY_INSERT [dbo].[Vehical] OFF
SET IDENTITY_INSERT [dbo].[VehicleOwner] ON 

INSERT [dbo].[VehicleOwner] ([RecordRef], [UserId], [Name], [Email], [TelephoneNo1], [TelephoneNo2]) VALUES (1, N'a', N'Perera', N'perera@gmail.com', N'0772451213', N'')
INSERT [dbo].[VehicleOwner] ([RecordRef], [UserId], [Name], [Email], [TelephoneNo1], [TelephoneNo2]) VALUES (2, N'b', N'Nishan', N'nishan@gmail.com', N'0712453636', N'')
SET IDENTITY_INSERT [dbo].[VehicleOwner] OFF
