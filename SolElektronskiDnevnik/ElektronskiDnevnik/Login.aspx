<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ElektronskiDnevnik.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="Матични број ученика / ИД професора: "></asp:Label>
        <asp:TextBox ID="txtIDBroj" runat="server"></asp:TextBox>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Шифра: "></asp:Label>
            <asp:TextBox ID="txtSifra" runat="server" TextMode="Password"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Пријава" />
        </p>
        <asp:Label ID="lblPorukaLogin" runat="server"></asp:Label>
    </form>
</body>
</html>
