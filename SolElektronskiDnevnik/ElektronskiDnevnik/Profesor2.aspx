<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profesor2.aspx.cs" Inherits="ElektronskiDnevnik.Profesor2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Одаберите предмет: "></asp:Label>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ElDnevnik2ConnectionString %>" SelectCommand="PrikazPredmetaZaProfesora" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="ProfesorID" SessionField="Korisnik" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:DropDownList ID="ddlPredmeti" runat="server" DataSourceID="SqlDataSource1" DataTextField="Naziv" DataValueField="Naziv">
        </asp:DropDownList>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Одаберите одељење: "></asp:Label>
        <br />
        <asp:DropDownList ID="ddlOdeljenja" runat="server">
        </asp:DropDownList>
        <p>
            <asp:Button ID="btnPrikazUcenika" runat="server" OnClick="btnPrikazUcenika_Click" Text="Прикажи ученике" />
        </p>
        <asp:DropDownList ID="ddlUcenici" runat="server">
        </asp:DropDownList>
        <p>
            <asp:Button ID="btnPrikazOcena" runat="server" OnClick="btnOceni_Click" Text="Прикажи оцене" />
            <asp:Button ID="btnDetaljiOUcniku" runat="server" OnClick="btnDetaljiOUcniku_Click" Text="Детаљи о ученику" />
        </p>
        <asp:GridView ID="gvOceneUcenika" runat="server">
        </asp:GridView>
    </form>
</body>
</html>
