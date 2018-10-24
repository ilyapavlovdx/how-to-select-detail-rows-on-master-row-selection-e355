<%-- BeginRegion Page setup --%>
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Grid_MasterDetail_SelectDetailRows_Default" %>
<%@ Register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%-- EndRegion --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>How to select detail rows on master row selection</title>
</head>
<body>
    <form id="form1" runat="server">
		<script type="text/javascript">
			function master_RowSelecting(index, state) {
				master.PerformCallback("select|" + index + "|" + (state ? "T" : ""));
			}
		</script>
		<dxwgv:ASPxGridView ID="master" runat="server" AutoGenerateColumns="False" DataSourceID="masterData" KeyFieldName="CategoryID"
			ClientInstanceName="master" OnCustomCallback="master_CustomCallback">
			<SettingsDetail ShowDetailRow="True" />
			<Columns>
				<%-- BeginRegion Custom selection check --%>
				<dxwgv:GridViewDataColumn VisibleIndex="0">
					<DataItemTemplate>
						<input type="checkbox"
							onclick="master_RowSelecting(<%# Container.VisibleIndex %>, checked)" 
							<%# master.Selection.IsRowSelected(Container.VisibleIndex) ? "checked=\"checked\"" : "" %> />
					</DataItemTemplate>
				</dxwgv:GridViewDataColumn>
				<%-- EndRegion --%>
				<dxwgv:GridViewDataTextColumn FieldName="CategoryID" ReadOnly="True" VisibleIndex="1">
					<EditFormSettings Visible="False" />
				</dxwgv:GridViewDataTextColumn>
				<dxwgv:GridViewDataTextColumn FieldName="CategoryName" VisibleIndex="2">
				</dxwgv:GridViewDataTextColumn>
			</Columns>
			<%-- BeginRegion Templates --%>
			<Templates>
				<DetailRow>
					<dxwgv:ASPxGridView ID="detail" runat="server" AutoGenerateColumns="False"
						DataSourceID="detailData" KeyFieldName="ProductID" OnBeforePerformDataSelect="detail_BeforePerformDataSelect">
						<Columns>
							<dxwgv:GridViewCommandColumn ShowSelectCheckbox="true" VisibleIndex="0" />
							<dxwgv:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" VisibleIndex="1">
								<EditFormSettings Visible="False" />
							</dxwgv:GridViewDataTextColumn>
							<dxwgv:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="2">
							</dxwgv:GridViewDataTextColumn>
							<dxwgv:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="3">
							</dxwgv:GridViewDataTextColumn>
						</Columns>
					</dxwgv:ASPxGridView>
				</DetailRow>
			</Templates>
			<%-- EndRegion --%>
		</dxwgv:ASPxGridView>
		
		<%-- BeginRegion DataSources --%>
		<asp:AccessDataSource ID="masterData" runat="server" DataFile="~/App_Data/nwind.mdb"
			SelectCommand="SELECT [CategoryID], [CategoryName] FROM [Categories]"></asp:AccessDataSource>			
		<asp:AccessDataSource ID="detailData" runat="server" DataFile="~/App_Data/nwind.mdb"
			SelectCommand="SELECT [ProductID], [ProductName], [UnitPrice] FROM [Products] WHERE CategoryID = ?">
			<SelectParameters>				
				<asp:Parameter Name="CategoryID" />				
			</SelectParameters>
		</asp:AccessDataSource>
		<%-- EndRegion --%>			
    </form>
</body>
</html>
