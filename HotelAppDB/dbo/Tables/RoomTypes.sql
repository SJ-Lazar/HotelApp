﻿CREATE TABLE [dbo].[RoomTypes]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Title] NVARCHAR(50) NOT NULL, 
    [Description ] NVARCHAR(500) NOT NULL, 
    [Price] MONEY NOT NULL
)
