CREATE PROCEDURE [dbo].[spRooms_GetAvailableRooms]
	@startDate date,
	@endDate date,
	@roomTypeId int

AS
BEGIN
	SET NOCOUNT ON;

	SELECT [r].[Id], [r].[RoomNumber], [r].[RoomTypeId]
	FROM dbo.Rooms r

	--Join room table to roomtypes table
	INNER JOIN dbo.RoomTypes t 
	ON t.Id = r.RoomTypeId
	WHERE r.RoomTypeId = @roomTypeId AND r.Id NOT IN (
	SELECT b.RoomId 
	FROM dbo.Bookings b

	--Checking for rooms types that are avaliable that dont have bookings bookings 
	WHERE (@StartDate < b.StartDate AND @endDate > b.EndDate)
	OR (b.StartDate <= @endDate AND @endDate < b.EndDate)
	OR (b.StartDate <= @startDate AND @startDate < b.StartDate)
	);
END
