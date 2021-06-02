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

        

    }
}
