<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ucenik.aspx.cs" Inherits="ElektronskiDnevnik.Ucenik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="Ovo ce videti ucenik"></asp:Label>
        <asp:GridView ID="GVOcene" runat="server">
        </asp:GridView>
    </form>
</body>
</html>
