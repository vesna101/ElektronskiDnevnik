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
    public partial class Ucenik : System.Web.UI.Page
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
                DataTable dtOcene = pb.PrikazOcena(Session["Korisnik"].ToString());
                GVOcene.DataSource = dtOcene;
                GVOcene.DataBind();

                //uraditi odabir ocena po predmetu
            }

        }
    }
}