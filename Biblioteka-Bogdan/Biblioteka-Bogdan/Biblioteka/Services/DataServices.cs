using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Repositories;
using Models;

namespace Services
{
    public class DataServices
    {
        public List<string> GetListOfCategories()
        {
            return DatabaseOperations.GetListOfString("Biblioteka_Get_Category_Names", null);
        }

        public List<Pozycja> GetListPositionsForCategories(string nazwaKategorii)
        {
            return DatabaseOperations.GetCollection<Pozycja>("Biblioteka_Get_Pozycje_W_Kategorii", new { s = nazwaKategorii });
        }

        public bool GetAvailabilityForPosition(int idPozycji)
        {
            return DatabaseOperations.GetScalar<bool>("Biblioteka_Get_Dostepnosc_Pozycji", new { id = idPozycji});
        }

        public DMLResult ReturnBook(int idPozycji, int idCzytelnika)
        {
            return DatabaseOperations.SimpleDML("Biblioteka_Get_Oddaj_Ksiazke", new { idPoz = idPozycji, idCzyt = idCzytelnika });
        }
    }
}
