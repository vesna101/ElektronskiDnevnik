using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Baza;


namespace ElektronskiDnevnik
{
    public partial class Profesor : System.Web.UI.Page
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
                int profID = Convert.ToInt32 (Session["Korisnik"]);

                List<string> ListaPredmeta = new List<string>();
                ListaPredmeta = pb.PrikazPredmetaZaProfesoraL(profID);
                ddlListaPredmeta.DataSource = ListaPredmeta;
                ddlListaPredmeta.DataBind();

                List<string> ListaOdeljenja = new List<string>();
                ListaOdeljenja = pb.PrikazOdeljenjaZaProfesora(profID);
                ddlListaOdeljenja.DataSource = ListaOdeljenja;
                ddlListaOdeljenja.DataBind();

                //rade SP pojedinacno, ali zajedno daju
                //Procedure or function PrikazOdeljenja has too many arguments specified

                
            }
        }

        
    }
}