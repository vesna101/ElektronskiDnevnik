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
            <asp:Button ID="btnPrikazOcena" runat="server" OnClick="btnPrikazOcena_Click" Text="Прикажи оцене" />
            <asp:Button ID="btnDetaljiOUcniku" runat="server" OnClick="btnDetaljiOUcniku_Click" Text="Детаљи о ученику" />
        </p>
        <asp:GridView ID="gvOceneUcenika" runat="server" AutoGenerateColumns="False" DataKeyNames="Матични број ученика" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:BoundField DataField="Матични број ученика" HeaderText="Матични број ученика" ReadOnly="True" SortExpression="Матични број ученика" />
                <asp:BoundField DataField="Име ученика" HeaderText="Име ученика" SortExpression="Име ученика" />
                <asp:BoundField DataField="Презиме ученика" HeaderText="Презиме ученика" SortExpression="Презиме ученика" />
                <asp:BoundField DataField="Оцена" HeaderText="Оцена" SortExpression="Оцена" />
                <asp:BoundField DataField="Тип оцене" HeaderText="Тип оцене" SortExpression="Тип оцене" />
                <asp:BoundField DataField="PredmetID" HeaderText="PredmetID" SortExpression="PredmetID" />
                <asp:BoundField DataField="Предмет" HeaderText="Предмет" SortExpression="Предмет" />
                <asp:BoundField DataField="ProfesorID" HeaderText="ProfesorID" SortExpression="ProfesorID" />
                <asp:BoundField DataField="Професор" HeaderText="Професор" SortExpression="Професор" />
                <asp:BoundField DataField="Датум" HeaderText="Датум" SortExpression="Датум" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ElDnevnik2ConnectionString2 %>" SelectCommand="PrikazOcena2" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlUcenici" Name="MaticniBroj" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="ddlPredmeti" Name="PredmetID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
