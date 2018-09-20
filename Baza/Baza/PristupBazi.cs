using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace Baza
{
    public class PristupBazi
    {
        SqlConnection Cn = new SqlConnection();
        SqlCommand Cm = new SqlCommand();
        

        //konstruktori klase
        public PristupBazi()
        {
            Cn.ConnectionString = "server=.;integrated security=true;database=ElDnevnik2";
        }
        public PristupBazi(string ConStr)
        {
            Cn.ConnectionString = ConStr;
        }

        //metode za proveru login ucenika
        public int LoginUcenika(string KorisnickoIme, string Sifra)
        {
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.LoginUc";

            Cm.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null)); //proveriti
            Cm.Parameters.AddWithValue("@username", KorisnickoIme);
            Cm.Parameters.AddWithValue("@sifra", Sifra);

            Cn.Open();
            Cm.ExecuteNonQuery();
            Cn.Close();
            return (int)Cm.Parameters["@RETURN_VALUE"].Value;
        }

        public int LoginProfesora(string KorisnickoIme, string Sifra)
        {
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.LoginProf";

            Cm.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null)); //proveriti
            Cm.Parameters.AddWithValue("@username", KorisnickoIme);
            Cm.Parameters.AddWithValue("@sifra", Sifra);

            Cn.Open();
            Cm.ExecuteNonQuery();
            Cn.Close();
            return (int)Cm.Parameters["@RETURN_VALUE"].Value;
        }


        public DataTable PrikazOcena(string MaticniBroj)
        {
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.PrikazOcena";
            Cm.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null)); //proveriti
            Cm.Parameters.AddWithValue("@MaticniBroj", MaticniBroj);

            SqlDataAdapter DA = new SqlDataAdapter(Cm);
            
            DataTable DT = new DataTable();

            DA.Fill(DT);

            Cn.Open();
            Cm.ExecuteNonQuery();
            Cn.Close();

            return DT;

        }


        public DataTable PrikazOcena(string MaticniBroj, int PredmetID) //overload
        {
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.PrikazOcena2";
            Cm.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null)); //proveriti
            Cm.Parameters.AddWithValue("@MaticniBroj", MaticniBroj);
            Cm.Parameters.AddWithValue("@PredmetID", PredmetID);

            SqlDataAdapter DA = new SqlDataAdapter(Cm);

            DataTable DT = new DataTable();

            DA.Fill(DT);

            Cn.Open();
            Cm.ExecuteNonQuery();
            Cn.Close();

            return DT;

        }




        public SqlDataReader PrikazPredmetaZaProfesoraDr(int ProfesorID)
        {
            //List<string> Predmeti = new List<string>();
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.PrikazPredmetaZaProfesora";
            Cm.Parameters.AddWithValue("@ProfesorID", ProfesorID);
            Cn.Open();
            SqlDataReader DRPredmeti = Cm.ExecuteReader();
            Cn.Close();
            return DRPredmeti;

        }



      


        public List<string> PrikazPredmetaZaProfesoraL(int ProfesorID)
        {
            List<string> Predmeti = new List<string>();
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.PrikazPredmetaZaProfesora";
            Cm.Parameters.AddWithValue("@ProfesorID", ProfesorID);
            Cn.Open();
            SqlDataReader DRPredmeti = Cm.ExecuteReader();
            while (DRPredmeti.Read())
            {
                Predmeti.Add(DRPredmeti["Naziv"].ToString());
            }
            Cn.Close();
            return Predmeti;

        }



        public List<string> PrikazOdeljenjaZaProfesora(int ProfesorID)
        {
            List<string> Odeljenja = new List<string>();
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.PrikazOdeljenja";
            Cm.Parameters.AddWithValue("@ProfesorID", ProfesorID);
            Cn.Open();
            SqlDataReader DROdeljenja = Cm.ExecuteReader();
            while (DROdeljenja.Read())
            {
                Odeljenja.Add(DROdeljenja["Razred"].ToString() + "/" + DROdeljenja["RedniBrOd"].ToString());
            }
            Cn.Close();
            return Odeljenja;

        }


        public DataTable PrikazOdeljenjaZaProfesoraDT(int ProfesorID)
        {
            //List<string> Odeljenja = new List<string>();
            DataTable Odeljenja = new DataTable();
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.PrikazOdeljenja";
            Cm.Parameters.AddWithValue("@ProfesorID", ProfesorID);
            Cn.Open();
            SqlDataAdapter DAOdeljenja = new SqlDataAdapter(Cm);
            DAOdeljenja.Fill(Odeljenja);
            Cn.Close();
            return Odeljenja;

        }




        public int LoginKorisnika(string KorisnickoIme, string Sifra)
        {
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.LoginKorisnika";

            Cm.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null)); //proveriti
            Cm.Parameters.AddWithValue("@Username", KorisnickoIme);
            Cm.Parameters.AddWithValue("@Sifra", Sifra);

            Cn.Open();
            Cm.ExecuteNonQuery();
            Cn.Close();
            return (int)Cm.Parameters["@RETURN_VALUE"].Value;
        }


        //public List<string> PrikazPredmetaZaProfesoraL(int ProfesorID)
        //{
        //    List<string> Predmeti = new List<string>();
        //    Cm.Connection = Cn;
        //    Cm.CommandType = CommandType.StoredProcedure;
        //    Cm.CommandText = "dbo.PrikazPredmetaZaProfesora";
        //    Cm.Parameters.AddWithValue("@ProfesorID", ProfesorID);
        //    Cn.Open();
        //    SqlDataReader DRPredmeti = Cm.ExecuteReader();
        //    while (DRPredmeti.Read())
        //    {
        //        Predmeti.Add(DRPredmeti["Naziv"].ToString());
        //    }
        //    Cn.Close();
        //    return Predmeti;

        //}
        public List<string> PrikazUcenikaZaProfesora (int ProfesorID, int PredmetID, int OdeljenjeID)
        {
            List<string> Ucenici = new List<string>();
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.PrikazUcenikaZaProfesora2";
            Cm.Parameters.AddWithValue("@ProfesorID", ProfesorID);
            Cm.Parameters.AddWithValue("@PredmetID", PredmetID);
            Cm.Parameters.AddWithValue("@OdeljenjeID", OdeljenjeID);
            Cn.Open();
            SqlDataReader DRUcenici = Cm.ExecuteReader();
            while (DRUcenici.Read())
            {
                Ucenici.Add(DRUcenici["Ime"].ToString() + " " + DRUcenici["Prezime"].ToString());
            }
            Cn.Close();
            return Ucenici;
        }



        //metoda za unos ocene:
        public int UnosOcene (string TipOcene, int Ocena, DateTime DatumOcene, string MaticniBroj, int ProfesorID, int PredmetID)
        {
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.OceneDnevnikINSERT2";

            Cm.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null)); //proveriti
            Cm.Parameters.AddWithValue("@TipOcene", TipOcene);
            Cm.Parameters.AddWithValue("@Ocena", Ocena);
            Cm.Parameters.AddWithValue("@DatumOcene", DatumOcene);
            Cm.Parameters.AddWithValue("@MaticniBroj", MaticniBroj);
            Cm.Parameters.AddWithValue("@ProfesorID", ProfesorID);
            Cm.Parameters.AddWithValue("@PredmetID", PredmetID);


            Cn.Open();
            Cm.ExecuteNonQuery();
            Cn.Close();
            return (int)Cm.Parameters["@RETURN_VALUE"].Value;
        }

        //metoda za prikaz ocena po predmetu
        public DataTable PrikazOcenaPoPredmetu(string MaticniBroj, int PredmetID) // moze i overload
        {
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.PrikazOcena2";
            Cm.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null)); //proveriti
            Cm.Parameters.AddWithValue("@MaticniBroj", MaticniBroj);
            Cm.Parameters.AddWithValue("@PredmetID", PredmetID);

            SqlDataAdapter DA = new SqlDataAdapter(Cm);

            DataTable DT = new DataTable();

            DA.Fill(DT);

            Cn.Open();
            Cm.ExecuteNonQuery();
            Cn.Close();

            return DT;

        }


        public DataTable PrikazUcenikaZaProfesoraDT(int ProfesorID, int PredmetID, int OdeljenjeID)
        {
            DataTable DTUcenici = new DataTable();
            Cm.Connection = Cn;
            Cm.CommandType = CommandType.StoredProcedure;
            Cm.CommandText = "dbo.PrikazUcenikaZaProfesora2";
            Cm.Parameters.AddWithValue("@ProfesorID", ProfesorID);
            Cm.Parameters.AddWithValue("@PredmetID", PredmetID);
            Cm.Parameters.AddWithValue("@OdeljenjeID", OdeljenjeID);
            
            SqlDataAdapter DAUcenici = new SqlDataAdapter(Cm);
            DAUcenici.Fill(DTUcenici);
            Cn.Open();
            Cm.ExecuteNonQuery();
            Cn.Close();
            return DTUcenici;

        }


    }
}
