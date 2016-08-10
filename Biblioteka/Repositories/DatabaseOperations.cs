using Dapper;
using DataOperationsLibrary.DataResultsClass;
using DataOperationsLibrary.Extensions;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories
{
    public class DatabaseOperations
    {
        private static readonly string _sConnectionString = "Server=Tsteodserver01v;Database=testy;Trusted_Connection=True;";

        public static T GetObject<T>(string storedProcedure, object args)
        where T : class, new()
        {
            T result = default(T);

            using (SqlConnection connection = new SqlConnection(DatabaseOperations._sConnectionString))
            {

                var queryResult = connection.Query<T>(storedProcedure, args, commandType: CommandType.StoredProcedure);

                if (queryResult.HasValue())
                {
                    result = queryResult.AsEnumerable().FirstOrDefault();
                }

            }


            return result;
        }

        public static List<T> GetCollection<T>(string storedProcedure, object args)
    where T : class, new()
        {
            List<T> result = new List<T>();

            using (SqlConnection connection = new SqlConnection(DatabaseOperations._sConnectionString))
            {

                var queryResult = connection.Query<T>(storedProcedure, args, commandType: CommandType.StoredProcedure);

                if (queryResult.HasValue())
                {
                    result = queryResult.AsEnumerable().ToList<T>();
                }

            }

            return result;
        }

        public static T GetScalar<T>(string storedProcedure, object args)
        where T : struct
        {
            T result = default(T);

            using (SqlConnection connection = new SqlConnection(DatabaseOperations._sConnectionString))
            {

                var queryResult = connection.Query<T>(storedProcedure, args, commandType: CommandType.StoredProcedure);

                if (queryResult.HasValue())
                {
                    result = queryResult.FirstOrDefault<T>();
                }

            }

            return result;
        }

        public static List<T> GetDMLClassesCollection<T>(string query)
        where T : class, new()
        {

            List<T> result = new List<T>();

            using (SqlConnection connection = new SqlConnection(DatabaseOperations._sConnectionString))
            {

                var queryResult = connection.Query<T>(query, commandType: CommandType.Text);

                if (queryResult.HasValue())
                {
                    result = queryResult.AsEnumerable<T>().ToList<T>();
                }

            }

            return result;
        }


        public static DMLResult SimpleDML(string storedProcedure)
        {
            DMLResult result = new DMLResult(0, 0, 0);

            using (SqlConnection connection = new SqlConnection(DatabaseOperations._sConnectionString))
            {

                var queryResult = connection.Query<DMLResult>(storedProcedure, commandType: CommandType.StoredProcedure);

                if (queryResult.HasValue())
                {
                    result = queryResult.FirstOrDefault();
                }

            }

            return result;

        }


    }
}
