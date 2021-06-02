CREATE PROCEDURE [dbo].[spRoomTypes_GetAvailableTypes]
	@startDate date,
	@endDate date


AS
BEGIN

	--Dont return rows that are affected
	SET NOCOUNT ON;

	SELECT t.Id, t.Title, t.[Description ], t.Price
	FROM dbo.Rooms r

	--Join room table to roomtypes table
	INNER JOIN dbo.RoomTypes t 
	ON t.Id = r.RoomTypeId
	WHERE r.Id NOT IN (
	SELECT b.RoomId 
	FROM dbo.Bookings b

	--Checking for rooms types that are avaliable that dont have bookings bookings 
	WHERE (@StartDate < b.StartDate AND @endDate > b.EndDate)
	OR (b.StartDate <= @endDate AND @endDate < b.EndDate)
	OR (b.StartDate <= @startDate AND @startDate < b.StartDate)
	)

	--Remove duplicate 
	GROUP BY t.Id, t.Title, t.[Description ], t.Price

END
