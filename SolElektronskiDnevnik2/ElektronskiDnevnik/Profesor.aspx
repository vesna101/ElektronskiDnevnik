<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profesor.aspx.cs" Inherits="ElektronskiDnevnik.Profesor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="Ovo ce videti profesor"></asp:Label>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Одаберите предмет: "></asp:Label>
            <asp:DropDownList ID="ddlListaPredmeta" runat="server">
            </asp:DropDownList>
        </p>
        <asp:Label ID="Label3" runat="server" Text="Одаберите одељење: "></asp:Label>
        <asp:DropDownList ID="ddlListaOdeljenja" runat="server">
        </asp:DropDownList>
        <p>
            <asp:Label ID="lblProvera" runat="server"></asp:Label>
        </p>
    </form>
</body>
</html>
