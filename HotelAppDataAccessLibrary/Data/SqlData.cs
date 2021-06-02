using HotelAppDataAccessLibrary.Databases;
using HotelAppDataAccessLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelAppDataAccessLibrary.Data
{
   
    public class SqlData
    {
        private readonly ISqlDataAccess _sqlDataAccess;
        private const string connectionStringName = "SqlDataBase";

        public SqlData(ISqlDataAccess sqlDataAccess)
        {
            _sqlDataAccess = sqlDataAccess;
        }

        public List<RoomTypeModel> GetAvailableRoomTypes(DateTime startDate, DateTime endDate)
        {
           return _sqlDataAccess.LoadData<RoomTypeModel, dynamic>("dbo.spRoomTypes_GetAvailableTypes",
                                                            new { startDate, endDate },
                                                            connectionStringName,
                                                            true);
        }

        public void BookGuest(string firstName,
                              string lastName,
                              DateTime startDate,
                              DateTime endDate,
                              int roomTypeId)
        {
            GuestModel guest = _sqlDataAccess.LoadData<GuestModel, dynamic>("dbo.spGuests_Insert",
                                                                            new {firstName, lastName },
                                                                            connectionStringName,
                                                                            true).FirstOrDefault();

            RoomTypeModel roomType = _sqlDataAccess.LoadData<RoomTypeModel, dynamic> ("SELECT * FROM dbo.RoomTypes WHERE Id = @Id",
                                                                             new { Id = roomTypeId },
                                                                             connectionStringName,
                                                                             false).First();

            TimeSpan timeStaying = endDate.Date.Subtract(startDate.Date);
            
            List<RoomModel> availableRooms = _sqlDataAccess.LoadData<RoomModel, dynamic>("dbo.spRooms_GetAvailableRooms",
                                                                                         new { startDate, endDate, roomTypeId },
                                                                                         connectionStringName,
                                                                                         true);
            _sqlDataAccess.SaveData("dbo.spBookings_Insert",
                                    new { 
                                        roomId = availableRooms.First().Id,
                                        guestId = guest.Id,
                                        startDate = startDate,
                                        endDate = endDate,
                                        totalCost = timeStaying.Days * roomType.Price
                                        },
                                    connectionStringName,
                                    true);
            
        }

    }
}
