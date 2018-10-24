using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using DevExpress.Web.ASPxGridView;

public partial class Grid_MasterDetail_SelectDetailRows_Default : System.Web.UI.Page {
	protected override void OnLoad(EventArgs e) {
		base.OnLoad(e);
		if(!IsPostBack) {
			master.DataBind();
			master.DetailRows.ExpandRow(0);
		}
	}

	protected void detail_BeforePerformDataSelect(object sender, EventArgs e) {
		detailData.SelectParameters["CategoryID"].DefaultValue = (sender as ASPxGridView).GetMasterRowKeyValue().ToString();
	}
	protected void master_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e) {		
		string[] data = e.Parameters.Split('|');
		if(data.Length == 3 && data[0] == "select")
			ProcessSelection(int.Parse(data[1]), data[2] == "T");		
	}

	void ProcessSelection(int index, bool state) {
		master.DataBind();
		master.Selection.SetSelection(index, state);
		ASPxGridView detail = master.FindDetailRowTemplateControl(index, "detail") as ASPxGridView;
		if(detail != null) {
			if(state)
				detail.Selection.SelectAll();
			else
				detail.Selection.UnselectAll();
		}
	}
}
