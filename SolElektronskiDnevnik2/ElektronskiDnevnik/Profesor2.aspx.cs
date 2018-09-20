using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Baza;
using System.Data;
using System.Data.SqlClient;

namespace ElektronskiDnevnik
{
    public partial class Profesor2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Korisnik"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                PristupBazi pb = new PristupBazi();
                int profID = Convert.ToInt32(Session["Korisnik"]);
                
                //List<string> ListaOdeljenja = new List<string>();
                //ListaOdeljenja = pb.PrikazOdeljenjaZaProfesora(profID);
                //ddlOdeljenja.DataSource = ListaOdeljenja;
                //ddlOdeljenja.DataBind();

                List<string> ListaOdeljenja = new List<string>();
                DataTable OdeljenjaDT = new DataTable();
                OdeljenjaDT = pb.PrikazOdeljenjaZaProfesoraDT(profID);

                for (int i=0; i<OdeljenjaDT.Rows.Count; i++)
                {
                    ListaOdeljenja.Add( OdeljenjaDT.Rows[i]["Razred"].ToString() + "/" + OdeljenjaDT.Rows[i]["RedniBrOd"].ToString());
                }

                ddlOdeljenja.DataSource = ListaOdeljenja;
                ddlOdeljenja.DataBind();


            }

        }

        protected void btnPrikazUcenika_Click(object sender, EventArgs e)
        {
            PristupBazi pb = new PristupBazi();
            
            List<string> ListaUcenika = new List<string>();
            //List<Ucenikk> ListaUcenikaIzKlase = new List<Ucenikk>();

            DataTable DTUcenici = new DataTable();
            int ProfesorID, PredmetID, OdeljenjeID;
            ProfesorID = Convert.ToInt32(Session["Korisnik"]);
            //PredmetID = //kako pozvati vrednost odabrane stavke iz padajuce liste?
            //OdeljenjeID = ...
            PredmetID = 8;
            OdeljenjeID = 1;

            DTUcenici = pb.PrikazUcenikaZaProfesoraDT(ProfesorID, PredmetID, OdeljenjeID);

            for (int i = 0; i < DTUcenici.Rows.Count; i++)
            {

                ListaUcenika.Add(DTUcenici.Rows[i]["Ime"].ToString() + " " + DTUcenici.Rows[i]["Prezime"].ToString());
                //ListaUcenika.Add(DTUcenici.Rows[i][1].ToString() + " " + DTUcenici.Rows[i][2].ToString());

                //ListaUcenikaIzKlase.Add(new Ucenikk
                //{
                //    MaticniBroj = DTUcenici.Rows[i]["MaticniBroj"].ToString(),
                //    Ime = DTUcenici.Rows[i]["Ime"].ToString(),
                //    Prezime = DTUcenici.Rows[i]["Prezime"].ToString()

                //});
            }

            //ddlUcenici.DataSource = DTUcenici;
            ddlUcenici.DataSource = ListaUcenika;

            //ddlUcenici.DataSource = ListaUcenikaIzKlase;

            //ListaUcenika = pb.PrikazUcenikaZaProfesora(ProfesorID, PredmetID, OdeljenjeID);
            

            ddlUcenici.DataBind();

            

        }

        

        protected void btnDetaljiOUcniku_Click(object sender, EventArgs e)
        {
            string ucenik = ddlUcenici.SelectedItem.ToString();
            string MaticniBroj = "1111112";
            Session["Ucenik"] = MaticniBroj;
            Response.Redirect("UcenikDetalji.aspx");
        }

        protected void btnPrikazOcena_Click(object sender, EventArgs e)
        {
            PristupBazi pb = new PristupBazi();
            DataTable DT = pb.PrikazOcena("1111112", 8);
            gvOceneUcenika.DataSource = DT;
            gvOceneUcenika.DataBind();
        }
    }
}