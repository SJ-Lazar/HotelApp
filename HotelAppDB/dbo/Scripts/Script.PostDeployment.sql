/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

IF NOT EXISTS (SELECT 1 FROM dbo.RoomTypes)
BEGIN
    INSERT INTO dbo.RoomTypes(Title, Description, Price)
    VALUES ('Luxuary', 'A room with a king-size bed.', 500),
           ('Luxuary Suite', 'Two rooms, each with a king-size bed.', 700),
           ('Economy', 'Two rooms, one with a queen Size bed and one with two single beds.', 350),
           ('Standard', 'A room with one double Size bed.', 250),
           ('Basic', 'A rooom with a single bed', 150);
END

IF NOT EXISTS (SELECT 1 FROM dbo.Rooms)
BEGIN

    DECLARE @roomId1 INT;
    DECLARE @roomId2 INT;
    DECLARE @roomId3 INT;
    DECLARE @roomId4 INT;
    DECLARE @roomId5 INT;
   

    SELECT @roomId1 = Id FROM dbo.RoomTypes WHERE Title = 'Luxuary';
    SELECT @roomId2 = Id FROM dbo.RoomTypes WHERE Title = 'Luxuary Suite';
    SELECT @roomId3 = Id FROM dbo.RoomTypes WHERE Title = 'Economy';
    SELECT @roomId4 = Id FROM dbo.RoomTypes WHERE Title = 'Standard';
    SELECT @roomId5 = Id FROM dbo.RoomTypes WHERE Title = 'Basic';
  

    INSERT INTO dbo.Rooms(RoomNumber, RoomTypeId)
    VALUES  ('101',@roomId1),
            ('102',@roomId1),
            ('201',@roomId2),
            ('202',@roomId2),
            ('301',@roomId4),
            ('401',@roomId5);
END

