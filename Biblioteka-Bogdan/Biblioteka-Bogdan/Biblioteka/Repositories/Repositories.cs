﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;

namespace Repositories
{
    public class Repository
    {
        public static List<string> GetListOfCategories()
        {
            return DatabaseOperations.GetListOfString("Biblioteka_Get_Category_Names", null);
        }

        public List<Pozycja> GetListPositionsForCategories(string nazwaKategorii)
        {
            return DatabaseOperations.GetCollection<Pozycja>("Biblioteka_Get_Pozycje_W_Kategorii", new { s = nazwaKategorii });
        }

        public bool GetAvailabilityForPosition(int idPozycji)
        {
            return DatabaseOperations.GetScalar<bool>("Biblioteka_Get_Dostepnosc_Pozycji", new { id = idPozycji });
        }

        public List<Pozycja> GetListOfDetailsPosition(int idPozycji)
        {
            return DatabaseOperations.GetCollection<Pozycja>("Biblioteka_Get_Szczegoly_O_Pozycji", new { idPoz = idPozycji });
        }

        public DMLResult ReturnBook(int idPozycji, int idCzytelnika)
        {
            return DatabaseOperations.SimpleDML("Biblioteka_Oddaj_Ksiazke", new { idPoz = idPozycji, idCzyt = idCzytelnika });
        }

        public DMLResult OrderBook(int idPozycji, int idCzytelnika)
        {
            return DatabaseOperations.SimpleDML("Biblioteka_Wypozycz_Pozycje", new { idPoz = idPozycji, idCzyt = idCzytelnika });
        }

        public DMLResult AddReader(Czytelnik czytelnik)
        {
            return DatabaseOperations.SimpleDML("Biblioteka_Dodaj_Uzytkownika", new { imie = czytelnik.Imie,
                                                                                      nazwisko = czytelnik.Nazwisko,
                                                                                      miejscowosc = czytelnik.Miejscowosc,
                                                                                      adres = czytelnik.Adres,
                                                                                      pesel = czytelnik.Pesel,

                telefon = czytelnik.Telefon});
        }
    }
}
