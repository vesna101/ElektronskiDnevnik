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
                
                List<string> ListaOdeljenja = new List<string>();
                ListaOdeljenja = pb.PrikazOdeljenjaZaProfesora(profID);
                ddlOdeljenja.DataSource = ListaOdeljenja;
                ddlOdeljenja.DataBind();


            }

        }

        protected void btnPrikazUcenika_Click(object sender, EventArgs e)
        {
            PristupBazi pb = new PristupBazi();
            
            List<string> ListaUcenika = new List<string>();

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
            }

            ddlUcenici.DataSource = DTUcenici;

            //ListaUcenika = pb.PrikazUcenikaZaProfesora(ProfesorID, PredmetID, OdeljenjeID);
            //ddlUcenici.DataSource = ListaUcenika;
            ddlUcenici.DataBind();

            

        }

        protected void btnOceni_Click(object sender, EventArgs e)
        {
            PristupBazi pb = new PristupBazi();
            string MaticniBroj;
            int PredmetID;
            // kako pokupiti vrednosti iz dropdown lista?
            MaticniBroj = "1111112";
            PredmetID = 8;
            
            DataTable DTOcene = pb.PrikazOcenaPoPredmetu(MaticniBroj, PredmetID);
            gvOceneUcenika.DataSource = DTOcene;
            gvOceneUcenika.DataBind();
        }

        protected void btnDetaljiOUcniku_Click(object sender, EventArgs e)
        {
            string Ucenik = ddlUcenici.SelectedItem.ToString();
            Session["Ucenik"] = Ucenik;
            Response.Redirect("UcenikDetalji.aspx");
        }
    }
}