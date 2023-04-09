using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.Odbc;


namespace PH1
{
    public partial class MainMenu : Form
    {

        public MainMenu()
        {
            InitializeComponent();
        }
        private void button3_Click(object sender, EventArgs e)
        {
            this.Hide();
            UserRoleManagement userrolemanagement = new UserRoleManagement();
            userrolemanagement.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.Hide();
            PrivilegesManagement grantPrivileges = new PrivilegesManagement();
            grantPrivileges.Show();
        }
    }
}
