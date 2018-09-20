using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Baza;

namespace ElektronskiDnevnik
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string Username = txtIDBroj.Text;
            string Sifra = txtSifra.Text;
            PristupBazi pb = new PristupBazi();
            int ret = pb.LoginKorisnika(Username, Sifra);
            if (ret == 3)
            {
                Session["Korisnik"] = Username;
                Response.Redirect("Ucenik.aspx");
            }
            else if (ret == 2) //admin na istoj strani ili zasebnoj?
            {
                Session["Korisnik"] = Username;
                Response.Redirect("Profesor2.aspx"); 
            }
            else if (ret == 1)
            {
                Session["Korisnik"] = Username;
                Response.Redirect("Admin.aspx");
            }
            else
            {
                lblPorukaLogin.Text = "Greska";
            }

        }
    }
}