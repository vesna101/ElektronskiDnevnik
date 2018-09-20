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
    public partial class UcenikDetalji : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblProba.Text = Session["Ucenik"].ToString();
            
            string MaticniBroj; //Kako izvuci maticni broj ucenika?
            int PredmetID;

            MaticniBroj = Session["Ucenik"].ToString();
            PredmetID = 8;

            PristupBazi pb = new PristupBazi();
            DataTable DTOcene = pb.PrikazOcena(MaticniBroj, PredmetID);
            gvOcene.DataSource = DTOcene;
            gvOcene.DataBind();


        }
    }
}