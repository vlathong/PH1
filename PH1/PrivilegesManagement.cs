using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Oracle.ManagedDataAccess.Client;

namespace PH1
{
    public partial class PrivilegesManagement : Form
    {
        OracleConnection conn;
        OracleCommand cmd;
        OracleDataReader dr;
        DataTable dt;
        public PrivilegesManagement()
        {
            InitializeComponent();
        }

        private void dataGridView4_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            dataGridView4.CurrentCell.Selected = true;
            textBox4.Text = dataGridView4.Rows[e.RowIndex].Cells["column_name"].Value.ToString();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DialogResult dlr = MessageBox.Show("ALLOW THIS USER TO GRANT THE SAME PRIVILEGE TO ROLES OR OTHER USERS?", "WITH GRANT OPTION", MessageBoxButtons.YesNo);
            string ConnectionString = "Data Source = (DESCRIPTION =" +
                    "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                    "(CONNECT_DATA =" +
                    "(SERVER = DEDICATED)" +
                    "(SERVICE_NAME = XE)" +
                    ")" +
                    ");User Id = ph1; password = 123;";

            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            cmd = new OracleCommand("sp_GrantSelectOnTable", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            if (textBox1.Text != "")
            {
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
            }
            else
            {
                cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;
            }
            cmd.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;
            cmd.Parameters.Add("column_name", OracleDbType.Varchar2).Value = textBox4.Text;

            if (dlr == DialogResult.Yes && textBox2.Text == "")
            {
                cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 1;
            }
            else if (dlr == DialogResult.No)
            {
                cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 0;
            }
            dataGridView4.CurrentCell.Selected = true;
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            MessageBox.Show("PRIVILEGE GRANTED SUCCESSFULLY!");
            conn.Close();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.Hide();
            MainMenu back = new MainMenu();
            back.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";
            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            string pls = "select username from dba_users where username not in ('ANONYMOUS','APEX_040200','APEX_PUBLIC_USER','APPQOSSYS','AUDSYS','BI','CTXSYS','DBSNMP','DIP','DVF','DVSYS','EXFSYS','FLOWS_FILES','GSMADMIN_INTERNAL','GSMCATUSER','GSMUSER','HR','IX','LBACSYS','MDDATA','MDSYS','OE','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','OUTLN','PM','SCOTT','SH','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','SYSBACKUP','SYSDG','SYSKM','SYSTEM','WMSYS','XDB','SYSMAN','RMAN','RMAN_BACKUP','OWBSYS','OWBSYS_AUDIT','APEX_030200','MGMT_VIEW','OJVMSYS','XS$NULL', 'DBSFWUSER', 'GGSYS', 'OLAPSYS','REMOTE_SCHEDULER_AGENT', 'SYSRAC', 'GSMROOTUSER', 'DGPDB_INT', 'SYS$UMF')";
            cmd = new OracleCommand(pls, conn);
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            dataGridView1.DataSource = dt;
            string pls1 = "SELECT role FROM DBA_ROLES where role_id between 116 and 10000";
            cmd = new OracleCommand(pls1, conn);
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            dataGridView2.DataSource = dt;
            string pls2 = "SELECT table_name FROM user_tables";
            cmd = new OracleCommand(pls2, conn);
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            dataGridView3.DataSource = dt;
            conn.Close();
        }

        

        private void button3_Click(object sender, EventArgs e)
        {
            DialogResult dlr = MessageBox.Show("ALLOW THIS USER TO GRANT THE SAME PRIVILEGE TO ROLES OR OTHER USERS?", "WITH GRANT OPTION", MessageBoxButtons.YesNo);
            DialogResult dlr1 = MessageBox.Show("ALLOW THIS USER/ROLE TO SELECT?", "GRANT SELECT", MessageBoxButtons.YesNo);

            string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            if (dlr1 == DialogResult.Yes)
            {
                OracleConnection conn1;
                conn1 = new OracleConnection();
                conn1.ConnectionString = ConnectionString;
                conn1.Open();

                OracleCommand cmd1 = new OracleCommand("sp_prSelect", conn);
                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;
                if (textBox1.Text == "")
                {
                    cmd1.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;
                }
                else
                {
                    cmd1.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
                }


                OracleDataReader dr1 = cmd1.ExecuteReader();
                DataTable dt1 = new DataTable();
                dt1.Load(dr1);
                conn1.Close();
            }
            else if (dlr1 == DialogResult.No)
            {
                conn.Close();
            }
            OracleCommand cmd = new OracleCommand("SP_UPDATE", conn);
            //cmd = new OracleCommand("sp_Update", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            if (textBox1.Text != "")
            {
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
            }
            else
            {
                cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;
            }

            cmd.Parameters.Add("column_name", OracleDbType.Varchar2).Value = textBox4.Text;
            cmd.Parameters.Add("table_name", OracleDbType.Varchar2).Value = textBox3.Text;

            if (dlr == DialogResult.Yes)
            {
                cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 1;
            }
            else if (dlr == DialogResult.No)
            {
                cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 0;
            }
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            MessageBox.Show("PRIVILEGE GRANTED SUCCESSFULLY!");
            conn.Close();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            DialogResult dlr = MessageBox.Show("ALLOW THIS USER TO GRANT THE SAME PRIVILEGE TO ROLES OR OTHER USERS?", "WITH GRANT OPTION", MessageBoxButtons.YesNo);
            DialogResult dlr1 = MessageBox.Show("ALLOW THIS USER/ROLE TO SELECT?", "GRANT SELECT", MessageBoxButtons.YesNo);

            string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            if (dlr1 == DialogResult.Yes)
            {
                OracleConnection conn1;
                conn1 = new OracleConnection();
                conn1.ConnectionString = ConnectionString;
                conn1.Open();

                OracleCommand cmd1 = new OracleCommand("sp_prSelect", conn);
                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;
                if (textBox1.Text == "")
                {
                    cmd1.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;
                }
                else
                {
                    cmd1.Parameters.Add("User id", OracleDbType.Varchar2).Value = textBox1.Text;
                }


                OracleDataReader dr1 = cmd1.ExecuteReader();
                DataTable dt1 = new DataTable();
                dt1.Load(dr1);
                conn1.Close();
            }
            else if (dlr1 == DialogResult.No)
            {
                conn.Close();
            }
            cmd = new OracleCommand("sp_Delete", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            if (textBox1.Text != "")
            {
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
            }
            else
            {
                cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;
            }

            cmd.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;


            if (dlr == DialogResult.Yes)
            {
                cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 1;
            }
            else if (dlr == DialogResult.No)
            {
                cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 0;
            }
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            MessageBox.Show("PRIVILEGE GRANTED SUCCESSFULLY!");
            conn.Close();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            DialogResult dlr = MessageBox.Show("ALLOW THIS USER TO GRANT THE SAME PRIVILEGE TO ROLES OR OTHER USERS?", "WITH GRANT OPTION", MessageBoxButtons.YesNo);
            string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            cmd = new OracleCommand("sp_Insert", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            if (textBox1.Text != "")
            {
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
            }
            else
            {
                cmd.Parameters.Add("role", OracleDbType.Varchar2).Value =textBox2.Text;
            }

            cmd.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;

            if (dlr == DialogResult.Yes)
            {
                cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 1;
            }
            else if (dlr == DialogResult.No)
            {
                cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 0;
            }
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            MessageBox.Show("PRIVILEGE GRANTED SUCCESSFULLY!");
            conn.Close();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            cmd = new OracleCommand("sp_RevokeSelect", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            if (textBox1.Text != "")
            {
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
            }
            else
            {
                cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;

            }
            cmd.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            MessageBox.Show("PRIVILEGE REVOKED SUCCESSFULLY!");
            conn.Close();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            cmd = new OracleCommand("sp_RevokeDelete", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            if (textBox1.Text != "")
            {
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
            }
            else
            {
                cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;

            }
            cmd.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            MessageBox.Show("PRIVILEGE REVOKED SUCCESSFULLY!");
            conn.Close();
        }

        private void button8_Click(object sender, EventArgs e)
        {
            string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            cmd = new OracleCommand("sp_RevokeUpdate", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            if (textBox1.Text != "")
            {
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
            }
            else
            {
                cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;

            }
            cmd.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            MessageBox.Show("PRIVILEGE REVOKED SUCCESSFULLY!");
            conn.Close();
        }

        private void button10_Click(object sender, EventArgs e)
        {
            string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            cmd = new OracleCommand("sp_RevokeInsert", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            if (textBox1.Text != "")
            {
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
            }
            else
            {
                cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;

            }
            cmd.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            MessageBox.Show("PRIVILEGE REVOKED SUCCESSFULLY!");
            conn.Close();
        }

        private void button15_Click(object sender, EventArgs e)
        {
            try
            {
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();
                cmd = new OracleCommand("sp_CheckUserPrivilegeOnCollumn", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                dataGridView3.DataSource = dt;
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }

        private void button16_Click(object sender, EventArgs e)
        {
            try
            {
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();
                cmd = new OracleCommand("sp_CheckUserPrivilegeOnTable", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                dataGridView3.DataSource = dt;
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }

        }

        private void dataGridView1_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {
            dataGridView1.CurrentCell.Selected = true;
            textBox1.Text = dataGridView1.Rows[e.RowIndex].Cells["username"].Value.ToString();
        }

        private void dataGridView2_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {
            dataGridView2.CurrentCell.Selected = true;
            textBox2.Text = dataGridView2.Rows[e.RowIndex].Cells["role"].Value.ToString();
        }

        private void dataGridView3_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {
           dataGridView3.CurrentCell.Selected = true;
            textBox3.Text = dataGridView3.Rows[e.RowIndex].Cells["table_name"].Value.ToString();

            string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            string pls2 = "select column_name from USER_TAB_COLUMNS where table_name = '" + dataGridView3.Rows[e.RowIndex].Cells["table_name"].Value.ToString() + "'";
            cmd = new OracleCommand(pls2, conn);
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            dataGridView4.DataSource = dt;

        }

        private void button17_Click(object sender, EventArgs e)
        {
            try
            {
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();
                cmd = new OracleCommand("sp_CheckRolePrivilegeOnTable", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                dataGridView3.DataSource = dt;
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }

        private void button13_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult dlr = MessageBox.Show("ALLOW THIS USER TO GRANT THE SAME PRIVILEGE TO ROLES OR OTHER USERS?", "WITH GRANT OPTION", MessageBoxButtons.YesNo);
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();
                cmd = new OracleCommand("sp_ModifyUpdate", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                if (textBox1.Text != "")
                {
                    cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
                }
                else
                {
                    cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;
                }
                cmd.Parameters.Add("column_name", OracleDbType.Varchar2).Value = textBox4.Text;
                cmd.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;

                if (dlr == DialogResult.Yes)
                {
                    cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 1;
                }
                else if (dlr == DialogResult.No)
                {
                    cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 0;
                }
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                MessageBox.Show("PRIVILEGE MODIFIED SUCCESSFULLY!");
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }

        private void button14_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult dlr = MessageBox.Show("ALLOW THIS USER TO GRANT THE SAME PRIVILEGE TO ROLES OR OTHER USERS?", "WITH GRANT OPTION", MessageBoxButtons.YesNo);
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();
                cmd = new OracleCommand("sp_ModifyInsert", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                if (textBox1.Text != "")
                {
                    cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
                }
                else
                {
                    cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;
                }
                cmd.Parameters.Add("column_name", OracleDbType.Varchar2).Value = textBox4.Text;
                cmd.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;

                if (dlr == DialogResult.Yes)
                {
                    cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 1;
                }
                else if (dlr == DialogResult.No)
                {
                    cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 0;
                }
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                MessageBox.Show("PRIVILEGE MODIFIED SUCCESSFULLY!");
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }

        private void button12_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult dlr = MessageBox.Show("ALLOW THIS USER TO GRANT THE SAME PRIVILEGE TO ROLES OR OTHER USERS?", "WITH GRANT OPTION", MessageBoxButtons.YesNo);
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();
                cmd = new OracleCommand("sp_ModifyDelete", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                if (textBox1.Text != "")
                {
                    cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
                }
                else
                {
                    cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;
                }
                cmd.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;

                if (dlr == DialogResult.Yes)
                {
                    cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 1;
                }
                else if (dlr == DialogResult.No)
                {
                    cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 0;
                }
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                MessageBox.Show("PRIVILEGE MODIFIED SUCCESSFULLY!");
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }

        private void button11_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult dlr = MessageBox.Show("ALLOW THIS USER TO GRANT THE SAME PRIVILEGE TO ROLES OR OTHER USERS?", "WITH GRANT OPTION", MessageBoxButtons.YesNo);
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                   "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                   "(CONNECT_DATA =" +
                   "(SERVER = DEDICATED)" +
                   "(SERVICE_NAME = XE)" +
                   ")" +
                   ");User Id = ph1; password = 123;";

                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();
                cmd = new OracleCommand("sp_ModifySelect", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                if (textBox1.Text != "")
                {
                    cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
                }
                else
                {
                    cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox2.Text;
                }

                cmd.Parameters.Add("tablename", OracleDbType.Varchar2).Value = textBox3.Text;
                cmd.Parameters.Add("column_name", OracleDbType.Varchar2).Value = textBox4.Text;

                if (dlr == DialogResult.Yes)
                {
                    cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 1;
                }
                else if (dlr == DialogResult.No)
                {
                    cmd.Parameters.Add("grant_option", OracleDbType.Int32).Value = 0;
                }
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                MessageBox.Show("PRIVILEGE MODIFIED SUCCESSFULLY!");
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }
    }
    
}
